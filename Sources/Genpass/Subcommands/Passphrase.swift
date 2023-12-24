import ArgumentParser
import OrderedCollections
import PasswordGenerators
import Foundation // TODO: SE-0405

extension Genpass {
    struct Passphrase: PasswordGeneratingCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a passphrase from a set of words."
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
            
            let passwordGenerator = PassphraseGenerator(wordlist: wordlist)
            
            self.runWithGenerator {
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }
        }
    }
}
