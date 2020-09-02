import ArgumentParser
import Foundation

enum AlternativeOutputStyle: EnumerableFlag {
    case phrase
    case urbit
}

struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generates a lowercase alphanumeric password."
    )
    
    @Flag(help: "Generate a passphrase instead.")
    var alternativeOutputStyle: AlternativeOutputStyle?
    
    @Argument(help: "The desired security level.")
    var securityLevel: UInt = 128
    
    mutating func run() {
        switch alternativeOutputStyle {
        case nil:
            let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
            let bitsPerCharacter = log2(Float64(characters.count))
            let characterCount = Int((Float64(securityLevel) / bitsPerCharacter).rounded(.up))
            print(String((0..<characterCount).map { _ in characters.randomElement()! }))
            
        case .phrase:
            let bitsPerWord = log2(Float64(words.count))
            let wordCount = Int((Float64(securityLevel) / bitsPerWord).rounded(.up))
            print((0..<wordCount).map { _ in words.randomElement()! }.joined(separator: "-"))
            
        case .urbit:
            assert(prefixes.count == 256)
            assert(suffixes.count == 256)
            let wordCount = (securityLevel + 15) / 16
            print((0..<wordCount).map { _ in
                prefixes.randomElement()! + suffixes.randomElement()!
            }.joined(separator: "-"))
        }
    }
}

Genpass.main()
