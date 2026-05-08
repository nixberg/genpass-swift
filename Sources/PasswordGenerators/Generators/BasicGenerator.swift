public import OrderedCollections

public struct BasicGenerator<S>: PasswordGenerator
where S: CustomStringConvertible & Hashable & Sendable {
    let symbols: OrderedSet<S>

    let separator: String

    let bitsPerSymbol: Float64

    public init?(symbols: OrderedSet<S>, separator: String) {
        guard symbols.count >= 2 else {
            return nil
        }
        self.symbols = symbols
        self.separator = separator
        bitsPerSymbol = Double(symbols.count._binaryLogarithm())
    }

    public func generatePassword(
        atSecurityLevel securityLevel: SecurityLevel,
        using generator: inout some RandomNumberGenerator,
    ) -> String {
        return symbols.randomSampleWithReplacement(
            count: securityLevel.elementCount(forBitsPerElement: bitsPerSymbol),
            using: &generator,
        ).lazy.map(String.init(describing:)).joined(separator: separator)
    }
}
