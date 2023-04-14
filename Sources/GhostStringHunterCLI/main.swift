import GhostStringHunter
import Foundation

let ghostStringHunter = GhostStringHunter()

if CommandLine.arguments.count < 2 {
    print("Usage: ghoststringhunter /path/to/project")
} else {
    let projectPath = CommandLine.arguments[1]
    let unusedStrings = ghostStringHunter.findUnusedStrings(in: projectPath)
    print("Unused strings: \(unusedStrings)")
}

