import ArgumentParser
import PasswordGenerators
import Foundation

extension Genpass {
    struct Passphrase: ParsableCommand {
        static var configuration = CommandConfiguration(
            abstract: "Generate a passphrase from a set of words."
        )
        
        @OptionGroup
        var commonOptions: CommonOptions
        
        @OptionGroup
        var securityLevelOptions: SecurityLevelOptions
        
        private let wordList: Set<String>
        
        init() {
            let words = PackageResources.english_txt.split(separator: UInt8(ascii: "\n"))
            wordList = Set(words.lazy.compactMap({ String(bytes: $0, encoding: .ascii) }))
            assert(wordList.count == 2048)
        }
        
        func run() {
            let passwordGenerator = PassphraseGenerator(words: wordList)
            print(passwords: (0..<commonOptions.count).map { _ in
                passwordGenerator.generatePassword(
                    atSecurityLevel: securityLevelOptions.securityLevel
                )
            }, terminator: commonOptions.terminator)
        }
    }
}
