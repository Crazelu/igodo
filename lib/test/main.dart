import '../igodo.dart';

const ENCRYPTION_KEY = "20120isvba;9310291299390pvm'v";
void main() {
  String word = 'aurora';
  print('Word: ' '$word');

  String encryptedWord = IgodoEncryption.encryptSymmetric(
    word,
    ENCRYPTION_KEY,
  );
  print('Encrypted word: ' '$encryptedWord');

  String decryptedWord = IgodoEncryption.decryptSymmetric(
    encryptedWord,
    ENCRYPTION_KEY,
  );
  print('Decrypted sword: ' '$decryptedWord');
}
