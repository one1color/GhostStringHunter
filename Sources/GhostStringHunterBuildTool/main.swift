import Foundation
import GhostStringHunter

func main() {
    // Your implementation for detecting unused localized strings goes here.
    // You can use FileManager to scan the project directory for .strings and source files.
    // Then, parse the .strings files to get the keys and search for their usage in the source files.
    // Finally, print out the list of unused keys.
    let warningFilePath = "localizeTest/Localizable.strings"
    let warningLineNumber = 2
    let warningColumnNumber = 5
    let warningMessage = "Unused localized string detected"
    print("warning: GhostStringHunterBuildTool is running. (This is a test warning)")
}

main()
