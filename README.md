# Igodo 🔒
A novel symmetric encryption algorithm implemented in Dart.
Igodo means "lock" or "key" in Igbo.

Igodo works by swapping and mangling bit representation of Strings with an encryption key in a way that is sturdy and secure.
You can take a look at its use in steganography application [here](https://github.com/Crazelu/steganograph).

## Install 🚀

In the `pubspec.yaml` of your Flutter/Dart project, add the following dependency:

```yaml
dependencies:
  igodo: ^1.0.0
```

## Import the package in your project 📥

```dart
import 'package:igodo/igodo.dart';
```

## Encrypt messages 🔐

Encrypt messages with an encryption key.

```dart
 String encryptedMessage = Igodo.encrypt(
    "Hey there, human!",
    ENCRYPTION_KEY,
  );
```

## Decrypt messages 🔑

Decrypt messages with an encryption key.

```dart
  String decryptedMessage = Igodo.decrypt(
    encryptedMessage,
    ENCRYPTION_KEY,
  );
```


## Contributions 🫱🏾‍🫲🏼

Feel free to contribute to this project.

If you find a bug or want a feature, but don't know how to fix/implement it, please fill an [issue](https://github.com/Crazelu/igodo/issues).  
If you fixed a bug or implemented a feature, please send a [pull request](https://github.com/Crazelu/igodo/pulls).
