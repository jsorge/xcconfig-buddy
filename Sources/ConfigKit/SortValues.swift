import Foundation

public struct SortConfigValues {
    var filePath: String

    public init(filePath: String) {
        self.filePath = filePath
    }

    public func run() throws {
        let url = URL(fileURLWithPath: filePath)
        let fileContents = try FileReader.readFileContents(from: url)

        let allLines = fileContents
            .split(separator: "\n")
            .map(String.init)

        var settingsLines = [String]()
        var firstSettingLineIndex = 0
        for (index, line) in allLines.enumerated() {
            let isSettingLine = line.contains("=")
            guard isSettingLine else { continue }

            if firstSettingLineIndex == 0 {
                firstSettingLineIndex = index - 1
            }

            settingsLines.append(line)
        }

        let sortedSettings = settingsLines.sorted(by: { $0 < $1 })
        let headerLines = Array(allLines[0...firstSettingLineIndex])

        let newFileLines = headerLines + ["\n"] + sortedSettings + ["\n"]
        let newFileContents = newFileLines.joined(separator: "\n")

        guard let updatedData = newFileContents.data(using: .utf8) else {
            throw XCConfigError.unwritableFile
        }

        let newWrapper = FileWrapper(regularFileWithContents: updatedData)
        try newWrapper.write(to: url, options: [.atomic], originalContentsURL: url)
    }
}
