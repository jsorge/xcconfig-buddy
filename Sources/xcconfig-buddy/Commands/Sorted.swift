import ArgumentParser
import ConfigKit
import Foundation

extension XcconfigBuddy {
    struct Sorted: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: """
            Sorts the build settings in a given configuration file alphabetically and writes them back out to the same \
            file. Any header comments and imports are preserved, but whitespace between settings is removed.
            """
        )

        @Argument(help: "The path to the config file to modify")
        var filePath: String

        mutating func run() throws {
            let sorted = SortConfigValues(filePath: filePath)
            try sorted.run()
        }
    }
}
