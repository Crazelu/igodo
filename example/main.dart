import 'package:igodo/igodo.dart';

const ENCRYPTION_KEY = "20120isvb12[]9390pvm'v";
void main() {
  String message = 'Hey there internet traveler!';
  print('Message: ' '$message');

  String encryptedMessage = Igodo.encrypt(
    message,
    ENCRYPTION_KEY,
  );
  print('Encrypted message: ' '$encryptedMessage');

  String decryptedMessage = Igodo.decrypt(
    encryptedMessage,
    ENCRYPTION_KEY,
  );
  print('Decrypted message: ' '$decryptedMessage');
}
