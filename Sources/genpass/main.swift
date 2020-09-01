import ArgumentParser
import Foundation

struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generates a lowercase alphanumeric password."
    )
    
    @Argument(help: "The desired security level.")
    var securityLevel: UInt = 128
    
    mutating func run() throws {
        let characterSet = "abcdefghijklmnopqrstuvwxyz0123456789"
        let bitsPerCharacter = log2(Float64(characterSet.count))
        let characterCount = Int((Float64(securityLevel) / bitsPerCharacter).rounded(.up))
        print(String((0..<characterCount).map { _ in characterSet.randomElement()! }))
    }
}

Genpass.main()
