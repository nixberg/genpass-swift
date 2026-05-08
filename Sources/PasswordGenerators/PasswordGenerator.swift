public protocol PasswordGenerator {
    associatedtype Output: StringProtocol

    func generatePassword(
        atSecurityLevel securityLevel: SecurityLevel,
        using generator: inout some RandomNumberGenerator,
    ) -> Output
}

extension PasswordGenerator {
    public func generatePassword(
        atSecurityLevel securityLevel: SecurityLevel,
    ) -> Output {
        var generator = SystemRandomNumberGenerator()
        return self.generatePassword(atSecurityLevel: securityLevel, using: &generator)
    }
}
