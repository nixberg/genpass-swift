import Numerics

public struct PassphraseGenerator: PasswordGenerator {
    let words: Set<String>
    let bitsPerWord: Float64
    
    public init(words: Set<String>) {
        precondition(words.count >= 2)
        self.words = words
        bitsPerWord = .log2(Float64(words.count))
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        words.randomSampleWithReplacement(
            count: Int(roundingUp: securityLevel / bitsPerWord),
            using: &rng
        ).joined(separator: "-")
    }
}
