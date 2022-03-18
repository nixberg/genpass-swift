struct Base32Generator: PasswordGenerator {
    let characterSet: Set<Character>
    
    init(characterSet: Set<Character> = .init("0123456789abcdefghjkmnpqrstuwxyz")) {
        precondition(characterSet.count == 32)
        self.characterSet = characterSet
    }
    
    func generatePassword<RNG>(
        atSecurityLevel securityLevel: Float64,
        using rng: inout RNG
    ) -> String where RNG: RandomNumberGenerator {
        let count = Int(roundingUp: securityLevel / 5)
        return String(characterSet.randomSampleWithReplacement(count: count, using: &rng))
    }
}
