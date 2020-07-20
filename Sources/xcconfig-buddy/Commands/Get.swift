import ArgumentParser
import Foundation

extension XcconfigBuddy {
    struct Get: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Gets the value of a given setting name"
        )

        @Flag(name: .shortAndLong, help: "Indicates whether or not to ignore case on the setting name")
        var caseSensitive: Bool = false

        @Argument(help: "The path to the config file to modify")
        var filePath: String

        @Argument(help: "The config setting to modify")
        var setting: String

        mutating func run() throws {
            let url = URL(fileURLWithPath: filePath)
            let fileContents = try FileReader.readFileContents(from: url)

            fileContents.enumerateLines(invoking: { [self] text, stop in
                if self.caseSensitive {
                    guard text.lowercased().starts(with: self.setting) else { return }
                } else {
                    guard text.starts(with: self.setting) else { return }
                }

                let output = text
                    .split(separator: "=")
                    .map { String($0) }
                    .last?
                    .trimmingCharacters(in: .whitespaces)

                guard let echo = output else {
                    throw XCConfigError.settingNotFound
                }

                print(echo)
            })
        }
    }
}
