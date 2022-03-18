import ArgumentParser

protocol PasswordGenerator {
    func generatePassword<RNG>(
        atSecurityLevel securityLevel: Float64,
        using rng: inout RNG
    ) -> String where RNG: RandomNumberGenerator
}

@main
fileprivate struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Generates a password.")
    
    @Flag(help: "The output style.")
    var outputStyle: OutputStyle = .base32
    
    @Argument(help: "The desired security level.")
    var securityLevel: Float64 = 128
    
    func validate() throws {
        guard securityLevel > 0 else {
            throw ValidationError("Please specify a 'security-level' greater than zero.")
        }
        guard let _ = Int(exactly: securityLevel.rounded(.up)) else {
            throw ValidationError("Please specify a smaller 'security-level'.")
        }
    }
    
    func run() {
        var rng = SystemRandomNumberGenerator()
        print(outputStyle.correspondingPasswordGenerator
            .generatePassword(atSecurityLevel: securityLevel, using: &rng))
    }
}

fileprivate enum OutputStyle: EnumerableFlag {
    case base32
    case passphrase
    case urbitStyle
    
    var correspondingPasswordGenerator: any PasswordGenerator {
        switch self {
        case .base32:
            return Base32Generator()
        case .passphrase:
            return PassphraseGenerator()
        case .urbitStyle:
            return UrbitStyleGenerator()
        }
    }
}

extension BinaryInteger {
    init<T: BinaryFloatingPoint>(roundingUp source: T) {
        self.init(exactly: source.rounded(.up))!
    }
}

extension Collection {
    func randomSampleWithReplacement<RNG>(count: Int, using rng: inout RNG) -> [Element]
    where RNG: RandomNumberGenerator {
        (0..<count).compactMap { _ in
            self.randomElement(using: &rng) // NOTE: Not necessarily stable across Swift versions.
        }
    }
}
