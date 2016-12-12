module sodium.crypto_shorthash_siphash24;

extern(C) {

pure @nogc :

enum   crypto_shorthash_siphash24_BYTES = 8u;
size_t crypto_shorthash_siphash24_bytes() @trusted;

enum   crypto_shorthash_siphash24_KEYBYTES = 16u;
size_t crypto_shorthash_siphash24_keybytes() @trusted;

int crypto_shorthash_siphash24(ubyte* hash, in ubyte* data, in ulong datalen, in ubyte* key) @system;
}

/*pure*/ @system
unittest {
  import std.stdio : writeln, writefln;
  import sodium.randombytes : randombytes_buf;

  debug {
    writeln("unittest block 1 from sodium.crypto_shorthash_siphash24.d");
  }
  assert(crypto_shorthash_siphash24_bytes()    == crypto_shorthash_siphash24_BYTES);    //  8U
  assert(crypto_shorthash_siphash24_keybytes() == crypto_shorthash_siphash24_KEYBYTES); // 16U
  
  auto short_data = cast(immutable(ubyte)[]) "Sparkling water";

  ubyte[crypto_shorthash_siphash24_BYTES]    hash_sip24;
  ubyte[crypto_shorthash_siphash24_KEYBYTES] key;

  randombytes_buf(key);
  crypto_shorthash_siphash24(hash_sip24.ptr, short_data.ptr, short_data.length, key.ptr);
  writefln("shorthash: 0x%(%X%)", hash_sip24);
}
