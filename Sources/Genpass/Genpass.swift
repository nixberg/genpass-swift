import ArgumentParser
import PasswordGenerators

@main
struct Genpass: ParsableCommand {
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

enum OutputStyle: EnumerableFlag {
    case base32
    case passphrase
    case safariStyle
    case urbitStyle
    
    var correspondingPasswordGenerator: any PasswordGenerator {
        switch self {
        case .base32:
            return Base32Generator()
        case .passphrase:
            return PassphraseGenerator()
        case .safariStyle:
            return SafariStyleGenerator()
        case .urbitStyle:
            return UrbitStyleGenerator()
        }
    }
}
