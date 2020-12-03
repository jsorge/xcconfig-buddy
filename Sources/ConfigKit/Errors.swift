import Foundation

public enum XCConfigError: Error {
    case invalidFilepath
    case notXcconfig
    case unreadableFile
    case unwritableFile
    case settingNotFound
    case settingIsNotIncrementable
}
