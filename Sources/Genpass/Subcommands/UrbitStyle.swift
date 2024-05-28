import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct UrbitStyle: PasswordGeneratingCommandWithSecurityLevel {
        static let configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Urbit’s @q encoding.",
            aliases: ["urbit", "u"]
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            self.run(withGenerator: UrbitStyleGenerator())
        }
    }
}
