// Written in the D programming language.

module wrapper.sodium.crypto_kdf;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_kdf : crypto_kdf_BYTES_MIN,
                                   crypto_kdf_bytes_min,
                                   crypto_kdf_BYTES_MAX,
                                   crypto_kdf_bytes_max,
                                   crypto_kdf_CONTEXTBYTES,
                                   crypto_kdf_contextbytes,
                                   crypto_kdf_KEYBYTES,
                                   crypto_kdf_keybytes,
                                   crypto_kdf_PRIMITIVE,
/*                                 crypto_kdf_primitive,
                                   crypto_kdf_derive_from_key, */
                                   crypto_kdf_keygen;


string crypto_kdf_primitive() pure nothrow @nogc @trusted
{
  import std.string : fromStringz;
  static import deimos.sodium.crypto_kdf;
  return  fromStringz(deimos.sodium.crypto_kdf.crypto_kdf_primitive()); // strips terminating \0
}

/* overload */

alias crypto_kdf_derive_from_key = deimos.sodium.crypto_kdf.crypto_kdf_derive_from_key;

pragma(inline, true)
bool  crypto_kdf_derive_from_key(scope ubyte[] subkey,
                                 const ulong subkey_id,
                                 const char[crypto_kdf_CONTEXTBYTES] ctx,
                                 const ubyte[crypto_kdf_KEYBYTES] key) @nogc @trusted
{
    import nogc.exception: enforce;
//  enforce(subkey.length>=crypto_kdf_BYTES_MIN && subkey.length<=crypto_kdf_BYTES_MAX,
//    "Expected subkey.length: ", subkey.length, " to be greater-equal to crypto_kdf_BYTES_MIN: ", crypto_kdf_BYTES_MIN, " and less-equal to crypto_kdf_BYTES_MAX: ", crypto_kdf_BYTES_MAX);
  enforce(subkey.length>=crypto_kdf_BYTES_MIN && subkey.length<=crypto_kdf_BYTES_MAX,
    "Expected subkey.length is not greater-equal to crypto_kdf_BYTES_MIN and not less-equal to crypto_kdf_BYTES_MAX");
  return  crypto_kdf_derive_from_key(subkey.ptr, subkey.length, subkey_id, ctx, key) == 0;
}

@safe
unittest {
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_kdf.d");
}

@nogc @safe
unittest {
  assert(crypto_kdf_bytes_min()    == crypto_kdf_BYTES_MIN);
  assert(crypto_kdf_bytes_max()    == crypto_kdf_BYTES_MAX);
  assert(crypto_kdf_contextbytes() == crypto_kdf_CONTEXTBYTES);
  assert(crypto_kdf_keybytes()     == crypto_kdf_keybytes);
  assert(crypto_kdf_primitive()    == crypto_kdf_PRIMITIVE);

  char[crypto_kdf_CONTEXTBYTES] context = "Examples";
  ubyte[crypto_kdf_KEYBYTES]  master_key;
  ubyte[32]  subkey1;
  ubyte[32]  subkey2;
  ubyte[64]  subkey3;
  crypto_kdf_keygen(master_key);
  assert(crypto_kdf_derive_from_key(subkey1, 1, context, master_key));
  assert(crypto_kdf_derive_from_key(subkey2, 2, context, master_key));
  assert(crypto_kdf_derive_from_key(subkey3, 3, context, master_key));
}

@safe
unittest {
  import std.exception : assertThrown;

  char[crypto_kdf_CONTEXTBYTES] context = "Examples";
  ubyte[crypto_kdf_KEYBYTES]  master_key;
  crypto_kdf_keygen(master_key);
  ubyte[15]  subkey4;
  ubyte[65]  subkey5;
  assertThrown(crypto_kdf_derive_from_key(subkey4, 4, context, master_key));
  assertThrown(crypto_kdf_derive_from_key(subkey5, 5, context, master_key));
  ubyte[crypto_kdf_KEYBYTES]  master_key2;
  crypto_kdf_keygen(master_key2);
  assert(master_key != master_key2);
  ubyte[32]  subkey1;
  ubyte[32]  subkey2;
  assert(crypto_kdf_derive_from_key(subkey1, 1, context, master_key));
  assert(crypto_kdf_derive_from_key(subkey2, 1, context, master_key));
  assert(subkey1 == subkey2);
  assert(crypto_kdf_derive_from_key(subkey2, 2, context, master_key));
  assert(subkey1 != subkey2);
}