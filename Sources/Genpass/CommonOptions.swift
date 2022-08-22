import ArgumentParser

struct CommonOptions: ParsableArguments {
    @Argument(help: "The desired security level in bits." )
    var securityLevel: Float64 = 128
    
    func validate() throws {
        guard securityLevel > 0 else {
            throw ValidationError("Please specify a 'security-level' greater than zero.")
        }
        guard let _ = Int(exactly: securityLevel.rounded(.up)) else {
            throw ValidationError("Please specify a smaller 'security-level'.")
        }
    }
}
