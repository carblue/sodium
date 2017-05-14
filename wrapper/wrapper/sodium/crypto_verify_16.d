module wrapper.sodium.crypto_verify_16;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_verify_16;

// overloading a functions between module deimos.sodium.crypto_verify_16 and this module

alias crypto_verify_16 = deimos.sodium.crypto_verify_16.crypto_verify_16;

/** Secrets are always compared in constant time using sodium_memcmp() or crypto_verify_(16|32|64)()
 * @returns true, if the content of array `x` matches the content of array `y`.
 * Otherwise, it returns false.
 */
pragma(inline, true)
bool  crypto_verify_16(const ubyte[crypto_verify_16_BYTES] x, const ubyte[crypto_verify_16_BYTES] y) pure nothrow @nogc @trusted
{
  return  crypto_verify_16(x.ptr, y.ptr) == 0;
}


pure @system
unittest
{
  import std.stdio : writeln;
  import std.range : iota, array;
  debug  writeln("unittest block 1 from sodium.crypto_verify_16.d");

//crypto_verify_16
  ubyte[] buf1 = array(iota(ubyte(1), cast(ubyte)(1+crypto_verify_16_BYTES))); // [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
  ubyte[] buf2 = buf1.dup;
  assert(crypto_verify_16(buf1.ptr, buf2.ptr) ==  0);
  buf2[$-1] = 17;
  assert(crypto_verify_16(buf1.ptr, buf2.ptr) == -1);
}

pure nothrow @nogc @safe
unittest
{
  import std.range : iota, enumerate;
//crypto_verify_16_bytes
  assert(crypto_verify_16_bytes() == crypto_verify_16_BYTES);

//crypto_verify_16 overload
  ubyte[crypto_verify_16_BYTES] buf1 = void; // = array(iota(ubyte(1), cast(ubyte)(1+crypto_verify_16_BYTES)))[];
version(GNU) // 	GDC (GNU D Compiler) is the compiler ; there, enumerate is not @nogc
{
  size_t idx;
  foreach (e; iota(ubyte(1), cast(ubyte)(1+crypto_verify_16_BYTES)))
    buf1[idx++] = e;
}
else {
  foreach (i, e; iota(ubyte(1), cast(ubyte)(1+crypto_verify_16_BYTES)).enumerate)
    buf1[i] = e;
}
  ubyte[crypto_verify_16_BYTES] buf2 = buf1;
  assert( crypto_verify_16(buf1, buf2));
  buf2[$-1] = 17;
  assert(!crypto_verify_16(buf1, buf2));
}
