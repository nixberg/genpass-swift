import Algorithms
import ArgumentParser

@main
struct WordListFormatter: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "Convert a word list to Swift syntax."
    )
    
    @Option
    var lineLength = 100
    
    @Option(name: .customLong("spaces"))
    var spacesCount = 4
    
    func validate() throws {
        guard lineLength > 0 else {
            throw ValidationError("Please specify a 'line-length' greater than zero.")
        }
        guard spacesCount >= 0 else {
            throw ValidationError("Please specify a non-negative count of 'spaces'.")
        }
    }
    
    func run() {
        print(StandardInputLines().lazy.map({ #""\#($0)""# }).lineWrappingWords(
            toLength: lineLength,
            withIndentation: String(repeating: " ", count: spacesCount),
            separator: ", "
        ).joined(separator: "\n"))
    }
}

fileprivate struct StandardInputLines: IteratorProtocol, Sequence {
    func next() -> String? {
        readLine()
    }
}

fileprivate extension LazySequenceProtocol where Element: StringProtocol {
    func lineWrappingWords(
        toLength lineLength: Int,
        withIndentation indentation: String = "",
        separator: String = ""
    ) -> some Sequence<String> {
        let lineLength = lineLength - indentation.count
        var characterCount = 0
        return self.split(whereSeparator: {
            guard characterCount == 0 ||
                    characterCount + separator.count + $0.count < lineLength else {
                characterCount = 0
                return true
            }
            characterCount += separator.count + $0.count
            return false
        }).map({ indentation + $0.joined(separator: separator) })
    }
}
