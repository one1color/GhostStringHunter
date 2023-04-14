import GhostStringHunter

let projectPath = CommandLine.arguments[1]
let ghostStringHunter = GhostStringHunter()
let unusedStrings = ghostStringHunter.findUnusedStrings(in: projectPath)

for unusedString in unusedStrings {
    print(unusedString)
}

