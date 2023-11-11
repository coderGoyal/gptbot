<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

The package allows you to integrate Chatgpt with just api key needed.

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  gptbot: ^0.0.1
```

### 2. Install it

You can install packages from the command line:

with `pub`:

```bash
pub get
```

with `Flutter`:

```bash
flutter pub get
```
### 3. Import it

Now in your `Dart` code, you can use:

```dart
import 'package:gptbot/gptbot';
```

## Usage

`GptBot` is a widget that allows you to integrate Chatgpt with just api key needed to save time to integrate the whole method.
When you want to use Chatgpt use it like:

```dart
class Bot extends StatelessWidget {
  const Bot({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Gpt_flutter(apiKey: APIKey.apiKey),
    );
  }
}
```

It needs three arguments -

- `apiKey` – the apikey you need to get the gpt response


#   g p t b o t  
 