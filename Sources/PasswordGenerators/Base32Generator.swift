public struct Base32Generator: PasswordGenerator {
    let base32Characters: Set<Character>
    
    public init(base32Characters: Set<Character> = Self.base32Characters) {
        precondition(base32Characters.count == 32)
        self.base32Characters = base32Characters
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        let count = Int(roundingUp: securityLevel / 5)
        return String(base32Characters.randomSampleWithReplacement(count: count, using: &rng))
    }
}

extension Base32Generator {
    public static let base32Characters = Set("0123456789abcdefghjkmnpqrstuwxyz")
}
