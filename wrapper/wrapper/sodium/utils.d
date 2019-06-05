// Written in the D programming language.

/**
 * Utility functions and unittests.
 */

module wrapper.sodium.utils;

import wrapper.sodium.core; // assure sodium got initialized
import std.exception : assertThrown, assertNotThrown;
import nogc.exception: enforce;

public
import  deimos.sodium.utils :
//                            sodium_memzero,
                              sodium_stackzero,
/*                            sodium_memcmp,
                              sodium_compare,
                              sodium_is_zero,
                              sodium_increment,
                              sodium_add,
                              sodium_sub,
                              sodium_bin2hex,
                              sodium_hex2bin, */
                              sodium_base64_VARIANT_ORIGINAL,
                              sodium_base64_VARIANT_ORIGINAL_NO_PADDING,
                              sodium_base64_VARIANT_URLSAFE,
                              sodium_base64_VARIANT_URLSAFE_NO_PADDING,
                              sodium_base64_ENCODED_LEN,
                              sodium_base64_encoded_len,
//                            sodium_bin2base64,
//                            sodium_base642bin,
                              sodium_mlock,
                              sodium_munlock,
                              sodium_malloc,
                              sodium_allocarray,
                              sodium_free,
                              sodium_mprotect_noaccess,
                              sodium_mprotect_readonly,
                              sodium_mprotect_readwrite;
//                            sodium_pad,
//                            sodium_unpad;


/* overloading some functions between module deimos.sodium.utils and this module, "overload-set" */


/** Zeroing memory.
 *
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero `len` bytes starting at `pnt`, even if
 * optimizations are being applied to the code.
 * See_Also: https://download.libsodium.org/doc/memory_management#zeroing-memory
 */
alias sodium_memzero     = deimos.sodium.utils.sodium_memzero;

/** Zeroing memory.
 *
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero the bytes of array `a`, even if
 * optimizations are being applied to the code.
 * See_Also: https://download.libsodium.org/doc/memory_management#zeroing-memory
 */
pragma(inline, true)
void sodium_memzero(scope ubyte[] a) @nogc nothrow pure @trusted
{
//    enforce(a !is null, "a is null"); // not necessary (tested on Linux and Windows)
    sodium_memzero(&a[0], a.length);
}

/** Constant-time test for equality
 *
 * WARNING: sodium_memcmp() must be used to verify if two secret keys
 * are equal, in constant time.
 * This function is not designed for lexicographical comparisons.
 * Returns: 0 if the keys are equal, and -1 if they differ.
 * See_Also: https://download.libsodium.org/doc/helpers#constant-time-test-for-equality
 */
alias sodium_memcmp     = deimos.sodium.utils.sodium_memcmp;

/** Constant-time test for equality
 *
 * WARNING: sodium_memcmp() must be used to verify if two secret keys
 * are equal, in constant time (if array's length are equal).
 * If array's length are NOT equal, the decision is solely based on that,
 * i.e. no constant time guarantee and the function returns false.
 * This function is not designed for lexicographical comparisons.
 * Preferably use this function with equal length arrays.
 * Returns: true if the keys are equal, and false if they differ.
 * See_Also: https://download.libsodium.org/doc/helpers#constant-time-test-for-equality
 */
pragma(inline, true)
bool  sodium_memcmp(scope const ubyte[] b1_, scope const ubyte[] b2_) @nogc nothrow pure @trusted
{
    if (b1_.length != b2_.length)
        return false;
    return sodium_memcmp(&b1_[0], &b2_[0], b1_.length) == 0; // __attribute__ ((warn_unused_result))
}

/** Comparing large numbers.
 *
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.
 * However, it is slower than sodium_memcmp().
 * The comparison is done in constant time for a given length.
 * Returns: -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
 * See_Also: https://download.libsodium.org/doc/helpers#comparing-large-numbers
 */
alias sodium_compare   = deimos.sodium.utils.sodium_compare;

/** Comparing large numbers.
 *
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.
 * However, it is slower than sodium_memcmp().
 * The comparison is done in constant time for a given length.
 * The two numbers don't need to have the same length in bytes.
 * If array's length are NOT equal, the decision may be based on that, i.e. no constant time guarantee.
 * Preferably use this function with equal length arrays.
 * Returns: -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
 * See_Also: https://download.libsodium.org/doc/helpers#comparing-large-numbers
 */
pragma(inline, true)
int sodium_compare(scope const ubyte[] b1_, scope const ubyte[] b2_) @nogc nothrow pure @trusted
{
    import std.algorithm.comparison: min;
    if      (b1_.length < b2_.length && !sodium_is_zero(b2_[b1_.length..$]))
        return -1;
    else if (b1_.length > b2_.length && !sodium_is_zero(b1_[b2_.length..$]))
        return 1;
    return  sodium_compare(&b1_[0], &b2_[0], min(b1_.length, b2_.length)); // __attribute__ ((warn_unused_result));
}

/** Testing for all zeros.
 *
 * It's execution time is constant for a given length.
 * Returns:  1  if the `nlen` bytes vector pointed by `n` contains only zeros.
 *           0  if non-zero bits are found.
 * See_Also: https://download.libsodium.org/doc/helpers#testing-for-all-zeros
 */
alias sodium_is_zero     = deimos.sodium.utils.sodium_is_zero;

/** Testing for all zeros.
 *
 * It's execution time is constant for a given length.
 * Returns:  `ţrue`  if array `a` contains only zeros.
 *           `false`  if non-zero bits are found.
 * See_Also: https://download.libsodium.org/doc/helpers#testing-for-all-zeros
 */
pragma(inline, true)
bool sodium_is_zero(const ubyte[] a) @nogc nothrow pure @trusted
{
//  enforce(a !is null, "a is null"); // not necessary
    return  sodium_is_zero(a.ptr, a.length) == 1;
}

/// See_Also: https://download.libsodium.org/doc/helpers#incrementing-large-numbers
alias sodium_increment = deimos.sodium.utils.sodium_increment;

/** Incrementing large numbers.
 * The sodium_increment() function takes an ubyte array representing an arbitrary-long unsigned number,
 * and increments it.
 * It runs in constant-time for a given length, and considers the number to be encoded in little-
 * endian format.
 * sodium_increment() can be used to increment nonces in constant time.
 * This function was introduced in libsodium 1.0.4.
 * Does nothing if the array is null
 * See_Also: https://download.libsodium.org/doc/helpers#incrementing-large-numbers
 */
pragma(inline, true)
void sodium_increment(ubyte[] n) @nogc nothrow pure @trusted
{
//  enforce(n !is null, "n is null"); // not necessary
    sodium_increment(n.ptr, n.length);
}

/// See_Also: https://download.libsodium.org/doc/helpers#adding-large-numbers
alias sodium_add       = deimos.sodium.utils.sodium_add;

/** Adding large numbers
 *
 * The sodium_add() function accepts two arrays of unsigned numbers encoded in little-
 * endian format, a and b, both of size len bytes.
 * It computes (a + b) mod 2^(8*len) in constant time for a given length, and overwrites a
 * with the result.
 * History: This function was introduced in libsodium 1.0.7.
 * Throws: NoGcException, if a_.length != b.length
 * See_Also: https://download.libsodium.org/doc/helpers#adding-large-numbers
 */
pragma(inline, true)
void sodium_add(scope ubyte[] a, scope const ubyte[] b) @nogc /*nothrow pure*/ @trusted
{
    enforce(a.length == b.length, "a.length doesn't equal b.length");
//    enforce(a !is null, "a and b are null"); // not necessary
    sodium_add(a.ptr, b.ptr, a.length);
}

version(bin_v1_0_16) {}
else {
    /// See_Also: https://download.libsodium.org/doc/helpers#substracting-large-numbers
    alias sodium_sub       = deimos.sodium.utils.sodium_sub;

    /** Substracting large numbers
     * The sodium_sub() function accepts two arrays of unsigned numbers encoded in little-
     * endian format, a and b, both of size len bytes.
     * It computes (a - b) mod 2^(8*len) in constant time for a given length, and overwrites a
     * with the result.
     * History: This function was introduced in libsodium 1.0.17.
     * Throws: NoGcException, if a_.length != b.length
     * See_Also: https://download.libsodium.org/doc/helpers#substracting-large-numbers
     */
    pragma(inline, true)
    void sodium_sub(scope ubyte[] a, scope const ubyte[] b) @nogc /*nothrow pure*/ @trusted
    {
        enforce(a.length == b.length, "a.length doesn't equal b.length");
//        enforce(a !is null, "a and b are null"); // not necessary
        sodium_sub(a.ptr, b.ptr, a.length);
    }
} // version(> bin_v1_0_16)

/// Returns: char* hex
/// See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
alias sodium_bin2hex     = deimos.sodium.utils.sodium_bin2hex;

/** Hexadecimal encoding.
 * The sodium_bin2hex() function converts the bytes stored at bin into a hexadecimal string.
 *
 * It evaluates in constant time for a given size.
 * hex will receive a terminating null character
 * Throws: NoGcException, if  hex.length != 2*bin.length+1  or bin.length >= size_t.max/2
 * See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
 */
pragma(inline, true)
void sodium_bin2hex(scope char[] hex, scope const ubyte[] bin) @nogc /*nothrow pure*/ @trusted
{
    enforce(bin.length < size_t.max/2);
//  enforce(hex.length == 2*bin.length+1, "Expected hex.length: ", hex.length, " to be equal to 2*bin.length+1: ", 2*bin.length+1);
    enforce(hex.length == 2*bin.length+1, "Expected hex.length is not equal to 2*bin.length+1");
    sodium_bin2hex(hex.ptr, hex.length, bin.ptr, bin.length); // __attribute__ ((nonnull(1)));
}

/// Returns:  0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
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
 * appropriately in advance as >= hex.length/2, otherwise the function throws.
 * The parser stops when a non-hexadecimal, non-ignored character is found or when
 * bin.length  bytes have been written.
 * bin_len is the number of bytes that actually got written into bin.
 * @returns always true (success) and sets `pos_hex_non_parsed` to the position
 * within `hex` following the last parsed character.
 * It evaluates in constant time for a given length and format.
 * Returns:  true  on success,  false  otherwise
 * Throws: NoGcException, if  bin.length < hex.length/2
 * See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
 */
bool sodium_hex2bin(scope ubyte[] bin, const char[] hex, const string ignore_nullterminated,
                    out size_t bin_len, out size_t pos_hex_non_parsed) @nogc /*nothrow pure*/ @trusted
{
    import std.algorithm.comparison : clamp;
    enforce(bin.length >= hex.length/2);
    const(char)*  hex_non_parsed_ptr;
    bool result;
    result = sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, ignore_nullterminated.ptr, &bin_len, &hex_non_parsed_ptr) == 0;
    pos_hex_non_parsed = cast(size_t) clamp(hex_non_parsed_ptr - hex.ptr, ptrdiff_t(0), ptrdiff_t(hex.length)); // __attribute__ ((nonnull(1)));
    return result;
}

/// Returns: char* b64
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
alias sodium_bin2base64  = deimos.sodium.utils.sodium_bin2base64;

/// Throws: NoGcException, if  b64.length < sodium_base64_encoded_len(bin.length, variant)
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
pragma(inline, true)
void sodium_bin2base64(scope char[] b64, scope const ubyte[] bin, const int variant) @nogc /*nothrow pure*/ @trusted
{
    size_t min_len = sodium_base64_encoded_len(bin.length, variant);
    enforce(b64.length >= min_len);
    sodium_bin2base64(b64.ptr, b64.length, bin.ptr, bin.length, variant); // __attribute__ ((nonnull(1)));
}

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
alias sodium_base642bin  = deimos.sodium.utils.sodium_base642bin;

/// Returns: true  on success,  false  otherwise
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
bool sodium_base642bin(scope ubyte[] bin, const char[] b64, const string ignore_nullterminated,
                       out size_t bin_len, out size_t pos_b64_non_parsed, const int variant) /*@nogc nothrow pure*/ @trusted
{
    import std.algorithm.comparison : clamp;
    import std.algorithm.searching: countUntil; // not @nogc
    import std.range: retro;
    const(char)*  b64_non_parsed_ptr;
    bool result;
    enforce(bin.length >= (b64.length-1)/4*3 -countUntil!"a!=b"(b64[0..$-1].retro, '='));
    result = sodium_base642bin(&bin[0], bin.length, b64.ptr, b64.length, ignore_nullterminated.ptr, &bin_len, &b64_non_parsed_ptr, variant) == 0;
    pos_b64_non_parsed = cast(size_t) clamp(b64_non_parsed_ptr - b64.ptr, ptrdiff_t(0), ptrdiff_t(b64.length)); // __attribute__ ((nonnull(1)));
    return result;
}

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
alias sodium_pad         = deimos.sodium.utils.sodium_pad;

/// Returns: true  on success,  false  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
pragma(inline, true)
bool sodium_pad(out size_t padded_buflen, scope ubyte[] buf,
                size_t unpadded_buflen, size_t blocksize)  @nogc nothrow pure @trusted
{
    return sodium_pad(&padded_buflen, buf.ptr, unpadded_buflen, blocksize, buf.length) == 0;
}


/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
alias sodium_unpad       = deimos.sodium.utils.sodium_unpad;

/// Returns: true  on success,  false  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
pragma(inline, true)
bool sodium_unpad(out size_t unpadded_buflen, scope ubyte[] buf,
                  size_t padded_buflen, size_t blocksize)  @nogc /*nothrow*/ pure @trusted
{
    return sodium_unpad(&unpadded_buflen, buf.ptr, padded_buflen, blocksize) == 0;
}



pure @system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 1 from sodium.utils.d");
  }
  assert(sodium_base64_ENCODED_LEN(19, sodium_base64_VARIANT_ORIGINAL)            == sodium_base64_encoded_len(19, sodium_base64_VARIANT_ORIGINAL));
  assert(sodium_base64_ENCODED_LEN(19, sodium_base64_VARIANT_ORIGINAL_NO_PADDING) == sodium_base64_encoded_len(19, sodium_base64_VARIANT_ORIGINAL_NO_PADDING));
  assert(sodium_base64_ENCODED_LEN(19, sodium_base64_VARIANT_URLSAFE)             == sodium_base64_encoded_len(19, sodium_base64_VARIANT_URLSAFE));
  assert(sodium_base64_ENCODED_LEN(19, sodium_base64_VARIANT_URLSAFE_NO_PADDING)  == sodium_base64_encoded_len(19, sodium_base64_VARIANT_URLSAFE_NO_PADDING));
//sodium_memzero
//sodium_stackzero
//sodium_is_zero
  import std.algorithm.searching : any;
  import std.range : iota, array;

  int[8] a = [1,2,3,4,5,6,7,8]; // allocate on the stack
  sodium_memzero(a.ptr, a.length*int.sizeof);

  assert(!any(a[])); // none of a[] evaluate to true
//  assert( all!"a == 0"(a[]));
//  assert(all!(x => x == 0)(a[]));
  sodium_memzero(null, 0);
  sodium_stackzero(8); // TODO check this later

  int[] b = array(iota(99)); // allocate on the heap
  assert(sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof) == 0);
  sodium_memzero(b.ptr, b.length*int.sizeof);
  assert(!any(b));
  assert(sodium_is_zero(cast(ubyte*)b.ptr, b.length*int.sizeof) == 1);
  assert(sodium_is_zero(null, 0) == 1);

//sodium_memcmp
  a = [1,2,3,4,5,6,7,8];
  b = a.dup;
  assert(sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof) ==  0, "sodium_memcmp error");
  b[7] = 255;
  assert(sodium_memcmp(a.ptr, b.ptr, a.length*int.sizeof) == -1, "sodium_memcmp error");
  cast(void) sodium_memcmp(null, null, 0);

//sodium_compare
//sodium_increment
//sodium_add

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
  assert(sodium_compare(null, null, 0) ==  0);

  union anonymous {
    ulong    a = 0x40_00_00_00_00_00_00_00UL;
    ubyte[8] b;
  }
  anonymous  u, v, w;
  sodium_increment(u.b.ptr,    u.b.length);
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);

  sodium_add(u.b.ptr, v.b.ptr, u.b.length);
  assert(u.a == 0x80_00_00_00_00_00_00_01UL);
  sodium_add(null, null, 0);

version(bin_v1_0_16) {}
else {
  sodium_sub(u.b.ptr, w.b.ptr, u.b.length);
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);
}

  ubyte[100]  buf;
  size_t      buf_unpadded_len  =  10;
  size_t      buf_padded_len;
  size_t      block_size  =  16;
  /* round the length of the buffer to a multiple of `block_size` by appending
   * padding data and put the new, total length into `buf_padded_len` */
  assert(sodium_pad(&buf_padded_len, buf.ptr, buf_unpadded_len, block_size, buf.sizeof) == 0);
  assert(buf_padded_len == 16); // otherwise  /* overflow!  buf[] is not large enough */
  buf_unpadded_len = 0;
  /* compute the original, unpadded length */
  assert(sodium_unpad(&buf_unpadded_len, buf.ptr, buf_padded_len, block_size) ==  0);
  assert(buf_unpadded_len == 10); // otherwise  /* incorrect padding */
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
    // checking unequal length
    d ~= 0;
    assert(sodium_compare(c, d) ==  1);
    c = [254,2,3,4,254];
    d = [254,2,3,4,254, 0];
    assert(sodium_compare(c, d) ==  0);
    c ~= 0;
    d.length = 5;
    d[0] = 253;
    d[4] = 255;
    assert(sodium_compare(c, d) == -1);

    d = c.dup;
    d ~= 0;
    assert(!sodium_memcmp(c, d));

////    assert(sodium_compare(null, null) ==  0);
//    ubyte[] dummy = [1];
//    assertThrown(enforce( sodium_compare(null, dummy) == -1, new Exception("this should be thrown")));
    assert(sodium_is_zero(null));

    sodium_memzero(c);
    assert(sodium_is_zero(c));
//    sodium_memzero(null);
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

  ubyte[100]  buf;
  size_t      buf_unpadded_len  =  10;
  size_t      buf_padded_len;
  size_t      block_size  =  16;
  /* round the length of the buffer to a multiple of `block_size` by appending
   * padding data and put the new, total length into `buf_padded_len` */
  assert(sodium_pad(buf_padded_len, buf, buf_unpadded_len, block_size));
  assert(buf_padded_len == 16); // otherwise  /* overflow!  buf[] is not large enough */
  buf_unpadded_len = 0;
  /* compute the original, unpadded length */
  assert(sodium_unpad(buf_unpadded_len, buf, buf_padded_len, block_size));
  assert(buf_unpadded_len == 10); // otherwise  /* incorrect padding */
}

pure @system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 3 from sodium.utils.d");
  }
  import std.string : fromStringz;
  import std.conv : hexString;

//sodium_bin2hex
  ubyte[] a = [1,2,3,4,255];
  char[] result_out = new char[](11);
  char* result = sodium_bin2hex(result_out.ptr, result_out.length, a.ptr, a.length);
  assert(result.fromStringz==result_out[0..$-1]); // the "strings" result.fromStringz as well as "01020304ff".dup have no terminating \0 character, but result_out has it!
  assert("01020304ff".dup  ==result_out[0..$-1]);

//sodium_hex2bin
  auto    vbuf = cast(immutable(ubyte)[]) hexString!"ac 9f ff 4e ba"; // for comparison
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
  assert(bin_len == 0);
  assert(*hex_end == 'f');
  assert(*++hex_end == 'a');
}

@safe
unittest // same as before except @safe and wrapping delegates + overloads
{
  import std.stdio : writeln;
  import std.algorithm.comparison : equal;
  import std.conv : hexString;
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
  auto    vbuf = cast(immutable(ubyte)[]) hexString!"ac 9f ff 4e ba"; // for comparison
  string  hex = "ac:9f:ff:4e:bay";
  string  ignore_nullterminated = ":\0";
  ubyte[] bin = new ubyte[](hex.length/2); //((hex.length+1)/3);
  size_t  bin_len, pos_hex_non_parsed;

  assert(sodium_hex2bin(bin, hex, ignore_nullterminated, bin_len, pos_hex_non_parsed));
  assert(bin_len == 5);
  assert(bin[0..bin_len] == vbuf); // [172, 159, 255, 78, 186]);
  assert(pos_hex_non_parsed == 14);
  assertNotThrown(sodium_hex2bin(bin, hex, null, bin_len, pos_hex_non_parsed));
/*
  --hex.length;
  hex ~= ":fa87";
//  bin.length = hex.length/2;
  bin[] = ubyte.init;
  assert(!sodium_hex2bin(bin, hex, ignore_nullterminated, bin_len, pos_hex_non_parsed));
  assert(bin[0..6] == vbuf~ubyte(0xfa));
  assert(bin_len == 0);
  assert(pos_hex_non_parsed == 17);
*/
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
  assert(!sodium_is_zero(a));
  {
    assert( (() @trusted => sodium_mlock(a.ptr, a.length))() != -1);
    assert(equal(a, [1,2,3,4,5,6,7,8]));
    scope(exit)  (() @trusted => sodium_munlock(a.ptr, a.length))();
  }
  assert(sodium_is_zero(a));

  a = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83];
  size_t min_len = sodium_base64_encoded_len(a.length, sodium_base64_VARIANT_ORIGINAL);
  char[] b64 = new char[](min_len); // 29
  sodium_bin2base64(b64, a, sodium_base64_VARIANT_ORIGINAL);
//  writeln(b64); // QUJDREVGR0hJSktMTU5PUFFSUw==
  a[] = ubyte.init;
  size_t bin_len;
  size_t pos_b64_non_parsed;
  assert(sodium_base642bin(a, b64, null, bin_len, pos_b64_non_parsed, sodium_base64_VARIANT_ORIGINAL));
  assert(bin_len == a.length);
  assert(equal(a, [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83]));
  assert(pos_b64_non_parsed == b64.length-1);
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