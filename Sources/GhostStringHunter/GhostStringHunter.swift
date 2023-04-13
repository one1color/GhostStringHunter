@main
public struct GhostStringHunter {

    public init() {}

    public func detectUnusedLocalizedStrings(projectDirectory: URL) -> [String] {
        // Detection logic will be implemented here
    }

    public func removeUnusedLocalizedStrings(projectDirectory: URL) {
        // Removal logic will be implemented here
    }


    public private(set) var text = "Hello, World!"

    public static func main() {
        print(GhostStringHunter().text)
    }
}
