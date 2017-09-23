// Written in the D programming language.

module wrapper.sodium.utils;

import wrapper.sodium.core; // assure sodium got initialized
import std.exception : assertThrown, assertNotThrown;

public
import  deimos.sodium.utils :
/*                            sodium_memzero,
                              sodium_memcmp,
                              sodium_compare,
                              sodium_is_zero,
                              sodium_increment,
                              sodium_add,
                              sodium_bin2hex,
                              sodium_hex2bin, */
                              sodium_mlock,
                              sodium_munlock,
                              sodium_malloc,
                              sodium_allocarray,
                              sodium_free,
                              sodium_mprotect_noaccess,
                              sodium_mprotect_readonly,
                              sodium_mprotect_readwrite;


/* overloading some functions between module deimos.sodium.utils and this module, "overload-set" */


/** Zeroing memory.
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero `len` bytes starting at `pnt`, even if
 * optimizations are being applied to the code.
 */
alias sodium_memzero     = deimos.sodium.utils.sodium_memzero;

/** Zeroing memory.
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero the bytes of array `a`, even if
 * optimizations are being applied to the code.
 * @see https://download.libsodium.org/libsodium/content/helpers/memory_management.html
 */
pragma(inline, true)
void sodium_memzero(ubyte[] a) pure nothrow @nogc @trusted
{
//  enforce(a !is null, "a is null"); // not necessary (tested on Linux and Windows)
  sodium_memzero(a.ptr, a.length);
}

/**
 * WARNING: sodium_memcmp() must be used to verify if two secret keys
 * are equal, in constant time.
 * It returns 0 if the keys are equal, and -1 if they differ.
 * This function is not designed for lexicographical comparisons.
 */
alias sodium_memcmp     = deimos.sodium.utils.sodium_memcmp;

/**
 * WARNING: sodium_memcmp() must be used to verify if two secret keys
 * are equal, in constant time.
 * It returns true if the keys are equal, and false if they differ.
 * This function is not designed for lexicographical comparisons.
 * Throws, if  b1_.length != b2_.length
 */
pragma(inline, true)
bool  sodium_memcmp(scope const ubyte[] b1_, scope const ubyte[] b2_) /*pure nothrow*/ @nogc @trusted
{
  // as of DMD 2.0.74, -dip1000 doesn't respect, that in == scope const
  enforce(b1_.length == b2_.length, "Expected b1_.length: ", b1_.length, " to be equal to b2_.length: ", b2_.length);
  return  sodium_memcmp(b1_.ptr, b2_.ptr, b1_.length) == 0; // __attribute__ ((warn_unused_result));
}

/**
 * deviating from the C source, this function received attributes equivalent to __attribute__ ((warn_unused_result))
 *
 * Testing for all zeros.
 * This function returns  1  if the `nlen` bytes vector pointed by `n` contains only zeros.
 * It returns  0  if non-zero bits are found.
 * It's execution time is constant for a given length.
 */
alias sodium_is_zero     = deimos.sodium.utils.sodium_is_zero;

/**
 * deviating from the C source, this function received attributes equivalent to __attribute__ ((warn_unused_result))
 *
 * This function returns  `ţrue`  if array `a` contains only zeros.
 * It returns  `false`  if non-zero bits are found.
 * It's execution time is constant for a given length.
 */
pragma(inline, true)
bool sodium_is_zero(const ubyte[] a) pure nothrow @nogc @trusted
{
//  enforce(n !is null, "n is null"); // not necessary
  return  sodium_is_zero(a.ptr, a.length) == 1;
}

version(LittleEndian) {
  /** Comparing large numbers.
   * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
   * It is suitable for lexicographical comparisons, or to compare nonces
   * and counters stored in little-endian format.
   * However, it is slower than sodium_memcmp().
   * The comparison is done in constant time for a given length.
   */
  alias sodium_compare   = deimos.sodium.utils.sodium_compare;

  /** Comparing large numbers.
   * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
   * The two numbers must have the same length len bytes.
   * It is suitable for lexicographical comparisons, or to compare nonces
   * and counters stored in little-endian format.
   * However, it is slower than sodium_memcmp().
   * The comparison is done in constant time for a given length.
   * Throws, if  b1_.length != b2_.length
   */
  pragma(inline, true)
  int sodium_compare(scope const ubyte[] b1_, scope const ubyte[] b2_) /*pure nothrow*/ @nogc @trusted
  {
//    enforce(b1_ !is null, "b1_ is null"); // not necessary
//    enforce(b2_ !is null, "b2_ is null"); // not necessary
    enforce(b1_.length == b2_.length, "Expected b1_.length: ", b1_.length, " to be equal to b2_.length: ", b2_.length);
    return  sodium_compare(b1_.ptr, b2_.ptr, b1_.length);
  }

  /**
   */
  alias sodium_increment = deimos.sodium.utils.sodium_increment;

  /** Incrementing large numbers.
   * The sodium_increment() function takes an ubyte array representing an arbitrary-long unsigned number,
   * and increments it.
   * It runs in constant-time for a given length, and considers the number to be encoded in little-
   * endian format.
   * sodium_increment() can be used to increment nonces in constant time.
   * This function was introduced in libsodium 1.0.4.
   * Does nothing if the array is null
   */
  pragma(inline, true)
  void sodium_increment(ubyte[] n) pure nothrow @nogc @trusted
  {
//  enforce(n !is null, "n is null"); // not necessary
    sodium_increment(n.ptr, n.length);
  }

  /**
   */
  alias sodium_add       = deimos.sodium.utils.sodium_add;

  /** Adding large numbers
   * The sodium_add() function accepts two arrays of unsigned numbers encoded in little-
   * endian format, a and b, both of size len bytes.
   * It computes (a + b) mod 2^(8*len) in constant time for a given length, and overwrites a
   * with the result.
   * This function was introduced in libsodium 1.0.7.
   * Throws if a_.length != b.length
   * Does nothing if both arrays are null
   */
  pragma(inline, true)
  void sodium_add(scope ubyte[] a, scope const ubyte[] b) /*pure nothrow*/ @nogc @trusted
  {
//    enforce(a !is null, "a is null"); // not necessary
//    enforce(b !is null, "b is null"); // not necessary
    enforce(a.length == b.length, "Expected a.length: ", a.length, " to be equal to b.length: ", b.length);
    sodium_add(a.ptr, b.ptr, a.length);
  }
} // version(LittleEndian)

alias sodium_bin2hex     = deimos.sodium.utils.sodium_bin2hex;

/** Hexadecimal encoding.
 * The sodium_bin2hex() function converts the bytes stored at bin into a hexadecimal string.
 *
 * @see https://download.libsodium.org/libsodium/content/helpers/
 * It evaluates in constant time for a given size.
 * Throws, if  hex.length != 2*bin.length+1
 * hex will receive a terminating null character
 */
pragma(inline, true)
void sodium_bin2hex(scope char[] hex, scope const ubyte[] bin) /*pure nothrow*/ @nogc @trusted
{
//  enforce(bin !is null, "bin is null"); // not necessary
  enforce(bin.length < size_t.max / 2);
  enforce(hex.length == 2*bin.length+1, "Expected hex.length: ", hex.length, " to be equal to 2*bin.length+1: ", 2*bin.length+1);
  sodium_bin2hex(hex.ptr, hex.length, bin.ptr, bin.length);
}

alias sodium_hex2bin     = deimos.sodium.utils.sodium_hex2bin;

/** Hexadecimal decoding.
 * The sodium_hex2bin() function parses a hexadecimal string hex and converts it to a byte sequence bin.
 * ignore_nullterminated is a string of characters to skip.
 * ignore_nullterminated's last character MUST be '\0' in order to save allocating a new C string and thus be @nogc
 * For example, the string ": \0" allows colons and
 * spaces to be present at any locations in the hexadecimal string. These characters will just
 * be ignored. As a result, "69:FC", "69 FC", "69 : FC" and "69FC" will be valid inputs,
 * and will produce the same output.
 * ignore_nullterminated can be set to null in order to disallow any non-hexadecimal character.
 * bin.length is the maximum number of bytes to put into bin, thus bin has to be sized
 * appropriately in advance, as this function doesn't change bin.length.
 * The parser stops when a non-hexadecimal, non-ignored character is found or when
 * bin.length  bytes have been written.
 * bin_len is the number of bytes that actually got written into bin.
 * @returns false if more than bin.length bytes would be required to store the
 * parsed string. It returns true on success and sets `pos_hex_non_parsed` to the position
 * within `hex` following the last parsed character.
 * It evaluates in constant time for a given length and format.
 * @see https://download.libsodium.org/libsodium/content/helpers/
 */
bool sodium_hex2bin(ubyte[] bin, const char[] hex, const string ignore_nullterminated, out size_t bin_len, out size_t pos_hex_non_parsed) pure nothrow @nogc @trusted
{
  import std.algorithm.comparison : clamp;
  const(char)*  hex_non_parsed_ptr;
  bool result;
  try
    result = sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, ignore_nullterminated.ptr, &bin_len, &hex_non_parsed_ptr) == 0;
  catch (Exception e) { /* known not to throw */ }
  pos_hex_non_parsed = cast(size_t) clamp(hex_non_parsed_ptr - hex.ptr, ptrdiff_t(0), ptrdiff_t(hex.length));
  return result;
}


pure @system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 1 from sodium.utils.d");
  }
//sodium_memzero
//sodium_is_zero
  import std.algorithm.searching : any;
  import std.range : iota, array;

  int[8] a = [1,2,3,4,5,6,7,8]; // allocate on the stack
  sodium_memzero(a.ptr, a.length*int.sizeof);
  assert(!any(a[])); // none of a[] evaluate to true
//  assert( all!"a == 0"(a[]));
//  assert(all!(x => x == 0)(a[]));

  int[] b = array(iota(99)); // allocate on the heap
  assert(sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof) == 0);
  sodium_memzero(b.ptr, b.length*int.sizeof);
  assert(!any(b));
  assert(sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof) == 1);

//sodium_memcmp
  a = [1,2,3,4,5,6,7,8];
  b = a.dup;
  assert(sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof) ==  0, "sodium_memcmp error");
  b[7] = 255;
  assert(sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof) == -1, "sodium_memcmp error");

//sodium_compare
//sodium_increment
//sodium_add
version(LittleEndian) {
  //           LSB       MSB
  ubyte[] c = [254,2,3,4,254];
  ubyte[] d = c.dup;
  d[0] = 253;
  d[4] = 255;
  assert(sodium_compare(c.ptr, d.ptr, c.length) == -1);
  d[0] = d[4] = 254;
  assert(sodium_compare(c.ptr, d.ptr, c.length) ==  0);
  c[0] = 253;
  c[4] = 255;
  assert(sodium_compare(c.ptr, d.ptr, c.length) ==  1);

  union anonymous {
    ulong    a = 0x40_00_00_00_00_00_00_00UL;
    ubyte[8] b;
  }
  anonymous  u, v;
  sodium_increment(u.b.ptr, u.b.length);
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);

  sodium_add(u.b.ptr, v.b.ptr, u.b.length);
  assert(u.a == 0x80_00_00_00_00_00_00_01UL);
}
}

/*pure*/ @safe
unittest // same as before except @safe and wrapping delegates + overloads
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 2 from sodium.utils.d");
  }
//sodium_memzero
//sodium_is_zero
  import std.algorithm.searching : any;
  import std.range : iota, array;

  int[8] a = [1,2,3,4,5,6,7,8]; // allocate on the stack
  (() @trusted => sodium_memzero(a.ptr, a.length*int.sizeof))();
  assert(!any(a[]));

  int[] b = array(iota(99)); // allocate on the heap
  assert((() @trusted => sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof))() == 0);
  (() @trusted => sodium_memzero(b.ptr, b.length*int.sizeof))();
  assert(!any(b));
  assert((() @trusted => sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof))() == 1);

//sodium_memcmp
  a = [1,2,3,4,5,6,7,8];
  b = a.dup;
  assert((() @trusted => sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof))() ==  0, "sodium_memcmp error");
  b[7] = 255;
  assert((() @trusted => sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof))() == -1, "sodium_memcmp error");

//sodium_compare (both functions)
//sodium_increment  (both functions)
//sodium_add  (both functions)
//sodium_is_zero (overload)
version(LittleEndian) {
  {
    ulong c, d;
    c = ulong.max-1;
    d = ulong.max;
    /*
    doing several "dangerous" actions here in a controlled way:
    The following operations are not allowed in safe functions:

      No casting from a pointer type to any type other than void*.
      Calling any system functions.
      No taking the address of a local variable or function parameter.
    */
    assert( (() @trusted => sodium_compare(cast(ubyte*)&c, cast(ubyte*)&d, ulong.sizeof))() == -1);
    --d;
    assert( (() @trusted => sodium_compare(cast(ubyte*)&c, cast(ubyte*)&d, ulong.sizeof))() ==  0);
    ++c;
    assert( (() @trusted => sodium_compare(cast(ubyte*)&c, cast(ubyte*)&d, ulong.sizeof))() ==  1);
  }
  {  // testing the overload
  //           LSB       MSB
    ubyte[] c = [254,2,3,4,254];
    ubyte[] d = c.dup;
    assert(!sodium_is_zero(c));
    d[0] = 253;
    d[4] = 255;
    assert(sodium_compare(c, d) == -1);
    assert(!sodium_memcmp(c, d));

    d[0] = d[4] = 254;
    assert(sodium_compare(c, d) ==  0);
    assert( sodium_memcmp(c, d));
    c[0] = 253;
    c[4] = 255;
    assert(sodium_compare(c, d) ==  1);

    assert(sodium_compare(null, null) ==  0);
//    ubyte[] dummy = [1];
//    assertThrown(enforce( sodium_compare(null, dummy) == -1, new Exception("this should be thrown")));
    assert(sodium_is_zero(null));

    sodium_memzero(c);
    assert(sodium_is_zero(c));
    sodium_memzero(null);
  }

  union anonymous {
    ulong    a = 0x40_00_00_00_00_00_00_00UL;
    ubyte[8] b;
  }
  anonymous  u, v;
  (() @trusted => sodium_increment(u.b.ptr, u.b.length))();
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);

  (() @trusted => sodium_add(u.b.ptr, v.b.ptr, u.b.length))();
  assert(u.a == 0x80_00_00_00_00_00_00_01UL);

  u.a = v.a   = 0x40_00_00_00_00_00_00_00UL;
  sodium_increment(u.b);
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);
  sodium_increment(null);

  sodium_add(u.b, v.b);
  assert(u.a == 0x80_00_00_00_00_00_00_01UL);
  ubyte[] dummy; // dummy is null
  sodium_add(dummy, null);
  assert(dummy is null);
} // version(LittleEndian)
}

pure @system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 3 from sodium.utils.d");
  }
  import std.string : fromStringz;

//sodium_bin2hex
  ubyte[] a = [1,2,3,4,255];
  char[] result_out = new char[](11);
  char* result = sodium_bin2hex(result_out.ptr, result_out.length, a.ptr, a.length);
  assert(result.fromStringz==result_out[0..$-1]); // the "strings" result.fromStringz as well as "01020304ff".dup have no terminating \0 character, but result_out has it!
  assert("01020304ff".dup  ==result_out[0..$-1]);

//sodium_hex2bin
  auto    vbuf = cast(immutable(ubyte)[]) x"ac 9f ff 4e ba"; // for comparison
  string  hex = "ac:9f:ff:4e:bay";
  const(char)*  ignore_nullterminated_ptr = ":";
  ubyte[] bin = new ubyte[]((hex.length+1)/3);
  size_t  bin_len;
  const(char)*   hex_end;
  assert(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, ignore_nullterminated_ptr, &bin_len, &hex_end) == 0);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len  == 5);
  assert(hex.ptr+14 == hex_end); // addresses pointing to character y; i.e. hex_end points into hex
  assert(*hex_end == 'y');
//  assert(*++hex_end == '\0'); // i.e. a D string is guaranteed to be followed by a '\0' in memory ? Is this always true ???

  --hex.length;
  hex ~= ":fa";
  bin[]   = ubyte.init; // bin.length unchanged; to small now to incorporate all input
  assert(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, ignore_nullterminated_ptr, &bin_len, &hex_end) == -1);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
/*
  assert(bin_len == 5);
  assert(*hex_end == 'f');
  assert(*++hex_end == 'a');
*/
}

@safe
unittest // same as before except @safe and wrapping delegates + overloads
{
  import std.stdio : writeln;
  import std.algorithm.comparison : equal;
  debug  writeln("unittest block 4 from sodium.utils.d");

//sodium_bin2hex
  ubyte[] a = [1,2,3,4,255];
  char[] result_out = new char[](a.length*2+1);
  char* result = (() @trusted => sodium_bin2hex(result_out.ptr, result_out.length, a.ptr, a.length))();
//  assert(result.fromStringz==result_out[0..$-1]); // the "strings" result.fromStringz as well as "01020304ff".dup have no terminating \0 character, but result_out has it!
  assert(equal("01020304ff", result_out[0..$-1]));
  result_out[] = char.init;
  sodium_bin2hex(result_out, a);
  assert(equal("01020304ff", result_out[0..$-1]));
  char[] one = [char.init];
  sodium_bin2hex(one, null);
  assertThrown(sodium_bin2hex(null, null));

//sodium_hex2bin overload only
  auto    vbuf = cast(immutable(ubyte)[]) x"ac 9f ff 4e ba"; // for comparison
  string  hex = "ac:9f:ff:4e:bay";
  string  ignore_nullterminated = ":\0";
  ubyte[] bin = new ubyte[]((hex.length+1)/3);
  size_t  bin_len, pos_hex_non_parsed;

  assert(sodium_hex2bin(bin, hex, ignore_nullterminated, bin_len, pos_hex_non_parsed));
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len == 5);
  assert(pos_hex_non_parsed == 14);
  assertNotThrown(sodium_hex2bin(bin, hex, null, bin_len, pos_hex_non_parsed));

  --hex.length;
  hex ~= ":fa87";
  bin.length +=1;
  bin[] = ubyte.init;

  assert(!sodium_hex2bin(bin, hex, ignore_nullterminated, bin_len, pos_hex_non_parsed));
  assert(bin == vbuf~ubyte(0xfa));
//  assert(bin_len == 6);
//  assert(pos_hex_non_parsed == 17);
}

@system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 5 from sodium.utils.d");
  }
  import std.algorithm.comparison : equal;
//sodium_mlock
//sodium_munlock
  ubyte[] a = [1,2,3,4,5,6,7,8];
  assert(sodium_is_zero(a.ptr, a.length) == 0);
  {
    assert(      sodium_mlock  (a.ptr, a.length) != -1); // inhibits swapping and excludes from a core dump on Linux
    assert(equal(a, [1,2,3,4,5,6,7,8]));
    scope(exit)  sodium_munlock(a.ptr, a.length); // sodium_munlock calls sodium_memzero internally
  }
  assert(sodium_is_zero(a.ptr, a.length) == 1);
}

@safe
unittest // same as before except @safe and wrapping delegates + overloads
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 6 from sodium.utils.d");
  }
  import std.algorithm.comparison : equal;
//sodium_mlock
//sodium_munlock
  ubyte[] a = [1,2,3,4,5,6,7,8];
  assert(sodium_is_zero(a) == 0);
  {
    assert( (() @trusted => sodium_mlock(a.ptr, a.length))() != -1);
    assert(equal(a, [1,2,3,4,5,6,7,8]));
    scope(exit)  (() @trusted => sodium_munlock(a.ptr, a.length))();
  }
  assert(sodium_is_zero(a) == 1);
}

@system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 7 from sodium.utils.d");
  }
  import std.conv : emplace;
  import std.algorithm.searching : all;
  import std.algorithm.comparison : equal;

  struct S {
    int[16] a;
  }
//sodium_malloc
//sodium_free
  S* p = cast(S*)sodium_malloc(64);
  scope(exit)  sodium_free(p);
  emplace!S(p, S( [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]));
  assert(equal(p.a[], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]));
  int[] arr_int = new (p) int[16];
  assert( all!"a == 0"(arr_int));

  enum s_len = 2;
  alias s_type = S[s_len];
//sodium_allocarray
  s_type* p2 = cast(s_type*)sodium_allocarray(s_len, 64);
  scope(exit)  sodium_free(p2);
  emplace!s_type(p2, S( [17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]));
  assert( (*p2)[0].a == [17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]);
  assert( (*p2)[1].a == [17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32]);

  ubyte* p3 = cast(ubyte*)sodium_malloc(64);
  scope(exit)  sodium_free(p3);
  ubyte[] arr_ubyte = p3[0..64]; // may be ubyte[] as well, but may not be increased, to still live in sodium_malloc'ed chunk!
//  writefln("arr_ubyte = p3[0..64] : [%(%02X %)]", p3[0..64]);
//assert( all!"a == 0xD0"(arr_ubyte));   in version 1.0.11
  assert( all!"a == 0xDB"(arr_ubyte)); //in version 1.0.12
  assert( arr_ubyte.capacity == 0);

  p.a = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16];
//sodium_mprotect_noaccess
  sodium_mprotect_noaccess(p);
  //assert(equal(p.a[], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16])); //unrecoverable, just crashes !

//sodium_mprotect_readonly
  sodium_mprotect_readonly(p);
  assert(equal(p.a[], [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]));
  //p.a[0] = 0;  //unrecoverable, just crashes !

//sodium_mprotect_readwrite
  sodium_mprotect_readwrite(p);
  p.a[0] = 0;
  assert(p.a[0] == 0);
}

@nogc @safe
unittest
{
  import std.string : fromStringz; // is @system
  ubyte[8] a, b;
  sodium_memzero(a);
  assert(sodium_is_zero(a));
  assert(sodium_memcmp(a, b));
  assert(sodium_compare(a, b) == 0);
  sodium_increment(a);
  sodium_add(a, b);
  char[17] hex;
  sodium_bin2hex(hex, a);
  size_t bin_len, pos_hex_non_parsed;
  assert(sodium_hex2bin(b, (() @trusted => fromStringz(hex.ptr))(), null, bin_len, pos_hex_non_parsed));
  assert(bin_len == 8);
  assert(pos_hex_non_parsed == 16);
}