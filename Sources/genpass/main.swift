import ArgumentParser
import Foundation

struct Genpass: ParsableCommand {
    @Argument(default: 128, help: "The desired security level.")
    var securityLevel: UInt
    
    mutating func run() throws {
        let characterSet = "abcdefghijklmnopqrstuvwxyz0123456789"
        let bitsPerCharacter = log2(Float64(characterSet.count))
        let characterCount = UInt((Float64(securityLevel) / bitsPerCharacter).rounded(.up))
        print(String((0..<characterCount).map { _ in characterSet.randomElement()! }))
    }
}

Genpass.main()
