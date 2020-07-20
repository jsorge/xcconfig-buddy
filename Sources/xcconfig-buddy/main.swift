import ArgumentParser
import Foundation

struct XcconfigBuddy: ParsableCommand {
    static var configuration = CommandConfiguration(
        commandName: "xcconfig",

        abstract: "A utility for getting and setting values in xcconfig files.",

        subcommands: [Get.self, Set.self]
    )
}

XcconfigBuddy.main()
