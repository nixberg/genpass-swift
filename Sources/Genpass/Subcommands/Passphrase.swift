import ArgumentParser
import OrderedCollections
import PasswordGenerators

extension Genpass {
    struct Passphrase: PasswordGeneratingCommandWithSecurityLevelOptions {
        static let configuration = CommandConfiguration(
            abstract: "Generate a passphrase from a set of 2048 English words.",
            aliases: ["p"]
        )

        @OptionGroup
        var commonOptions: CommonOptions

        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions

        func run() {
            let wordlist = OrderedSet(
                String(
                    validating: PackageResources.english_txt,
                    as: UTF8.self
                )!.split(separator: "\n")
            )
            precondition(wordlist.count == 2048)
            self.run(withGenerator: BasicGenerator(symbols: wordlist, separator: "-")!)
        }
    }
}
