import 'dart:math' show min;
import 'binary.dart';
import 'dart:convert' show utf8;
import 'extensions.dart';

class IgodoEncryption {
  static String encryptSymmetric(String word, String key) {
    return _runSymmetricEncrption(word, key);
  }

  static String decryptSymmetric(String word, String key) {
    return _runSymmetricEncrption(word, key, decrypt: true);
  }

  static String _runSymmetricEncrption(String word, String encryptionKey,
      {bool? decrypt = false}) {
    List<Binary> key = encryptionKey.binary;
    List<int> encodedWord = utf8.encode(word);
    List<Binary> wordInBits = Binary.intToBinary(charCodes: encodedWord);

    int keySum = 0;
    for (var i in key) {
      keySum += Binary.toInt(i);
    }
    Binary keySumBinary = Binary.toBinary(keySum);

    if (keySumBinary.bits!.length > 7) {
      keySumBinary = Binary(keySumBinary.bits!.substring(0, 7));
      //binary value cannot end with a '0'
      if (keySumBinary.bits!.endsWith('0')) {
        keySumBinary = Binary(keySumBinary.bits!.substring(0, 6) + '1');
      }
    }

    List<Binary> encryptedWordInBits = [];

    //shift first bit of all binaries forward except for the first and last in the list

    for (int i = 0; i < wordInBits.length; i++) {
      if (i != 0 || i != wordInBits.length) {
        encryptedWordInBits.add(
            shiftFirstBitForward(Binary.xand(wordInBits[i], keySumBinary)));
      } else {
        encryptedWordInBits.add(Binary.xor(wordInBits[i], keySumBinary));
      }
    }

    List<int> encryptedCharCodes = [];

    for (var i in encryptedWordInBits) {
      encryptedCharCodes.add(Binary.toInt(i));
    }

    return String.fromCharCodes(encryptedCharCodes);
  }

  static Binary shiftFirstBitForward(Binary binary) {
    List<String> bits = binary.bits!.split('');

    String temp = bits[bits.length - 1];
    bits[bits.length - 1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }

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

  static Binary shiftTwoBitsForward(Binary binary) {
    List<String> bits = binary.bits!.split('');
    String temp = bits[bits.length - 1];
    bits[bits.length - 1] = bits[1];
    bits[1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }

  static Binary reverseShiftTwoBitsForward(Binary binary) {
    List<String> bits = binary.bits!.split('');
    String temp = bits[1];
    bits[1] = bits[bits.length - 1];
    bits[bits.length - 1] = bits[0];
    bits[0] = temp;

    return Binary(bits.join());
  }
}
