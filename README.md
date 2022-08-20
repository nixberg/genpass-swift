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
> genpass --safari-style 80
nmnxui-xgd3lt-pfKiyo
```

```console
> genpass --urbit-style 96
sicrup-sivmer-pannup-folmun-sollen-fitres
```

```console
> genpass --help
OVERVIEW: Generates a password.

USAGE: genpass [--base32] [--passphrase] [--safari-style] [--urbit-style] [<security-level>]

ARGUMENTS:
  <security-level>        The desired security level. (default: 128.0)

OPTIONS:
  --base32/--passphrase/--safari-style/--urbit-style
                          The output style. (default: base32)
  -h, --help              Show help information.
```

## Installation

```console
> brew install nixberg/tap/genpass
```
