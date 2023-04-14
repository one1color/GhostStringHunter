
import Foundation

public struct GhostStringHunter {

    public init() {}

    public func findUnusedStrings(in projectPath: String) -> [String] {
        let fileManager = FileManager.default

        guard let enumerator = fileManager.enumerator(atPath: projectPath) else {
            print("Failed to enumerate project directory")
            return []
        }

        var stringFiles: [String] = []
        var sourceFiles: [String] = []
        
        for case let file as String in enumerator {
            if file.hasSuffix(".strings") {
                stringFiles.append(file)
            } else if file.hasSuffix(".swift") || file.hasSuffix(".m") || file.hasSuffix(".mm") {
                sourceFiles.append(file)
            }
        }

        var keys: Set<String> = []
        
        for stringFile in stringFiles {
            let filePath = projectPath + "/" + stringFile
            guard let fileContents = try? String(contentsOfFile: filePath, encoding: .utf8) else { continue }
            let matches = fileContents.matchingStrings(regex: "\"(.+?)\"\\s*=\\s*\".*?\";")

            for match in matches {
                guard let key = match.first else { continue }
                keys.insert(key)
            }
        }

        for sourceFile in sourceFiles {
            let filePath = projectPath + "/" + sourceFile
            guard let fileContents = try? String(contentsOfFile: filePath, encoding: .utf8) else { continue }

            keys = keys.filter { key in
                let pattern = "\"\\s*\\(key)\\s*\""
                return fileContents.range(of: pattern, options: .regularExpression) != nil
            }
        }

        return Array(keys)
    }
}

extension String {
    func matchingStrings(regex: String) -> [[String]] {
        guard let regex = try? NSRegularExpression(pattern: regex, options: []) else { return [] }
        let nsString = self as NSString
        let results = regex.matches(in: self, options: [], range: NSRange(location: 0, length: nsString.length))
        return results.map { result in
            (0..<result.numberOfRanges).map {
                result.range(at: $0).location != NSNotFound ? nsString.substring(with: result.range(at: $0)) : ""
            }
        }
    }
}

