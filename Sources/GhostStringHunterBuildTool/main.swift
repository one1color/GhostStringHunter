import Foundation
import GhostStringHunter

func findLocalizableStringsFiles(inDirectory directoryPath: String) -> [String] {
    let fileManager = FileManager.default
    guard let enumerator = fileManager.enumerator(atPath: directoryPath) else { return [] }

    var localizableStringsFiles: [String] = []
    while let filePath = enumerator.nextObject() as? String {
        if filePath.hasSuffix("Localizable.strings") {
            localizableStringsFiles.append(directoryPath + "/" + filePath)
        }
    }
    return localizableStringsFiles
}

func main() {
    // Locate the current directory path
    let currentDirectoryPath = FileManager.default.currentDirectoryPath

    // Find all Localizable.strings files in the project
    let localizableStringsFiles = findLocalizableStringsFiles(inDirectory: currentDirectoryPath)

    // Process each Localizable.strings file
    for localizableStringsPath in localizableStringsFiles {
        // Add your logic to detect unused localized strings here
        // For demonstration purposes, let's show a warning if a Localizable.strings file is found
        let warningFilePath = localizableStringsPath
        let warningLineNumber = 1 // Output the warning on the first line
        let warningColumnNumber = 1 // Column number is set to 1 since we don't have the exact column number
        let warningMessage = "Unused localized string detected"

        // Output the warning message in Xcode's expected format for the file
        print("\(warningFilePath):\(warningLineNumber):\(warningColumnNumber): warning: \(warningMessage)")

        // Output a warning message for the navigation bar
        print("warning: Localizable.strings file found at: \(localizableStringsPath)")
    }
}

main()
