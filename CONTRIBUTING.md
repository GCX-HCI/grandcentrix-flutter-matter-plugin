# Contributing

## Tools
### FVM - Flutter version management
We use [fvm](https://fvm.app/) to sync the flutter version in this project. To install fvm have a look [here](https://fvm.app/documentation/getting-started/installation).

After installing fvm run:
```sh
fvm install
```

### Melos - A tool for managing Dart projects with multiple packages
We use [melos](https://melos.invertase.dev/) to maintain this project.
To install it run:
```sh
dart pub global activate melos
```

To bootstrap this project run:
```sh
melos bs --sdk-path=.fvm/flutter_sdk/
```
or use the vs code plugin to run `Melos: Bootstrap`

### Format code
#### ktlint
Install [ktlint](https://github.com/pinterest/ktlint)
```sh
brew install ktlint
```

#### swiftformat
Install [swiftformat](https://github.com/nicklockwood/SwiftFormat)
```sh
brew install swiftformat
```

## Commit messages
Please use [conventional commits](https://www.conventionalcommits.org/en/v1.0.0/), so we can autogenerate changelogs with melos.

## Helpful VsCode plugins
- [dart-code.flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [blaugold.melos-code](https://marketplace.visualstudio.com/items?itemName=blaugold.melos-code)
- [jeroen-meijer.pubspec-assist](https://marketplace.visualstudio.com/items?itemName=jeroen-meijer.pubspec-assist)
- [google-home.google-home-extension](https://marketplace.visualstudio.com/items?itemName=google-home.google-home-extension)
- [redhat.vscode-yaml](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
 
## Helpful commands
### Run example
You will need to run `melos bs --sdk-path=.fvm/flutter_sdk/` before running the example
```sh
fvm flutter run -t flutter_matter/example/lib/main.dart
```

### Generate method channles with pigeon
We use [pigeon](https://github.com/flutter/packages/tree/main/packages/pigeon) to auto generate platform channel code
```sh
melos run generate:pigeon
```

### Run tests
Run all tests
```sh
melos run test --sdk-path=.fvm/flutter_sdk/
```
Run tests from a specific package
```sh
melos run test:select --sdk-path=.fvm/flutter_sdk/
```

## Contributing code
We gladly accept contributions via GitHub pull requests.

Please follow the [style guide for Flutter repo](https://github.com/flutter/flutter/wiki/Style-guide-for-Flutter-repo).

Also use
```sh
melos run lint:all --sdk-path=.fvm/flutter_sdk/
```
