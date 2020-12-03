import ArgumentParser
import ConfigKit
import Foundation

extension XcconfigBuddy {
    struct Increment: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: """
            Increments the given config setting. Default increment is 1. The config value must be an integer and not a \
            decimal number.
            """
        )

        @Flag(name: .shortAndLong,
              help: "Set the value using a case sensitive setting name")
        var caseSensitive: Bool = false

        @Argument(help: "The path to the config file to modify")
        var filePath: String

        @Argument(help: "The config setting to modify")
        var setting: String

        @Argument(help: "The amount to increment the setting by. Defaults to 1.")
        var incrementBy: Int = 1

        mutating func run() throws {
            let increment = IncrementConfigValue(caseSensitive: caseSensitive, filePath: filePath, setting: setting,
                                                 incrementBy: incrementBy)
            try increment.run()
        }
    }
}
