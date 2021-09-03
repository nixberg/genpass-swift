import ArgumentParser

protocol PasswordGenerator {
    func generate(securityLevel: Float64) -> String
}

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
    }
    
    func run() {
        switch outputStyle {
        case .base32:
            print(Base32Generator().generate(securityLevel: securityLevel))
        case .passphrase:
            print(PassphraseGenerator().generate(securityLevel: securityLevel))
        case .urbitStyle:
            print(UrbitStyleGenerator().generate(securityLevel: securityLevel))
        }
    }
}

enum OutputStyle: EnumerableFlag {
    case base32
    case passphrase
    case urbitStyle
}
