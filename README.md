To help install Ipopt and Cbc binaries for macOS 10.13 High Sierra.

First need to install [Homebrew](https://brew.sh).

Also need to install Xcode command line tools:
```
xcode-select --install
```


# Ipopt

```bash
brew install chkwon/juliaopt/ipopt
```
then
```julia
Pkg.add("Ipopt")
```
or
```julia
Pkg.build("Ipopt")
```
if you have tried to install `Ipopt` already.

# Cbc

```bash
brew install chkwon/juliaopt/cbc
```
then
```julia
Pkg.add("Cbc")
```
```
