// D import file generated from 'crypto_generichash_blake2b.d' renamed to 'crypto_generichash_blake2b.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_generichash_blake2b;

extern(C) pure @nogc
{

  align(64) struct crypto_generichash_blake2b_state
  {
    align (1)
    {
      ulong[8] h;
      ulong[2] t;
      ulong[2] f;
      ubyte[2 * 128] buf;
      size_t buflen;
      ubyte last_node;
    }
  }

  enum crypto_generichash_blake2b_BYTES_MIN = 16u;
  size_t crypto_generichash_blake2b_bytes_min() @trusted;

  enum crypto_generichash_blake2b_BYTES_MAX = 64u;
  size_t crypto_generichash_blake2b_bytes_max() @trusted;

  enum crypto_generichash_blake2b_BYTES = 32u;
  size_t crypto_generichash_blake2b_bytes() @trusted;

  enum crypto_generichash_blake2b_KEYBYTES_MIN = 16u;
  size_t crypto_generichash_blake2b_keybytes_min() @trusted;

  enum crypto_generichash_blake2b_KEYBYTES_MAX = 64u;
  size_t crypto_generichash_blake2b_keybytes_max() @trusted;

  enum crypto_generichash_blake2b_KEYBYTES = 32u;
  size_t crypto_generichash_blake2b_keybytes() @trusted;

  enum crypto_generichash_blake2b_SALTBYTES = 16u;
  size_t crypto_generichash_blake2b_saltbytes() @trusted;

  enum crypto_generichash_blake2b_PERSONALBYTES = 16u;
  size_t crypto_generichash_blake2b_personalbytes() @trusted;

  size_t crypto_generichash_blake2b_statebytes() @trusted;

  int crypto_generichash_blake2b(ubyte* out_, size_t outlen, const(ubyte)* in_, ulong inlen, const(ubyte)* key, size_t keylen) @system;
  int crypto_generichash_blake2b_salt_personal(ubyte* out_, size_t outlen, const(ubyte)* in_, ulong inlen, const(ubyte)* key, size_t keylen, const(ubyte)* salt, const(ubyte)* personal) @system;
  int crypto_generichash_blake2b_init(crypto_generichash_blake2b_state* state, const(ubyte)* key, const size_t keylen, const size_t outlen) @system;
  int crypto_generichash_blake2b_init_salt_personal(crypto_generichash_blake2b_state* state, const(ubyte)* key, const size_t keylen, const size_t outlen, const(ubyte)* salt, const(ubyte)* personal) @system;
  int crypto_generichash_blake2b_update(crypto_generichash_blake2b_state* state, const(ubyte)* in_, ulong inlen) @system;
  int crypto_generichash_blake2b_final(crypto_generichash_blake2b_state* state, ubyte* out_, const size_t outlen) @system;
}

pure @system
unittest
{
  import std.stdio : writeln, writefln;
//  import std.algorithm.comparison : equal;
//  import std.string : fromStringz; // @system
  debug  writeln("unittest block 1 from sodium.crypto_generichash_blake2b.d");
}
