import 'encryption.dart';
import 'env.dart';

void main() {
  String password = 'aurora';
  print('Password: ' '$password');
  String encryptedPassword =
      IgodoEncryption.encryptSymmetric(password, MASTERKEY);
  print('Encrypted password: ' '$encryptedPassword');
  String decryptedPassword =
      IgodoEncryption.decryptSymmetric(encryptedPassword, MASTERKEY);
  print('Decrypted password: ' '$decryptedPassword');
  tripleDESDemo();
}

void tripleDESDemo() {
  String password = 'securepass';
  print('Password: ' '$password');
  String encryptedPassword = IgodoEncryption.encryptTripleDES(
    plaintext: password,
    key1: KEY1,
    key2: KEY2,
    key3: KEY3,
  );
  print('Encrypted password: ' '$encryptedPassword');
  String decryptedPassword = IgodoEncryption.decryptTripleDES(
    plaintext: encryptedPassword,
    key1: KEY1,
    key2: KEY2,
    key3: KEY3,
  );
  print('Decrypted password: ' '$decryptedPassword');
}
