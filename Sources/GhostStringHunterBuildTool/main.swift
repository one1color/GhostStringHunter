import Foundation
import GhostStringHunter

func parseLocalizableStringsFile(atPath path: String) -> [(key: String, lineNumber: Int)] {
    guard let fileContent = try? String(contentsOfFile: path) else { return [] }

    var results: [(key: String, lineNumber: Int)] = []
    var currentLineNumber = 1

    let lines = fileContent.components(separatedBy: .newlines)
    for line in lines {
        let trimmedLine = line.trimmingCharacters(in: .whitespaces)
        if let range = trimmedLine.range(of: #"^"([\w_]+)"\s*=".*$"#, options: .regularExpression) {
            let key = String(trimmedLine[range].dropFirst().dropLast().trimmingCharacters(in: .whitespaces))
            results.append((key: key, lineNumber: currentLineNumber))
        }
        currentLineNumber += 1
    }

    return results
}

func main() {
    // Locate the Localizable.strings file
    let localizableStringsPath = "/path/to/LocalizeTest/Localizable.strings"

    // Parse the Localizable.strings file to find the keys and their corresponding line numbers
    let localizableKeysAndLineNumbers = parseLocalizableStringsFile(atPath: localizableStringsPath)

    // Add your logic to detect unused localized strings here
    // For demonstration purposes, let's assume you detect that the first key is unused
    if let unusedKey = localizableKeysAndLineNumbers.first {
        let warningFilePath = localizableStringsPath
        let warningLineNumber = unusedKey.lineNumber
        let warningColumnNumber = 1 // Column number is set to 1 since we don't have the exact column number
        let warningMessage = "Unused localized string key '\(unusedKey.key)' detected"

        // Output the warning message in Xcode's expected format
        print("\(warningFilePath):\(warningLineNumber):\(warningColumnNumber): warning: \(warningMessage)")
    }
}

main()
