import ArgumentParser
import ConfigKit
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
            var set = SetConfigValue(caseSensitive: caseSensitive,
                                     filePath: filePath,
                                     setting: setting,
                                     newValue: newValue)
            try set.run()
        }
    }
}
