import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct SafariStyle: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Safari’s password manager."
        )
        
        mutating func run() {
            var rng = SystemRandomNumberGenerator()
            let password = SafariStyleGenerator().generatePassword(
                atSecurityLevel: 82,
                using: &rng
            )
            print(password)
        }
    }
}
