import Numerics

public struct BasicGenerator<CharacterSet>: PasswordGenerator
where CharacterSet: RandomAccessCollection<Character> {
    let characterSet: CharacterSet
    let bitsPerCharacter: Float64
    
    public init(characterSet: CharacterSet) {
        precondition(characterSet.count >= 2)
        precondition(characterSet.count == Set(characterSet).count)
        self.characterSet = characterSet
        bitsPerCharacter = .log2(Float64(characterSet.count))
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        String(characterSet.randomSampleWithReplacement(
            count: Int(roundingUp: securityLevel / bitsPerCharacter),
            using: &rng
        ))
    }
}
