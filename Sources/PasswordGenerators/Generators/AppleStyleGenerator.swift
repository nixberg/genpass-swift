import Algorithms

// Reference: https://developer.apple.com/password-rules/scripts/generator.js

public struct AppleStyleGenerator: PasswordGenerator {
    public init() {
        assert(Set.consonants.count == 19)
        assert(Set.vovels.count == 6)
        assert(Set.digits.count == 10)
        assert(Set.consonants.union(Set.vovels).union(Set.digits).count == 35)
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        var letters = (0...2).cycled().prefix(17).map {
            switch $0 {
            case 0, 2:
                return Set.consonants.randomElement(using: &rng)!
            case 1:
                return Set.vovels.randomElement(using: &rng)!
            default:
                fatalError()
            }
        }
        
        letters.uppercaseRandomCharacter(using: &rng)
        
        return String(letters.words(using: &rng).joined(separator: "-"))
    }
}

private extension Set<Character> {
    static let consonants = Set("bcdfghjkmnpqrstvwxz")
    
    static let vovels = Set("aeiouy")
    
    static let digits = Set("0123456789")
}

private extension Array<Character> {
    mutating func uppercaseRandomCharacter(using rng: inout some RandomNumberGenerator) {
        let (index, element) = self.indexed().shuffled(using: &rng).first(where: {
            $0.element != "o"
        })! // Some letters (that is, consonants) are guaranteed to not be "o".
        self[index] = element.uppercased()!
    }
    
    func words(using rng: inout some RandomNumberGenerator) -> [SubSequence] {
        var words = self.chunks(ofCount: 6).map({ $0 })
        switch Int.random(in: 0...4, using: &rng) {
        case 0:
            words[2].appendRandomDigit(using: &rng)
            words.swapAt(0, 2)
        case 1...4:
            words[2].prependOrAppendRandomDigit(using: &rng)
            words[1...2].shuffle()
        default:
            fatalError()
        }
        return words
    }
}

private extension Character {
    func uppercased() -> Self? {
        let string: String = self.uppercased()
        guard string.count == 1 else {
            return nil
        }
        return string.first
    }
}

private extension ArraySlice<Character> {
    mutating func appendRandomDigit(using rng: inout some RandomNumberGenerator) {
        self.append(Set.digits.randomElement(using: &rng)!)
    }
    
    mutating func prependOrAppendRandomDigit(using rng: inout some RandomNumberGenerator) {
        self.insert(
            Set.digits.randomElement(using: &rng)!,
            at: [startIndex, endIndex].randomElement(using: &rng)!
        )
    }
}
