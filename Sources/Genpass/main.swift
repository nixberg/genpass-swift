import ArgumentParser
import Foundation

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
            let characters = Array("abcdefghijklmnopqrstuvwxyz0123456789")
            let bitsPerCharacter = log2(Float64(characters.count))
            let characterCount = Int((securityLevel / bitsPerCharacter).rounded(.up))
            print(String((0..<characterCount).map { _ in characters.randomElement()! }))
            
        case .phrase:
            let bitsPerWord = log2(Float64(words.count))
            let wordCount = Int((securityLevel / bitsPerWord).rounded(.up))
            print((0..<wordCount).map { _ in words.randomElement()! }.joined(separator: "-"))
            
        case .urbit:
            assert(prefixes.count == 256)
            assert(suffixes.count == 256)
            let wordCount = Int((securityLevel / 16).rounded(.up))
            print((0..<wordCount).map { _ in
                prefixes.randomElement()! + suffixes.randomElement()!
            }.joined(separator: "-"))
        }
    }
}

Genpass.main()
