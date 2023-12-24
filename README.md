# genpass-swift

## Usage

```console
> genpass [base32] [64]
2fwy5z2ah4ayg
```

```console
> genpass apple-style --count=2
mahvUk-gydjij-myvzo3
wedgew-3xafzo-viTgan
```

```console
> genpass passphrase 64
detect-remain-strategy-exact-spy-security
```

```console
> genpass urbit-style 96 --omit-newlines
sicrup-sivmer-pannup-folmun-sollen-fitres⏎
```

```console
> genpass help
OVERVIEW: An utility for generating passwords.

USAGE: genpass <subcommand>

OPTIONS:
  -h, --help              Show help information.

SUBCOMMANDS:
  apple-style             Generate a password in the style of Apple’s Password AutoFill.
  base32 (default)        Generate a password from a 32-character set.
  passphrase              Generate a passphrase from a set of words.
  urbit-style             Generate a password in the style of Urbit’s @q encoding.

  See 'genpass help <subcommand>' for detailed help.
```

## Installation

```console
> brew install nixberg/tap/genpass
```
