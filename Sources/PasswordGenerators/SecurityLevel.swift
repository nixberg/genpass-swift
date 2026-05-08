public struct SecurityLevel: Equatable, RawRepresentable, Sendable {
    public static let min = Self(unchecked: 0)

    public static let max = Self(unchecked: 32768)

    public let rawValue: Double

    private init(unchecked rawValue: Double) {
        self.rawValue = rawValue
    }

    public init?(rawValue: Double) {
        self.init(unchecked: rawValue)
        guard Self.min <= self, self <= Self.max else {
            return nil
        }
    }

    public func elementCount(forBitsPerElement bitsPerElement: Double) -> Int {
        precondition(0 < bitsPerElement, "'bitsPerElement' must be positive")
        precondition(
            bitsPerElement <= Self.max.rawValue,
            "'bitsPerElement' must not be larger than 'SecurityLevel.max'",
        )
        return Int(exactly: (rawValue / bitsPerElement).rounded(.up))!
    }
}

extension SecurityLevel: Comparable {
    public static func < (lhs: SecurityLevel, rhs: SecurityLevel) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
}

extension SecurityLevel: ExpressibleByFloatLiteral {
    public init(floatLiteral: Double) {
        guard let value = Self(rawValue: floatLiteral) else {
            fatalError("Invalid \(Self.self)")
        }
        self = value
    }
}

extension SecurityLevel: ExpressibleByIntegerLiteral {
    public init(integerLiteral: Int) {
        self.init(floatLiteral: Double(integerLiteral))
    }
}

#if canImport(ArgumentParser)
public import ArgumentParser

extension SecurityLevel: ExpressibleByArgument {
    public init?(argument: String) {
        guard let rawValue = Double(argument) else {
            return nil
        }
        self.init(rawValue: rawValue)
    }
}
#endif
