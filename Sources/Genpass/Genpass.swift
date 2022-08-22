import ArgumentParser

@main
struct Genpass: ParsableCommand {
    static var configuration = CommandConfiguration(
        abstract: "A utility for generating passwords.",
        subcommands: [
            Base32.self,
            Passphrase.self,
            SafariStyle.self,
            UrbitStyle.self,
        ],
        defaultSubcommand: Base32.self
    )
}
