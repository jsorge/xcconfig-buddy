import Foundation

public struct IncrementConfigValue {
    var caseSensitive: Bool = false
    var filePath: String
    var setting: String
    var incrementBy: Int

    public init(caseSensitive: Bool = false, filePath: String, setting: String, incrementBy: Int) {
        self.caseSensitive = caseSensitive
        self.filePath = filePath
        self.setting = setting
        self.incrementBy = incrementBy
    }

    public func run() throws {
        let getter = GetConfigValue(caseSensitive: caseSensitive, filePath: filePath, setting: setting)
        let setting = try getter.run()

        guard let asNumber = Int(setting) else {
            throw XCConfigError.settingIsNotIncrementable
        }

        let newValue = asNumber + incrementBy

        let setter = SetConfigValue(
            caseSensitive: caseSensitive,
            filePath: filePath,
            setting: setting,
            newValue: "\(newValue)"
        )

        try setter.run()
    }
}
