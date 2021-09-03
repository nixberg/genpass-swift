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
> genpass --urbit-style 96
sicrup-sivmer-pannup-folmun-sollen-fitres
```

```console
> genpass --help
OVERVIEW: Generates a password.

USAGE: genpass [--base32] [--passphrase] [--urbit-style] [<security-level>]

ARGUMENTS:
  <security-level>        The desired security level. (default: 128.0)

OPTIONS:
  --base32/--passphrase/--urbit-style
                          The output style. (default: base32)
  -h, --help              Show help information.
```

## Installation

```console
> brew tap nixberg/tap
> brew install genpass
```
