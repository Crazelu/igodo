import 'dart:math' show min;
import 'binary.dart';
import 'dart:convert' show utf8;
import 'extensions.dart';

class IgodoEncryption {
  ///Encrypts `word` with `key` symmetrically.
  static String encryptSymmetric(String word, String key) {
    return _runSymmetricEncrption(word, key);
  }

  ///Decrypts `word` with `key` symmetrically.
  static String decryptSymmetric(String word, String key) {
    return _runSymmetricEncrption(word, key, decrypt: true);
  }

  ///Handler for symmetric encryption and decryption
  static String _runSymmetricEncrption(String word, String encryptionKey,
      {bool? decrypt = false}) {
    //convert encryption key from String to binary
    List<Binary> key = encryptionKey.binary;

    //decode word to be encrypted into utf-8 char codes
    List<int> encodedWord = utf8.encode(word);

    //convert decoded word codes into binary equivalents
    List<Binary> wordInBits = Binary.intToBinary(charCodes: encodedWord);

    //sum all the binary values in the encryption key in base 10
    //convert result to binary and clamp it to 7 bits
    int keySum = 0;
    for (var i in key) {
      keySum += Binary.toInt(i);
    }
    Binary keySumBinary = Binary.toBinary(keySum);

    if (keySumBinary.bits!.length > 7) {
      keySumBinary = Binary(keySumBinary.bits!.substring(0, 7));
      //binary value cannot end with a '0' for an accurate decryption
      //not sure why yet
      if (keySumBinary.bits!.endsWith('0')) {
        keySumBinary = Binary(keySumBinary.bits!.substring(0, 6) + '1');
      }
    }

    List<Binary> encryptedWordInBits = [];

    //shift first bit of all binaries forward and perform a logical XAND with the keySumBinary
    //except for the first and last in the list on which no shift is done and
    //logical XOR is performed with the keySumBinary

    for (int i = 0; i < wordInBits.length; i++) {
      if (i != 0 || i != wordInBits.length) {
        encryptedWordInBits.add(
            shiftFirstBitForward(Binary.xand(wordInBits[i], keySumBinary)));
      } else {
        encryptedWordInBits.add(Binary.xor(wordInBits[i], keySumBinary));
      }
    }

    List<int> encryptedCharCodes = [];

    //convert encrypted binaries to utf-8 char codes
    for (var i in encryptedWordInBits) {
      encryptedCharCodes.add(Binary.toInt(i));
    }

    return String.fromCharCodes(encryptedCharCodes);
  }

  ///Swaps first bit with last bit
  static Binary shiftFirstBitForward(Binary binary) {
    List<String> bits = binary.bits!.split('');

    String temp = bits[bits.length - 1];
    bits[bits.length - 1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }

  ///Some vibes that I might wanna use sometime in the future.
  ///Guess what it does if you will.
  static List<int> swapBits(List<int> encodedWord) {
    List<int> result = [...encodedWord];
    int max = 0;
    int least = 0;
    int maxIndex = 0;
    int length = result.length;
    int center = (length / 2).floor();

    for (int i = 0; i < length; i++) {
      if (i == 0) {
        least = result[i];
      }
      if (result[i] > max) {
        maxIndex = i;
        max = result[i];
        least = min(least, result[i]);
      }
    }

    //if largest bit is at the center of the list, swap largest bit with last bit in the list
    //otherwise, swap largest bit with least bit
    if (maxIndex == center) {
      int temp = result[length - 1];
      result[length - 1] = max;
      result[maxIndex] = temp;
    } else {
      int leastIndex = result.indexOf(least);
      int temp = result[leastIndex];
      result[leastIndex] = max;
      result[maxIndex] = temp;
    }

    return result;
  }

  ///Swaps first bit with last bit, last bit with second bit and second bit with first bit
  static Binary shiftTwoBitsForward(Binary binary) {
    List<String> bits = binary.bits!.split('');
    String temp = bits[bits.length - 1];
    bits[bits.length - 1] = bits[1];
    bits[1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }

  ///Reverses [shiftTwoBitsForward]
  static Binary reverseShiftTwoBitsForward(Binary binary) {
    List<String> bits = binary.bits!.split('');
    String temp = bits[1];
    bits[1] = bits[bits.length - 1];
    bits[bits.length - 1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }
}
