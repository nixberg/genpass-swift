import ArgumentParser

@main
struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "An utility for generating passwords.",
        subcommands: [
            AppleStyle.self,
            Base32.self,
            Passphrase.self,
            UrbitStyle.self,
        ],
        defaultSubcommand: Base32.self
    )
}
