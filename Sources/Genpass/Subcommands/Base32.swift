import ArgumentParser
import OrderedCollections
import PasswordGenerators

extension Genpass {
    struct Base32: PasswordGeneratingCommandWithSecurityLevelOptions {
        static let configuration = CommandConfiguration(
            abstract: "Generate a password from a set of 32 characters.",
            aliases: ["b"]
        )

        @OptionGroup
        var commonOptions: CommonOptions

        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions

        func run() {
            let characterSet = OrderedSet("0123456789abcdefghjkmnpqrstuwxyz")
            precondition(characterSet.count == 32)
            self.run(withGenerator: BasicGenerator(symbols: characterSet, separator: "")!)
        }
    }
}
