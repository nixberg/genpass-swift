import Numerics

public struct BasicGenerator: PasswordGenerator {
    let characterSet: Set<Character>
    let bitsPerCharacter: Float64
    
    public init(characterSet: Set<Character>) {
        precondition(characterSet.count >= 2)
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
