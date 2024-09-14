import ArgumentParser
import PasswordGenerators

extension Genpass {
    struct AppleStyle: PasswordGeneratingCommand {
        static let configuration = CommandConfiguration(
            abstract: "Generate a password in the style of Apple’s Password AutoFill.",
            aliases: ["apple", "a"]
        )

        @OptionGroup
        var commonOptions: CommonOptions

        func run() {
            self.run(withGenerator: AppleStyleGenerator(), securityLevel: 64)
        }
    }
}
