public protocol PasswordGenerator {
    func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String
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
