import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct Base32: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password from a 32-character set."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        mutating func run() {
            let passwordGenerator = BasicGenerator(characterSet: .base32ilov)
            print(passwords: (0..<commonOptions.count).map { _ in
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }, terminator: commonOptions.terminator)
        }
    }
}

private extension Set<Character> {
    static let base32ilov = Set("0123456789abcdefghjkmnpqrstuwxyz")
}
