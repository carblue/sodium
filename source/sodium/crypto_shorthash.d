module sodium.crypto_shorthash;

import sodium.crypto_shorthash_siphash24 : crypto_shorthash_siphash24_BYTES
                                          ,crypto_shorthash_siphash24_KEYBYTES;

extern(C) pure @nogc {

enum crypto_shorthash_BYTES = crypto_shorthash_siphash24_BYTES;
size_t crypto_shorthash_bytes() @trusted;

enum crypto_shorthash_KEYBYTES = crypto_shorthash_siphash24_KEYBYTES;
size_t crypto_shorthash_keybytes() @trusted;

//immutable(char*) crypto_shorthash_PRIMITIVE = "siphash24";
enum crypto_shorthash_PRIMITIVE = "siphash24";
const(char)* crypto_shorthash_primitive();

int crypto_shorthash(ubyte* hash, in ubyte* data, in ulong datalen, in ubyte* key) @system;
} // extern(C) pure @nogc


int crypto_shorthash(out ubyte[crypto_shorthash_BYTES] hash, in ubyte[] data, in ubyte[crypto_shorthash_KEYBYTES] key) pure @nogc @trusted
{
  return crypto_shorthash(hash.ptr, data.ptr, data.length, key.ptr);
}

import std.exception : enforce;


/*pure*/ @system
unittest {
  import std.stdio : writeln, writefln;
  import std.string : fromStringz; // @system
  import sodium.randombytes : randombytes_buf;

  debug {
    writeln("unittest block 1 from sodium.crypto_shorthash.d");
  }
  assert(crypto_shorthash_bytes()    == crypto_shorthash_BYTES);    //  8U
  assert(crypto_shorthash_keybytes() == crypto_shorthash_KEYBYTES); // 16U
  assert(crypto_shorthash_primitive().fromStringz == crypto_shorthash_PRIMITIVE.fromStringz);
//  assert(equal(fromStringz(crypto_generichash_primitive()), crypto_generichash_PRIMITIVE));

  auto short_data = cast(immutable(ubyte)[]) "Sparkling water";

  ubyte[crypto_shorthash_BYTES]    hash;
  ubyte[crypto_shorthash_KEYBYTES] key;
  randombytes_buf(key);
  crypto_shorthash(hash.ptr, short_data.ptr, short_data.length, key.ptr);
//  writefln("shorthash: 0x%(%02x%)", hash);
//  writefln("key:       0x%(%02x%)", key);
  ubyte[crypto_shorthash_BYTES]    hash_saved = hash;

// overload
  hash[] = ubyte.init;
  crypto_shorthash(hash, short_data, key);
//  writefln("shorthash: 0x%(%02x%)", hash);
  assert(hash == hash_saved);
//shorthash: 0xeeec84f5bce8afe9
//shorthash: 0xeeec84f5bce8afe9
//key:       0x86fb325ac11ef888257e9415b60db7a1
}
