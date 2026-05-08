import Algorithms
import OrderedCollections

// Reference: https://developer.apple.com/password-rules/scripts/generator.js

public struct AppleStyleGenerator: PasswordGenerator {
    private let consonants = OrderedSet("bcdfghjkmnpqrstvwxz")

    private let digits = OrderedSet("0123456789")

    private let vowels = OrderedSet("aeiouy")

    public init() {
        precondition(consonants.count == 19)
        precondition(vowels.count == 6)
        precondition(digits.count == 10)
        precondition(consonants.union(vowels).union(digits).count == 35)
    }

    public func generatePassword(
        atSecurityLevel securityLevel: SecurityLevel,
        using generator: inout some RandomNumberGenerator,
    ) -> String {
        // 65 bits < .log2(19) * 11 + .log2(6) * 6 + .log2(10) < actual security level.
        precondition(
            securityLevel.rawValue <= 65,
            "\(Self.self) only generates passwords with a fixed security level of around 65 bits",
        )

        let letters = self.generateLetters(using: &generator)

        let segments = letters.dividedIntoSegmentsAndInsertingDigit(
            digits.randomElement(using: &generator)!,
            using: &generator,
        )

        return String(segments.joined(separator: "-"))
    }

    private func generateLetters(
        using generator: inout some RandomNumberGenerator,
    ) -> [Character] {
        var password = (0...2).cycled().prefix(17).map {
            switch $0 {
            case 0, 2:
                consonants.randomElement(using: &generator)!
            case 1:
                vowels.randomElement(using: &generator)!
            default:
                fatalError()
            }
        }

        repeat {
            let (index, element) = password.indexed().randomElement(using: &generator)!
            guard element != "o" else {
                continue
            }
            password[index] = element.uppercasedCharacter()!
        } while false

        return password
    }
}

extension [Character] {
    fileprivate func dividedIntoSegmentsAndInsertingDigit(
        _ digit: Character,
        using generator: inout some RandomNumberGenerator,
    ) -> [ArraySlice<Character>] {
        let randomNumber = Int.random(in: 0...4, using: &generator)

        let segment1 = self[00..<06]
        let segment2 = self[06..<12]
        let segment3 = self[12..<17].inserting(
            digit,
            at: randomNumber.isMultiple(of: 2) ? 17 : 12
        )

        return switch randomNumber {
        case 0:
            [segment3, segment1, segment2]
        case 1, 2:
            [segment1, segment3, segment2]
        case 3, 4:
            [segment1, segment2, segment3]
        default:
            fatalError()
        }
    }
}

extension Character {
    fileprivate func uppercasedCharacter() -> Self? {
        let result: String = self.uppercased()
        guard result.count == 1 else {
            return nil
        }
        return result.first
    }
}

extension RangeReplaceableCollection {
    fileprivate func inserting(_ newElement: Element, at index: Index) -> Self {
        var result = Self()
        result.reserveCapacity(count + 1)
        result.append(contentsOf: self.prefix(upTo: index))
        result.append(newElement)
        result.append(contentsOf: self.suffix(from: index))
        return result
    }
}
