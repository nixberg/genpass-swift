import ArgumentParser
import PasswordGenerators
import Foundation

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
            let words = PackageResources.english_txt.split(separator: UInt8(ascii: "\n"))
            let wordlist = Set(words.lazy.compactMap({ String(bytes: $0, encoding: .ascii) })) // TODO: SE-0405
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
