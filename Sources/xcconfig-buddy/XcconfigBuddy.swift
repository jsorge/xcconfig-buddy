import ArgumentParser
import Foundation

public struct XcconfigBuddy: ParsableCommand {
    public static var configuration = CommandConfiguration(
        commandName: "xcconfig",

        abstract: "A utility for getting and setting values in xcconfig files.",

        subcommands: [Get.self, Set.self, Increment.self, Sorted.self]
    )

    public init() {}
}
