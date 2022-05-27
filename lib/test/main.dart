import '../../env.dart';
import '../igodo.dart';

//Provide your encryption key
void main() {
  String password = 'aurora';
  print('Password: ' '$password');

  String encryptedPassword =
      IgodoEncryption.encryptSymmetric(password, MASTERKEY);
  print('Encrypted password: ' '$encryptedPassword');

  String decryptedPassword =
      IgodoEncryption.decryptSymmetric(encryptedPassword, MASTERKEY);
  print('Decrypted password: ' '$decryptedPassword');
}
