public protocol PasswordGenerator {
    associatedtype Output: LosslessStringConvertible
    
    func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> Output
}

extension PasswordGenerator {
    public func generatePassword(
        atSecurityLevel securityLevel: Float64
    ) -> Output {
        var rng = SystemRandomNumberGenerator()
        return self.generatePassword(atSecurityLevel: securityLevel, using: &rng)
    }
}
