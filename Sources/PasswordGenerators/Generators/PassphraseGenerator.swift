import Numerics

public struct PassphraseGenerator<Wordlist>: PasswordGenerator
where Wordlist: RandomAccessCollection, Wordlist.Element: StringProtocol {
    let wordlist: Wordlist
    let bitsPerWord: Float64
    
    public init(wordlist: Wordlist) {
        precondition(wordlist.count >= 2)
        precondition(wordlist.count == Set(wordlist).count)
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
