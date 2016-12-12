module sodium.crypto_verify_32;

extern(C) pure @nogc
{
  enum crypto_verify_32_BYTES = 32u;
  size_t crypto_verify_32_bytes() @trusted;

  /** Secrets are always compared in constant time using sodium_memcmp() or crypto_verify_(16|32|64)()
   * @returns 0 if the len bytes pointed to by x match the len bytes pointed to by y.
   * Otherwise, it returns -1.
   * len must be 32, otherwise this function causes a segfault
   */
	int crypto_verify_32(in ubyte* x, in ubyte* y) nothrow @system;
} // extern(C) pure @nogc


/*  END OF TRANSLATED HEADER */


/* overloaded functions */


/** Secrets are always compared in constant time using sodium_memcmp() or crypto_verify_(16|32|64)()
 * @returns 0 if the len bytes pointed to by x match the len bytes pointed to by y.
 * Otherwise, it returns -1.
 */
int crypto_verify_32(in ubyte[32] x, in ubyte[32] y) pure nothrow @nogc @trusted
{
  return crypto_verify_32(x.ptr, y.ptr);
}

pure @system
unittest
{
  import std.stdio : writeln;
//  import std.range : iota, array;
  debug  writeln("unittest block 1 from sodium.crypto_verify_32.d");

//crypto_verify_32
  ubyte[] buf1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32];
  ubyte[] buf2 = buf1.dup;
  assert(crypto_verify_32(buf1.ptr, buf2.ptr) ==  0);
  buf2[$-1] = 33;
  assert(crypto_verify_32(buf1.ptr, buf2.ptr) == -1);
}

pure @safe
unittest
{
  import std.stdio : writeln;
  debug  writeln("unittest block 2 from sodium.crypto_verify_32.d");

//crypto_verify_32_bytes
  assert(crypto_verify_32_bytes() == crypto_verify_32_BYTES);

//crypto_verify_32 overload
  ubyte[32] buf1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32];
  ubyte[32] buf2 = buf1;
  assert(crypto_verify_32(buf1, buf2) ==  0);
  buf2[$-1] = 33;
  assert(crypto_verify_32(buf1, buf2) == -1);
}
