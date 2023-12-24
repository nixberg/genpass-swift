import ArgumentParser
import OrderedCollections
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
            let characterSet = OrderedSet("0123456789abcdefghjkmnpqrstuwxyz")
            assert(characterSet.count == 32)
            
            let passwordGenerator = BasicGenerator(characterSet: characterSet)
            
            self.runWithGenerator {
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }
        }
    }
}
