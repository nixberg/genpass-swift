# genpass

## Usage

```console
> genpass
8nebgm6etbwpqna235m6es9yea
```

```console
> genpass --phrase 64
detect-remain-strategy-exact-spy-security
```

```console
> genpass --urbit 96
sicrup-sivmer-pannup-folmun-sollen-fitres
```

```console
> genpass --help
OVERVIEW: Generates a lowercase alphanumeric password.

USAGE: genpass [--phrase] [--urbit] [<security-level>]

ARGUMENTS:
  <security-level>        The desired security level. (default: 128.0)

OPTIONS:
  --phrase/--urbit        Generate a passphrase instead. 
  -h, --help              Show help information.
```

## Installation

```console
> brew tap nixberg/tap
> brew install genpass
```
