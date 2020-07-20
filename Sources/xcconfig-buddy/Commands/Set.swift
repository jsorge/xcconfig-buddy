import ArgumentParser
import Foundation

extension XcconfigBuddy {
    struct Set: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Sets the value of a given setting name. If the setting already exists, then the value will be updated. If it's a new setting, it will be appended to the end of the config file."
        )

        @Flag(name: .shortAndLong,
              help: "Set the value using a case sensitive setting name")
        var caseSensitive: Bool = false

        @Argument(help: "The path to the config file to modify")
        var filePath: String

        @Argument(help: "The config setting to modify")
        var setting: String

        @Argument(help: "The new value of the config setting")
        var newValue: String

        mutating func run() throws {
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
}
