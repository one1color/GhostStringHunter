import Foundation

// Helper function to find all .strings files in the project directory
func findAllStringsFiles(at directory: URL) -> [URL] {
    let fileManager = FileManager.default
    let enumerator = fileManager.enumerator(at: directory, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants])
    
    var stringsFiles: [URL] = []
    
    while let fileURL = enumerator?.nextObject() as? URL {
        if fileURL.pathExtension == "strings" {
            stringsFiles.append(fileURL)
        }
    }
    
    return stringsFiles
}

func parseStringsFile(at url: URL) -> [String: String] {
    guard let content = try? String(contentsOf: url, encoding: .utf8) else { return [:] }
    let pattern = #""(.+)"\s*=\s*"(.+)""#
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let nsRange = NSRange(content.startIndex..<content.endIndex, in: content)
    let matches = regex?.matches(in: content, options: [], range: nsRange) ?? []
    
    var keyValuePairs: [String: String] = [:]
    
    for match in matches {
        let keyRange = Range(match.range(at: 1), in: content)!
        let valueRange = Range(match.range(at: 2), in: content)!
        let key = String(content[keyRange])
        let value = String(content[valueRange])
        
        keyValuePairs[key] = value
    }
    
    return keyValuePairs
}

func findLocalizedStringsUsage(in fileURL: URL) -> Set<String> {
    guard let content = try? String(contentsOf: fileURL, encoding: .utf8) else { return [] }
    let pattern = #""([a-zA-Z0-9_]+)"\.localized"#
    let regex = try? NSRegularExpression(pattern: pattern, options: [])
    let nsRange = NSRange(content.startIndex..<content.endIndex, in: content)
    let matches = regex?.matches(in: content, options: [], range: nsRange) ?? []
    
    var usedKeys: Set<String> = []
    
    for match in matches {
        let keyRange = Range(match.range(at: 1), in: content)!
        let key = String(content[keyRange])
        usedKeys.insert(key)
    }
    
    return usedKeys
}

// Your implementation to detect and remove unused localized strings goes here
func detectAndRemoveUnusedLocalizedStrings(projectDirectory: URL) {
    let stringsFiles = findAllStringsFiles(at: projectDirectory)
    var allStrings: [String: String] = [:]
    
    for fileURL in stringsFiles {
        let keyValuePairs = parseStringsFile(at: fileURL)
        allStrings.merge(keyValuePairs) { (current, _) in current }
    }
    
    let fileManager = FileManager.default
    let enumerator = fileManager.enumerator(at: projectDirectory, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants])
    
    var usedKeys: Set<String> = []
    
    while let fileURL = enumerator?.nextObject() as? URL {
        if fileURL.pathExtension == "swift" {
            let fileUsedKeys = findLocalizedStringsUsage(in: fileURL)
            usedKeys.formUnion(fileUsedKeys)
        }
    }
    
    let unusedKeys = Set(allStrings.keys).subtracting(usedKeys)
    
    // Remove unused keys from .strings files and display a warning for each unused key
    for fileURL in stringsFiles {
        var keyValuePairs = parseStringsFile(at: fileURL)
        var removedKeys: [String] = []
        
        for unusedKey in unusedKeys {
            if let value = keyValuePairs.removeValue(forKey: unusedKey) {
                print("warning: Unused localized string '\(unusedKey)' found in \(fileURL.lastPathComponent)")
                removedKeys.append(unusedKey)
            }
        }
        
        // Save the updated .strings file
        if !removedKeys.isEmpty {
            let updatedContent = keyValuePairs.map { "\"\($0.key)\" = \"\($0.value)\";" }.joined(separator: "\n")
            try? updatedContent.write(to: fileURL, atomically: true, encoding: .utf8)
        }
    }
}


// Entry point
if CommandLine.arguments.count >= 2 {
    let projectDirectory = URL(fileURLWithPath: CommandLine.arguments[1], isDirectory: true)
    detectAndRemoveUnusedLocalizedStrings(projectDirectory: projectDirectory)
} else {
    print("Error: Please provide the path to your project directory.")
    exit(1)
}
