extension RandomAccessCollection {
    func randomSampleWithReplacement(
        count: Int,
        using generator: inout some RandomNumberGenerator,
    ) -> [Element] {
        guard !isEmpty else {
            return []
        }
        return Array(
            capacity: count,
            initializingWith: { buffer in
                for _ in 0..<count {
                    buffer.append(self.randomElement(using: &generator)!)
                }
            }
        )
    }
}
