import ArgumentParser
import PasswordGenerators

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
    func run(withGenerator generator: some PasswordGenerator, securityLevel: Float64) {
        for _ in 0..<commonOptions.count {
            print(
                generator.generatePassword(atSecurityLevel: securityLevel),
                terminator: commonOptions.terminator
            )
        }
    }
}

protocol PasswordGeneratingCommandWithSecurityLevel: PasswordGeneratingCommand {
    var securityLevelOptions: SecurityLevelOptions { get }
}

extension PasswordGeneratingCommandWithSecurityLevel {
    func run(withGenerator generator: some PasswordGenerator) {
        self.run(withGenerator: generator, securityLevel: securityLevelOptions.securityLevel)
    }
}
