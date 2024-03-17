import OrderedCollections
import Numerics

public struct PassphraseGenerator<S: StringProtocol>: PasswordGenerator {
    let wordlist: OrderedSet<S>
    let bitsPerWord: Float64
    
    public init(wordlist: OrderedSet<S>) {
        precondition(wordlist.count >= 2)
        self.wordlist = wordlist
        bitsPerWord = .log2(Float64(wordlist.count))
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        wordlist.randomSampleWithReplacement(
            count: Int(roundingUp: securityLevel / bitsPerWord)!,
            using: &rng
        ).joined(separator: "-")
    }
}
