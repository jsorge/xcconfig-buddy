import Foundation

public struct SetConfigValue {
    var caseSensitive: Bool = false
    var filePath: String
    var setting: String
    var newValue: String

    public init(caseSensitive: Bool = false, filePath: String, setting: String, newValue: String) {
        self.caseSensitive = caseSensitive
        self.filePath = filePath
        self.setting = setting
        self.newValue = newValue
    }

    public mutating func run() throws {
        let url = URL(fileURLWithPath: filePath)
        var fileContents = try FileReader.readFileContents(from: url)

        var settingFound = false
        fileContents.enumerateLines(invoking: { [self] text, stop in
            if self.caseSensitive {
                guard text.lowercased().starts(with: self.setting) else { return }
            } else {
                guard text.starts(with: self.setting) else { return }
            }

            var lineArray = text.split(separator: "=").map({ String($0) })
            lineArray = lineArray.dropLast()
            lineArray.append("= \(self.newValue)")

            let newFullLine = lineArray.joined(separator: "")

            fileContents = fileContents.replacingOccurrences(of: text, with: newFullLine)
            settingFound = true
            stop = true
        })

        if settingFound == false {
            fileContents += """
            \(setting) = \(newValue)

            """
        }

        guard let updatedData = fileContents.data(using: .utf8) else {
            throw XCConfigError.unwritableFile
        }

        let newWrapper = FileWrapper(regularFileWithContents: updatedData)
        try newWrapper.write(to: url, options: [.atomic], originalContentsURL: url)
    }
}
