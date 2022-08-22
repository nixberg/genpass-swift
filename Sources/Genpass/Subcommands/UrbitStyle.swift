import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct UrbitStyle: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Urbit’s @q encoding."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        mutating func run() {
            var rng = SystemRandomNumberGenerator()
            let password = UrbitStyleGenerator().generatePassword(
                atSecurityLevel: commonOptions.securityLevel,
                using: &rng
            )
            print(password)
        }
    }
}
