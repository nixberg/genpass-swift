import ArgumentParser

struct CommonOptions: ParsableArguments {
    @Option(help: "The number of passwords to generate.")
    var count = 1
    
    @Flag(help: "Omit trailing newlines.")
    private var omitNewlines = false
    
    var terminator: String {
        omitNewlines ? "" : "\n"
    }
    
    func validate() throws {
        guard count > 0 else {
            throw ValidationError("Please specify a 'count' greater than zero.")
        }
    }
}

struct SecurityLevelOptions: ParsableArguments {
    @Argument(help: "The desired security level in bits." )
    var securityLevel: Float64 = 64
    
    func validate() throws {
        guard securityLevel > 0 else {
            throw ValidationError("Please specify a 'security-level' greater than zero.")
        }
        guard let _ = Int(exactly: securityLevel.rounded(.up)) else {
            throw ValidationError("Please specify a smaller 'security-level'.")
        }
    }
}

protocol PasswordGeneratingCommand: ParsableCommand {
    var commonOptions: CommonOptions { get }
}

extension PasswordGeneratingCommand {
    func runWithGenerator(_ generatePassword: () -> String) {
        for _ in 0..<commonOptions.count {
            print(generatePassword(), terminator: commonOptions.terminator)
        }
    }
}
