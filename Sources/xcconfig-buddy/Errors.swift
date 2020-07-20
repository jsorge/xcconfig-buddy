import Foundation

enum XCConfigError: Error {
    case invalidFilepath
    case notXcconfig
    case unreadableFile
    case unwritableFile
}
