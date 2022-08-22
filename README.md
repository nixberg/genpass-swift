# genpass

## Usage

```console
> genpass
8nebgm6etbwpqna235m6es9yea
```

```console
> genpass --passphrase 64
detect-remain-strategy-exact-spy-security
```

```console
> genpass --safari-style
spgqkf-hH0ghn-batigy
```

```console
> genpass --urbit-style 96
sicrup-sivmer-pannup-folmun-sollen-fitres
```

```console
> genpass --help
OVERVIEW: A utility for generating passwords.

USAGE: genpass <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  base32 (default)        Generate a password from a 32-character set.
  passphrase              Generate a passphrase from a set of words.
  safari-style            Generate a password in the style of Safari’s password manager.
  urbit-style             Generate a password in the style of Urbit’s @q encoding.

  See 'genpass help <subcommand>' for detailed help.
```

## Installation

```console
> brew install nixberg/tap/genpass
```
