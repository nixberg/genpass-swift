import ArgumentParser
import OrderedCollections
import PasswordGenerators

extension Genpass {
    struct Base32: PasswordGeneratingCommandWithSecurityLevel {
        static let configuration = CommandConfiguration(
            abstract: "Generate a password from a 32-character set.",
            aliases: ["b"]
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            let characterSet = OrderedSet("0123456789abcdefghjkmnpqrstuwxyz")
            assert(characterSet.count == 32)
            self.run(withGenerator: BasicGenerator(characterSet: characterSet))
        }
    }
}
