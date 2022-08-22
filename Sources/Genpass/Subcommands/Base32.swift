import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct Base32: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password from a 32-character set."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        mutating func run() {
            var rng = SystemRandomNumberGenerator()
            let password = BasicGenerator(characterSet: base32ilovCharacterSet).generatePassword(
                atSecurityLevel: commonOptions.securityLevel,
                using: &rng
            )
            print(password)
        }
    }
}

fileprivate let base32ilovCharacterSet = Set("0123456789abcdefghjkmnpqrstuwxyz")
