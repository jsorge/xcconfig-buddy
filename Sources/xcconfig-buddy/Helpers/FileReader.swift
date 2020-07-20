import Foundation

enum FileReader {
    static func readFileContents(from url: URL) throws -> String {
        let fileWrapper = try FileWrapper(url: url, options: [])

        guard fileWrapper.isXcconfigFile else {
            throw XCConfigError.notXcconfig
        }

        guard let data = fileWrapper.regularFileContents, let fileContents = String(data: data, encoding: .utf8) else {
            throw XCConfigError.unreadableFile
        }

        return fileContents
    }
}

private extension FileWrapper {
    var isXcconfigFile: Bool {
        return filename?.lowercased().contains("xcconfig") == true
    }
}
