import Numerics

public struct PassphraseGenerator: PasswordGenerator {
    let wordlist: Set<String>
    let bitsPerWord: Float64
    
    public init(wordlist: Set<String>) {
        precondition(wordlist.count >= 2)
        self.wordlist = wordlist
        bitsPerWord = .log2(Float64(wordlist.count))
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        wordlist.randomSampleWithReplacement(
            count: Int(roundingUp: securityLevel / bitsPerWord),
            using: &rng
        ).joined(separator: "-")
    }
}
