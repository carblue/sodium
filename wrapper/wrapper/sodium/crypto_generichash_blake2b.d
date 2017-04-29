// Written in the D programming language.

module wrapper.sodium.crypto_generichash_blake2b;

import wrapper.sodium.core; // assure sodium got initialized

public import  deimos.sodium.crypto_generichash_blake2b;


@system
unittest
{
//  import std.string : fromStringz;
//  import std.algorithm.comparison : equal;
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_generichash_blake2b.d");
version (D_LP64) {
  static assert(crypto_generichash_blake2b_state.last_node.offsetof == 352+8);
//  writeln("crypto_generichash_blake2b_state.sizeof:  ", crypto_generichash_blake2b_state.sizeof);  // 384
//  writeln("crypto_generichash_blake2b_state.alignof: ", crypto_generichash_blake2b_state.alignof); // 8
}
else
  static assert(crypto_generichash_blake2b_state.last_node.offsetof == 352+4);
}

/+
@safe
unittest
{
  import std.stdio : writeln;
  debug writeln("unittest block 2 from sodium.crypto_generichash_blake2b.d");
}
+/
