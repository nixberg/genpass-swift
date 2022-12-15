import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct AppleStyle: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Apple’s Password AutoFill."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        mutating func run() {
            let passwordGenerator = AppleStyleGenerator()
            print(passwords: (0..<commonOptions.count).map { _ in
                passwordGenerator.generatePassword(atSecurityLevel: 0)
            }, terminator: commonOptions.terminator)
        }
    }
}
