public protocol PasswordGenerator {
    associatedtype Output
    
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

extension BinaryInteger {
    init(roundingUp source: some BinaryFloatingPoint) {
        self.init(exactly: source.rounded(.up))!
    }
}

extension Collection {
    /// - Note: `Collection.randomElement(using:)` is not necessarily deterministic across Swift
    ///          versions.
    func randomSampleWithReplacement(
        count: Int,
        using rng: inout some RandomNumberGenerator
    ) -> [Element] {
        (0..<count).compactMap { _ in
            self.randomElement(using: &rng)
        }
    }
}
