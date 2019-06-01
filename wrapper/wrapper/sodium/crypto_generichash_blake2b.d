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
  debug writeln("crypto_generichash_blake2b_state.sizeof:  ", crypto_generichash_blake2b_state.sizeof);  // 384
  debug writeln("crypto_generichash_blake2b_state.alignof: ", crypto_generichash_blake2b_state.alignof); // 64
}

/+
@safe
unittest
{
  import std.stdio : writeln;
  debug writeln("unittest block 2 from sodium.crypto_generichash_blake2b.d");
}
+/
