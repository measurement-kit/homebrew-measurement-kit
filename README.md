# MeasurementKit Homebrew Tap

Formulae that you can install using this tap:

- `measurement-kit`: Measurement Kit core library

- `mingw-w64-cxx11`: Mingw-w64 cross-compiler with support for C++11

Bottles are published in [measurement-kit/homebrew at bintray](
https://dl.bintray.com/measurement-kit/homebrew/).

## Build and install instructions

- add the tap

```
brew tap measurement-kit/measurement-kit
```

- install the latest stable

```
brew install <formula>
```

- remove the installed version

```
brew rm <formula>
```

- compile and install the `master` branch (may not work for all packages)

```
brew install --verbose --HEAD <formula>
```

- build a bottle

```
brew install --build-bottle <formula>
brew bottle --force-core-tap <formula>
```
