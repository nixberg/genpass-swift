import ArgumentParser

enum AlternativeOutputStyle: EnumerableFlag {
    case phrase
    case urbit
}

struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generates a lowercase alphanumeric password.")
    
    @Flag(help: "Generate a passphrase instead.")
    var alternativeOutputStyle: AlternativeOutputStyle?
    
    @Argument(help: "The desired security level.")
    var securityLevel: Float64 = 128
    
    func validate() throws {
        guard securityLevel > 0 else {
            throw ValidationError("Please specify a 'security-level' greater than 0.")
        }
    }
    
    func run() {
        switch alternativeOutputStyle {
        case nil:
            let characters = Array("abcdefghjkmnpqrstuwxyz0123456789") // Excluding "ilov".
            assert(characters.count == 32)
            assert(Set(characters).count == 32)
            let characterCount = Int((securityLevel / 5).rounded(.up))
            let password = String((0..<characterCount).map { _ in characters.randomElement()! })
            print(password)
            
        case .phrase:
            assert(words.count == 2048)
            assert(Set(words).count == 2048)
            let wordCount = Int((securityLevel / 11).rounded(.up))
            let password = (0..<wordCount)
                .map { _ in words.randomElement()! }
                .joined(separator: "-")
            print(password)
            
        case .urbit:
            assert(prefixes.count == 256)
            assert(suffixes.count == 256)
            assert(Set(prefixes).count == 256)
            assert(Set(suffixes).count == 256)
            assert(Set(prefixes).isDisjoint(with: suffixes))
            let wordCount = Int((securityLevel / 16).rounded(.up))
            let password = (0..<wordCount)
                .map { _ in prefixes.randomElement()! + suffixes.randomElement()! }
                .joined(separator: "-")
            print(password)
        }
    }
}

Genpass.main()
