// Written in the D programming language.

module wrapper.sodium.crypto_shorthash;

import wrapper.sodium.core; // assure sodium got initialized

public import  deimos.sodium.crypto_shorthash: crypto_shorthash_BYTES,
                                               crypto_shorthash_bytes,
                                               crypto_shorthash_KEYBYTES,
                                               crypto_shorthash_keybytes,
                                               crypto_shorthash_PRIMITIVE,
                                               crypto_shorthash_primitive,
//                                             crypto_shorthash,
                                               crypto_shorthash_keygen;
import deimos.sodium.crypto_shorthash_siphash24 : crypto_shorthash_siphash24_BYTES,
                                                  crypto_shorthash_siphash24_KEYBYTES;

alias crypto_shorthash = deimos.sodium.crypto_shorthash.crypto_shorthash;

pragma(inline, true)
int crypto_shorthash(out ubyte[crypto_shorthash_BYTES] hash, scope const ubyte[] data, const ubyte[crypto_shorthash_KEYBYTES] key) @nogc pure @trusted
{
  return crypto_shorthash(hash.ptr, data.ptr, data.length, key.ptr); // __attribute__ ((nonnull(1, 4)));
}


/*pure*/ @system
unittest {
  import std.stdio : writeln, writefln;
  import std.string : fromStringz, representation;
  import std.algorithm.comparison : equal;
  import wrapper.sodium.randombytes : randombytes;

  debug writeln("unittest block 1 from sodium.crypto_shorthash.d");
  assert(crypto_shorthash_bytes()    == crypto_shorthash_BYTES);    //  8U
  assert(crypto_shorthash_keybytes() == crypto_shorthash_KEYBYTES); // 16U
  assert(equal(fromStringz(crypto_shorthash_primitive()), crypto_shorthash_PRIMITIVE));

  auto short_data = representation("Sparkling water");

  ubyte[crypto_shorthash_BYTES]    hash;
  ubyte[crypto_shorthash_KEYBYTES] key;
  randombytes(key);
  crypto_shorthash(hash.ptr, short_data.ptr, short_data.length, key.ptr);
//  writefln("shorthash: 0x%(%02x%)", hash);
//  writefln("key:       0x%(%02x%)", key);
  ubyte[crypto_shorthash_BYTES]    hash_saved = hash;

// overload
  hash = hash.init;
  crypto_shorthash(hash, short_data, key);
//  writefln("shorthash: 0x%(%02x%)", hash);
  assert(hash == hash_saved);
//shorthash: 0xeeec84f5bce8afe9
//shorthash: 0xeeec84f5bce8afe9
//key:       0x86fb325ac11ef888257e9415b60db7a1
  ubyte[crypto_shorthash_KEYBYTES] k;
  crypto_shorthash_keygen(k);
}
