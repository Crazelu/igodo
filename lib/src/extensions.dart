import 'dart:convert' show utf8;

import 'binary.dart';

extension BinaryListExtension on List<Binary> {
  Binary get and => Binary.and(this[0], this[1]);
  Binary get xand => Binary.xand(this[0], this[1]);
  Binary get nand => Binary.nand(this[0], this[1]);
  Binary get or => Binary.or(this[0], this[1]);
  Binary get nor => Binary.nor(this[0], this[1]);
  Binary get xor => Binary.xor(this[0], this[1]);
  List<Binary> get normalizeLength => Binary.normalizeLength(this);
}

extension BinaryExtension on Binary {
  Binary get not => Binary.not(this);
}

extension BinaryCombineExtension on List<int> {
  Binary get combine => Binary.combine(this);
}

extension BinaryStringExtension on String {
  List<Binary> get binary =>
      Binary.normalizeLength(Binary.intToBinary(charCodes: utf8.encode(this)));
}
