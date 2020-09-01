import ArgumentParser
import Foundation

struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generates a lowercase alphanumeric password."
    )
    
    @Argument(help: "The desired security level.")
    var securityLevel: UInt = 128
    
    @Flag(help: "Generate a passphrase instead.")
    var phrase: Bool = false
    
    mutating func run() {
        if phrase {
            let bitsPerWord = log2(Float64(words.count))
            let wordCount = Int((Float64(securityLevel) / bitsPerWord).rounded(.up))
            print((0..<wordCount).map { _ in words.randomElement()! }.joined(separator: "-"))
        } else {
            let characters = "abcdefghijklmnopqrstuvwxyz0123456789"
            let bitsPerCharacter = log2(Float64(characters.count))
            let characterCount = Int((Float64(securityLevel) / bitsPerCharacter).rounded(.up))
            print(String((0..<characterCount).map { _ in characters.randomElement()! }))
        }
    }
}

Genpass.main()
