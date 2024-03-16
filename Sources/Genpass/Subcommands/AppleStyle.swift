import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct AppleStyle: PasswordGeneratingCommand {
        static let configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Apple’s Password AutoFill."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        func run() {
            let passwordGenerator = AppleStyleGenerator()
            
            self.runWithGenerator {
                passwordGenerator.generatePassword(atSecurityLevel: 64)
            }
        }
    }
}
