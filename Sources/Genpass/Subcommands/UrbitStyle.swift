import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct UrbitStyle: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Urbit’s @q encoding."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            let passwordGenerator = UrbitStyleGenerator()
            print(passwords: (0..<commonOptions.count).map { _ in
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }, terminator: commonOptions.terminator)
        }
    }
}
