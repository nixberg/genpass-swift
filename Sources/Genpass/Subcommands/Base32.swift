import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct Base32: PasswordGeneratingCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password from a 32-character set."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            assert(Set.base32ilov.count == 32)
            
            let passwordGenerator = BasicGenerator(characterSet: .base32ilov)
            
            self.runWithGenerator {
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }
        }
    }
}

extension Set<Character> {
    fileprivate static let base32ilov = Set("0123456789abcdefghjkmnpqrstuwxyz")
}
