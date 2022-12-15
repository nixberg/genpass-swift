import Algorithms
import Numerics

// Reference: https://developer.apple.com/password-rules/scripts/generator.js

public struct AppleStyleGenerator: PasswordGenerator {
    public init() {
        assert(Set.consonants.count == 19)
        assert(Set.vovels.count == 6)
        assert(Set.digits.count == 10)
    }
    
    public func generatePassword(
        atSecurityLevel securityLevel: Float64,
        using rng: inout some RandomNumberGenerator
    ) -> String {
        String((0..<3).cycled().prefix(17).map {
            switch $0 {
            case 0, 2:
                return Set.consonants.randomElement(using: &rng)!
            case 1:
                return Set.vovels.randomElement(using: &rng)!
            default:
                fatalError()
            }
        }.randomCharacterUppercased(using: &rng).words(using: &rng).joined(separator: "-"))
    }
}

private extension Set<Character> {
    static let consonants = Set("bcdfghjkmnpqrstvwxz")
    
    static let vovels = Set("aeiouy")
    
    static let digits = Set("0123456789")
}

private extension [Character] {
    func randomCharacterUppercased(using rng: inout some RandomNumberGenerator) -> [Element] {
        while true {
            var letters = self
            let index = letters.indices.randomElement(using: &rng)!
            guard letters[index] != "o" else {
                continue
            }
            letters[index].makeUppercase()
            return letters
        }
    }
    
    func words(using rng: inout some RandomNumberGenerator) -> [ArraySlice<Element>] {
        var words = self.chunks(ofCount: 6).map({ $0 })
        switch Int.random(in: 0...4) {
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
    mutating func makeUppercase() {
        let uppercased = self.uppercased()
        assert(uppercased.count == 1)
        self = uppercased.first!
    }
}

private extension ArraySlice<Character> {
    mutating func appendRandomDigit(using rng: inout some RandomNumberGenerator) {
        self.append(Set.digits.randomElement(using: &rng)!)
    }
    
    mutating func prependOrAppendRandomDigit(using rng: inout some RandomNumberGenerator) {
        self.insert(
            Set.digits.randomElement(using: &rng)!,
            at: .random(using: &rng) ? startIndex : endIndex
        )
    }
}
