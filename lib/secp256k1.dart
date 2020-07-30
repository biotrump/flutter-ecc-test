import "dart:typed_data";
import "dart:math";
import "package:pointycastle/pointycastle.dart";
import "package:pointycastle/export.dart";
import "package:pointycastle/api.dart";
import "package:pointycastle/ecc/api.dart";
import "package:pointycastle/ecc/curves/secp256k1.dart";
import "package:pointycastle/key_generators/api.dart";
import "package:pointycastle/key_generators/ec_key_generator.dart";
import "package:pointycastle/random/fortuna_random.dart";

void secp256k1DH() {
  var keyPair = _secp256k1KeyPair();
  //print(keyPair);
  ECPublicKey publicKey = keyPair.publicKey;
  //bigInt.sign == 1 as a postivie
  //bigInt.sign == 0 as a negative
  print(publicKey.Q.x.toBigInteger().toRadixString(16));
  print(publicKey.Q.y.toBigInteger().toRadixString(16));

  ECPrivateKey privateKey = keyPair.privateKey;
  print(privateKey.d.toRadixString(16));
}

AsymmetricKeyPair<PublicKey, PrivateKey> _secp256k1KeyPair() {
  var keyParams = ECKeyGeneratorParameters(ECCurve_secp256k1());

  var random = FortunaRandom();
  random.seed(KeyParameter(_seed()));

  var generator = ECKeyGenerator();
  generator.init(ParametersWithRandom(keyParams, random));

  return generator.generateKeyPair();
}

Uint8List _seed() {
  var random = Random.secure();
  var seed = List<int>.generate(32, (_) => random.nextInt(256));
  return Uint8List.fromList(seed);
}

// TODO
// Restore the ECPrivateKey from 'd'.
