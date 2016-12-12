/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */


module sodium.crypto_stream_xsalsa20;

extern(C) pure @nogc
{
  enum crypto_stream_xsalsa20_KEYBYTES = 32u;
  size_t crypto_stream_xsalsa20_keybytes() @trusted;

  enum crypto_stream_xsalsa20_NONCEBYTES = 24u;
  size_t crypto_stream_xsalsa20_noncebytes() @trusted;

  int crypto_stream_xsalsa20(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k) @system;

  int crypto_stream_xsalsa20_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k) @system;

  int crypto_stream_xsalsa20_xor_ic(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, ulong ic, const(ubyte)* k) @system;
}

pure @system
unittest
{
  import std.stdio : writeln;
//  import std.range : iota, array;
  debug  writeln("unittest block 1 from sodium.crypto_stream_xsalsa20.d");

//crypto_stream_xsalsa20_keybytes
  assert(crypto_stream_xsalsa20_keybytes()   == crypto_stream_xsalsa20_KEYBYTES);

//crypto_stream_xsalsa20_noncebytes
  assert(crypto_stream_xsalsa20_noncebytes() == crypto_stream_xsalsa20_NONCEBYTES);


}
