import Algorithms
import Numerics

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
        precondition(securityLevel <= 11 * .log2(19) + 6 * .log2(6) + .log2(10)) // Conservatively.
        
        var letters = Array.randomLetters(using: &rng)
        
        letters.uppercaseRandomCharacter(using: &rng)
        
        let words = letters.words(using: &rng)
        
        return String(words.joined(separator: "-"))
    }
}

extension Set<Character> {
    fileprivate static let consonants = Set("bcdfghjkmnpqrstvwxz")
    
    fileprivate static let vovels = Set("aeiouy")
    
    fileprivate static let digits = Set("0123456789")
}

extension Array<Character> {
    fileprivate static func randomLetters(using rng: inout some RandomNumberGenerator) -> Self {
        (0...2).cycled().prefix(17).map {
            switch $0 {
            case 0, 2:
                Set.consonants.randomElement(using: &rng)!
            case 1:
                Set.vovels.randomElement(using: &rng)!
            default:
                fatalError()
            }
        }
    }
    
    fileprivate mutating func uppercaseRandomCharacter(
        using rng: inout some RandomNumberGenerator
    ) {
        let (index, element) = self.indexed().randomSample(count: 7, using: &rng).first(where: {
            $0.element != "o"
        })! // Consonants are guaranteed to not be "o".
        self[index] = element.uppercased()!
    }
    
    fileprivate func words(using rng: inout some RandomNumberGenerator) -> [SubSequence] {
        var words = Swift.Array(self.chunks(ofCount: 6))
        switch Int.random(in: 0...4, using: &rng) {
        case 0:
            words[2].appendRandomDigit(using: &rng)
            words.swapAt(0, 2)
        case 1...4:
            words[2].prependOrAppendRandomDigit(using: &rng)
            words[1...2].shuffle(using: &rng)
        default:
            fatalError()
        }
        return words
    }
}

extension Character {
    fileprivate func uppercased() -> Self? {
        let string: String = self.uppercased()
        guard string.count == 1 else {
            return nil
        }
        return string.first
    }
}

extension ArraySlice<Character> {
    fileprivate mutating func appendRandomDigit(using rng: inout some RandomNumberGenerator) {
        self.append(Set.digits.randomElement(using: &rng)!)
    }
    
    fileprivate mutating func prependOrAppendRandomDigit(
        using rng: inout some RandomNumberGenerator
    ) {
        self.insert(
            Set.digits.randomElement(using: &rng)!,
            at: [startIndex, endIndex].randomElement(using: &rng)!
        )
    }
}
