module sodium.crypto_scalarmult_curve25519;

extern(C) pure @nogc
{
  enum crypto_scalarmult_curve25519_BYTES = 32u;
  size_t crypto_scalarmult_curve25519_bytes() @trusted;

  enum crypto_scalarmult_curve25519_SCALARBYTES = 32u;
  size_t crypto_scalarmult_curve25519_scalarbytes() @trusted;

  int crypto_scalarmult_curve25519(ubyte* q, in ubyte* n, in ubyte* p) nothrow @system;

  int crypto_scalarmult_curve25519_base(ubyte* q, in ubyte* n) @system;
}
