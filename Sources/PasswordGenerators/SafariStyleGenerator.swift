import Algorithms
import Numerics

public struct SafariStyleGenerator: PasswordGenerator {
    public init() {
        assert(Self.lowercaseLetters.count == 25)
        assert(Self.uppercaseLetters.count == 24)
        assert(Self.decimalDigits.count == 10)
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        // Note: Conservative estimate. Three blocks provide at least 82 bits.
        var characters = Self.lowercaseLetters.randomSampleWithReplacement(
            count: 6 * Int(roundingUp: ((securityLevel - .log2(24 * 10)) / .log2(25) + 2) / 6),
            using: &rng
        )
        
        let indices = characters.indices.shuffled(using: &rng).prefix(2)
        characters[indices[0]] = Self.uppercaseLetters.randomElement(using: &rng)!
        characters[indices[1]] = Self.decimalDigits.randomElement(using: &rng)!
        
        return String(characters.chunks(ofCount: 6).joined(separator: "-"))
    }
}

fileprivate extension SafariStyleGenerator {
    static let lowercaseLetters = Set("abcdefghijkmnopqrstuvwxyz")
    
    static let uppercaseLetters = Set("ABCDEFGHIJKMNPQRSTUVWXYZ")
    
    static let decimalDigits = Set("0123456789")
}
