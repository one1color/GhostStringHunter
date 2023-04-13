import Foundation

@main
public struct GhostStringHunter {

    public init() {}
    public private(set) var text = "Hello, World"
    
    public static func main() {
        print(GhostStringHunter().text)
    }
    
    public func detectUnusedLocalizedStrings(projectDirectory: URL) -> [String] {
        // Find all Swift files in the project directory
        let swiftFiles = findFiles(withExtension: "swift", in: projectDirectory)

        // Extract localized string keys from all Swift files
        var usedKeys = Set<String>()
        for file in swiftFiles {
            let keys = extractLocalizedStrings(from: file)
            usedKeys.formUnion(keys)
        }

        // Find all .strings files in the project directory
        let stringsFiles = findFiles(withExtension: "strings", in: projectDirectory)

        // Read keys from .strings files and find unused ones
        var allKeys = Set<String>()
        for file in stringsFiles {
            let keys = extractLocalizedStrings(from: file)
            allKeys.formUnion(keys)
        }

        let unusedKeys = allKeys.subtracting(usedKeys)
        return Array(unusedKeys)
    }

    public func removeUnusedLocalizedStrings(projectDirectory: URL) {
        let unusedKeys = detectUnusedLocalizedStrings(projectDirectory: projectDirectory)

        // Find all .strings files in the project directory
        let stringsFiles = findFiles(withExtension: "strings", in: projectDirectory)

        for file in stringsFiles {
            // Read the .strings file content
            guard let fileContent = try? String(contentsOf: file, encoding: .utf8) else {
                continue
            }

            // Remove unused keys from the file content
            var newContent = fileContent
            for key in unusedKeys {
                // Regular expression pattern to match and remove unused keys
                let pattern = "^\(NSRegularExpression.escapedPattern(for: key))\\s*=\\s*\".*\";$"
                let regex = try? NSRegularExpression(pattern: pattern, options: [])
                let nsRange = NSRange(newContent.startIndex..<newContent.endIndex, in: newContent)
                newContent = regex?.stringByReplacingMatches(in: newContent, options: [], range: nsRange, withTemplate: "") ?? newContent
            }

            // Save the updated content to the .strings file
            try? newContent.write(to: file, atomically: true, encoding: .utf8)
        }
    }

    
    // Helper function to find all files with a specified extension
    private func findFiles(withExtension ext: String, in directory: URL) -> [URL] {
        let fileManager = FileManager.default
        let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: [.isRegularFileKey], options: [])

        var files: [URL] = []

        while let file = enumerator?.nextObject() as? URL {
            if file.pathExtension.lowercased() == ext {
                files.append(file)
            }
        }
        return files
    }
    
    
    // Helper function to extract localized strings from a file
    private func extractLocalizedStrings(from file: URL) -> Set<String> {
        guard let fileContent = try? String(contentsOf: file, encoding: .utf8) else {
            return Set<String>()
        }

        let localizedStringPattern = #"\"([a-zA-Z0-9_]+)\"\.localized\(\)"#
        let regex = try! NSRegularExpression(pattern: localizedStringPattern, options: [])

        let matches = regex.matches(in: fileContent, options: [], range: NSRange(location: 0, length: fileContent.utf16.count))

        var keys = Set<String>()

        for match in matches {
            if let keyRange = Range(match.range(at: 1), in: fileContent) {
                let key = String(fileContent[keyRange])
                keys.insert(key)
            }
        }
        return keys
    }

}


   

