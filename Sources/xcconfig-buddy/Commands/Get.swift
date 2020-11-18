import ArgumentParser
import ConfigKit
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
            let get = GetConfigValue(caseSensitive: caseSensitive, filePath: filePath, setting: setting)
            try get.run()
        }
    }
}
