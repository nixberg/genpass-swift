import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct UrbitStyle: PasswordGeneratingCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Urbit’s @q encoding."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            let passwordGenerator = UrbitStyleGenerator()
            
            self.runWithGenerator {
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }
        }
    }
}
