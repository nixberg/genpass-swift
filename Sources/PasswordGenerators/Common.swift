extension BinaryInteger {
    package init?(roundingUp source: some BinaryFloatingPoint) {
        self.init(exactly: source.rounded(.up))
    }
}

extension Collection {
    /// - Note: The algorithm used to select a random element may change in a future version of
    ///         Swift. If you’re passing a generator that results in the same sequence of elements
    ///         each time you run your program, that sequence may change when your program is
    ///         compiled using a different version of Swift.
    func randomSampleWithReplacement(
        count: Int,
        using rng: inout some RandomNumberGenerator
    ) -> [Element] {
        (0..<count).compactMap { _ in
            self.randomElement(using: &rng)
        }
    }
}
