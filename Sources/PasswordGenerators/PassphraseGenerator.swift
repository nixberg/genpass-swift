import Numerics
import Foundation

public struct PassphraseGenerator: PasswordGenerator {
    let words: Set<String>
    
    public init(words: Set<String> = Self.englishWords) {
        precondition(words.count >= 2)
        self.words = words
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        let count = Int(roundingUp: securityLevel / .log2(Float64(words.count)))
        return words
            .randomSampleWithReplacement(count: count, using: &rng)
            .joined(separator: "-")
    }
}

extension PassphraseGenerator {
    public static let englishWords = {
        let url = Bundle.module.url(forResource: "BIP39/english", withExtension: "txt")!
        return Set(try! String(contentsOf: url).split(separator: "\n").map(String.init))
    }()
}
