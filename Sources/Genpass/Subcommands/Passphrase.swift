import ArgumentParser
import OrderedCollections
import PasswordGenerators
import Foundation // TODO: SE-0405

extension Genpass {
    struct Passphrase: PasswordGeneratingCommandWithSecurityLevel {
        static let configuration = CommandConfiguration(
            abstract: "Generate a passphrase from a set of 2048 English words.",
            aliases: ["p"]
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        func run() {
            let wordlist = OrderedSet(String(
                bytes: PackageResources.english_txt,
                encoding: .ascii
            )!.split(separator: "\n"))
            assert(wordlist.count == 2048)
            self.run(withGenerator: PassphraseGenerator(wordlist: wordlist))
        }
    }
}
