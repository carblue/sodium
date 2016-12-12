// D import file generated from 'crypto_verify_64.d' renamed to 'crypto_verify_64.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_verify_64;

extern(C) pure @nogc
{
  enum crypto_verify_64_BYTES = 64u;
  size_t crypto_verify_64_bytes() @trusted;

  /** Secrets are always compared in constant time using sodium_memcmp() or crypto_verify_(16|32|64)()
   * @returns 0 if the len bytes pointed to by x match the len bytes pointed to by y.
   * Otherwise, it returns -1.
   * len must be 64, otherwise this function causes a segfault
   */
  int crypto_verify_64(in ubyte* x, in ubyte* y) nothrow @system;
} // extern(C) pure @nogc


/*  END OF TRANSLATED HEADER */


/* overloaded functions */


/** Secrets are always compared in constant time using sodium_memcmp() or crypto_verify_(16|32|64)()
 * @returns 0 if the len bytes pointed to by x match the len bytes pointed to by y.
 * Otherwise, it returns -1.
 */
int crypto_verify_64(in ubyte[64] x, in ubyte[64] y) pure nothrow @nogc @trusted
{
  return crypto_verify_64(x.ptr, y.ptr);
}

pure @system
unittest
{
  import std.stdio : writeln;
  debug  writeln("unittest block 1 from sodium.crypto_verify_64.d");

//crypto_verify_64
  ubyte[] buf1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,
                  33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64];
  ubyte[] buf2 = buf1.dup;
  assert(crypto_verify_64(buf1.ptr, buf2.ptr) ==  0);
  buf2[$-1] = 65;
  assert(crypto_verify_64(buf1.ptr, buf2.ptr) == -1);
}

pure @safe
unittest
{
  import std.stdio : writeln;
  debug  writeln("unittest block 2 from sodium.crypto_verify_64.d");

//crypto_verify_64
  assert(crypto_verify_64_bytes() == crypto_verify_64_BYTES);

//crypto_verify_64 overload
  ubyte[64] buf1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,
                    33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64];
  ubyte[64] buf2 = buf1;
  assert(crypto_verify_64(buf1, buf2) ==  0);
  buf2[$-1] = 65;
  assert(crypto_verify_64(buf1, buf2) == -1);
}

