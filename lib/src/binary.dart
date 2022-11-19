import 'dart:math' as math;

const ZERO = '0';
const ONE = '1';

class Binary {
  String _bits = ZERO;
  String get bits => _bits;

  Binary([String bits = ZERO]) : _bits = bits;

  ///Returns integer value of a binary number
  static int toInt(Binary binary) {
    int result = 0;
    int step = 0;
    String bits = binary.bits;
    for (int i = bits.length - 1; i >= 0; i--) {
      result += int.parse(bits[i]) * math.pow(2, step).toInt();
      step += 1;
    }
    return result;
  }

  static Binary combine(List<int> charCodes) {
    String result = '';
    for (var charCode in charCodes) result += '${toBinary(charCode)}';

    return Binary(result);
  }

  ///Returns a list of Binary objects constructed from `charCodes` if `charCodes` is not null.
  ///Otherwise, returns a Binary object constructed from an integer, `charCode`.
  static dynamic intToBinary({int charCode: 0, List<int>? charCodes}) {
    if (charCodes != null) {
      List<Binary> binaries = <Binary>[];
      for (int i in charCodes) {
        binaries.add(toBinary(i));
      }
      return binaries;
    }
    return toBinary(charCode);
  }

  ///Returns a Binary object constructed from an integer, `charCode`.
  static Binary toBinary(int charCode) {
    if (charCode == 0) return Binary();

    String result = '';
    while (charCode != 1) {
      result = '${charCode % 2}' '$result';
      charCode = (charCode / 2).floor();
    }

    result = '1' '$result';

    return Binary(result);
  }

  ///Returns a list of Binary objects with individual bits normalized to be as long
  ///as the bit with the longest word length
  static List<Binary> normalizeLength(List<Binary> binaries) {
    List<Binary> result = <Binary>[];
    int max = 0;

    for (var binary in binaries) {
      if (binary.bits.length > max) max = binary.bits.length;
    }

    for (var binary in binaries) {
      result.add(Binary(binary.bits.padLeft(max, '0')));
    }

    return result;
  }

  ///Normalizes the word length of both bits
  static List<String> _normalizeLength(Binary a, Binary b) {
    String aString = a.bits;
    String bString = b.bits;
    int aLength = aString.length;
    int bLength = bString.length;

    //both binary values need to have equal digits for the binary logical operations to be performed

    if (aLength > bLength) {
      bString = bString.padLeft(aLength, ZERO);
    } else if (bLength > aLength) {
      aString = aString.padLeft(bLength, ZERO);
    }

    return [aString, bString];
  }

  ///Returns result of logical AND on two bits
  static Binary and(Binary a, Binary b) {
    String result = '';
    List<String> normalizedLengthBits = _normalizeLength(a, b);
    String aString = normalizedLengthBits[0];
    String bString = normalizedLengthBits[1];

    for (int i = 0; i < aString.length; i++) {
      if (aString[i] == ONE && bString[i] == ONE) {
        result += ONE;
      } else {
        result += ZERO;
      }
    }

    return Binary(result);
  }

  ///Returns result of logical OR on two bits
  static Binary or(Binary a, Binary b) {
    String result = '';
    List<String> normalizedLengthBits = _normalizeLength(a, b);
    String aString = normalizedLengthBits[0];
    String bString = normalizedLengthBits[1];

    for (int i = 0; i < aString.length; i++) {
      if (aString[i] == ZERO && bString[i] == ZERO) {
        result += ZERO;
      } else {
        result += ONE;
      }
    }

    return Binary(result);
  }

  ///Returns result of logical NOT on a bit
  static Binary not(Binary binary) {
    String result = '';
    String binaryString = binary.bits;

    for (int i = 0; i < binaryString.length; i++) {
      if (binaryString[i] == ZERO) {
        result += ONE;
      } else {
        result += ZERO;
      }
    }
    return Binary(result);
  }

  ///Returns result of logical XOR on two bits
  static Binary xor(Binary a, Binary b) {
    String result = '';
    List<String> normalizedLengthBits = _normalizeLength(a, b);
    String aString = normalizedLengthBits[0];
    String bString = normalizedLengthBits[1];

    for (int i = 0; i < aString.length; i++) {
      if (aString[i] == ZERO && bString[i] == ZERO) {
        result += ZERO;
      } else if (aString[i] == ONE && bString[i] == ONE) {
        result += ZERO;
      } else {
        result += ONE;
      }
    }

    return Binary(result);
  }

  ///Returns result of logical XAND on two bits
  static Binary xand(Binary a, Binary b) {
    String result = '';
    List<String> normalizedLengthBits = _normalizeLength(a, b);
    String aString = normalizedLengthBits[0];
    String bString = normalizedLengthBits[1];

    for (int i = 0; i < aString.length; i++) {
      if (aString[i] == ZERO && bString[i] == ZERO) {
        result += ONE;
      } else if (aString[i] == ONE && bString[i] == ONE) {
        result += ONE;
      } else {
        result += ZERO;
      }
    }

    return Binary(result);
  }

  ///Returns result of logical NAND on two bits
  static Binary nand(Binary a, Binary b) {
    return not(and(a, b));
  }

  ///Returns result of logical NOR on two bits
  static Binary nor(Binary a, Binary b) {
    return not(or(a, b));
  }

  @override
  String toString() {
    return bits;
  }
}
