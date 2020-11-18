import Foundation

public struct GetConfigValue {
    var caseSensitive: Bool = false
    var filePath: String
    var setting: String

    public init(caseSensitive: Bool = false, filePath: String, setting: String) {
        self.caseSensitive = caseSensitive
        self.filePath = filePath
        self.setting = setting
    }

    public func run() throws {
        let url = URL(fileURLWithPath: filePath)
        let fileContents = try FileReader.readFileContents(from: url)

        var output: String?

        fileContents.enumerateLines(invoking: { [self] text, stop in
            if self.caseSensitive {
                guard text.lowercased().starts(with: self.setting) else { return }
            } else {
                guard text.starts(with: self.setting) else { return }
            }

            output = text
                .split(separator: "=")
                .map { String($0) }
                .last?
                .trimmingCharacters(in: .whitespaces)
        })

        guard let echo = output else {
            throw XCConfigError.settingNotFound
        }

        print(echo)
    }
}
