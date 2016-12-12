module sodium.utils;

extern(C) /*nothrow*/ @nogc @system {
/*
in fact, all of sodiums functions are nothrow as well, but since DMD 2.066.0: http://dlang.org/changelog/2.066.0.html#warn-unused-retval
declaring both pure and nothrow (for functions returning other than void) together with compiler warnings enabled (-w)
acts like __attribute__ ((warn_unused_result)) in C/C++,
which is a feature used in the C headers and given preference to be expressed the same in the D binding.

I assume, some functions do alter mutable global state, like sodium_mlock, but I assume not visible for/affecting D, thus pure seems justified for all
functions accept the alloc/free one's
*/

/** Zeroing memory.<br>
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero len_bytes bytes starting at pnt, even if
 * optimizations are being applied to the code.
 * @see https://download.libsodium.org/libsodium/content/helpers/memory_management.html<br>
 * May be called from @safe functions e.g. by supplying an array arr ( T[dim] or T[] ) and invoking (the delegate wrapper):
 * (() @trusted => sodium_memzero(arr.ptr, arr.length*T.sizeof))(); 
 */
void sodium_memzero(void* pnt, in size_t len_bytes) pure nothrow;

/** Constant-time test for equality.<br>
 * When a comparison involves secret data (e.g. key, authentication tag), is it critical to use a
 * constant-time comparison function in order to mitigate side-channel attacks.
 * The sodium_memcmp() function can be used for this purpose.<br>
 * WARNING: sodium_memcmp() must be used to verify if two secret keys are equal, in constant time.<br>
 * NOTE: sodium_memcmp() is not a lexicographic comparator and is not a generic replacement for memcmp().<br>
 * <br>
 * @see https://download.libsodium.org/libsodium/content/helpers/<br>
 * @returns 0 if the len bytes pointed to by b1_ match the len bytes pointed to by b2_.
 * Otherwise, it returns -1.
 * May be called from @safe functions by supplying arrays arr1 and arr2 ( T[dim] or T[] ) that definitely have 
 * the same element type as well as the same length (or arr2.length>arr1.length; not checked in C code!)
 * and invoking (the delegate wrapper):
 * int rv = (() @trusted => sodium_memcmp(arr1.ptr, arr2.ptr, arr1.length*T.sizeof))(); 
 */
int sodium_memcmp(in void* b1_, in void* b2_, in size_t len_bytes) pure nothrow;

version(LittleEndian) {
/** Comparing large numbers.<br>
 * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_<br>
 * The two numbers must have the same length len bytes<br>
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.<br>
 * However, it is slower than sodium_memcmp().
 * The comparison is done in constant time for a given length.
 * May be called from @safe functions e.g.  by supplying (likely ubyte[] or) 2 numbers num1, num2 of same type T and invoking (the delegate wrapper):
 * int rv = (() @trusted => sodium_compare(cast(const ubyte*)&num1, cast(const ubyte*)&num2, T.sizeof))();
 */
  int sodium_compare(in ubyte* b1_, in ubyte* b2_, in size_t len_bytes) pure nothrow;
}

/** Testing for all zeros.<br>
 * This function returns 1 if the nlen bytes vector pointed by n contains only zeros.
 * It returns 0 if non-zero bits are found.<br>
 * Its execution time is constant for a given length.<br>
 * This function was introduced in libsodium 1.0.7.
 * May be called from @safe functions by supplying an array arr ( ubyte[dim] or ubyte[] ) and invoking (the delegate wrapper):
 * int rv = (() @trusted => sodium_is_zero(arr.ptr, arr.length))(); 
 */
int sodium_is_zero(in ubyte* n, in size_t nlen) pure;
	
version(LittleEndian) {
  /** Incrementing large numbers.
   * The sodium_increment() function takes a pointer to an arbitrary-long unsigned number, and
   * increments it.
   * It runs in constant-time for a given length, and considers the number to be encoded in little-
   * endian format.
   * sodium_increment() can be used to increment nonces in constant time.
   * This function was introduced in libsodium 1.0.4. */
  void sodium_increment(ubyte* n, in size_t nlen) pure nothrow;

  /** Adding large numbers
   * The sodium_add() function accepts two pointers to unsigned numbers encoded in little-
   * endian format, a and b, both of size len bytes.
   * It computes (a + b) mod 2^(8*len) in constant time for a given length, and overwrites a 
   * with the result.
   * This function was introduced in libsodium 1.0.7. */
  void sodium_add(ubyte* a, in ubyte* b, in size_t len) pure nothrow;
}

/** Hexadecimal encoding.<br>
 * The sodium_bin2hex() function converts bin_len bytes stored at bin into a hexadecimal string.<br>
 * The string is stored into hex and includes a null byte (\0) terminator.<br>
 * hex_maxlen is the maximum number of bytes that the function is allowed to write starting at
 * hex. It should be at least bin_len * 2 + 1.
 * <br>
 * @see https://download.libsodium.org/libsodium/content/helpers/<br>
 * @returns hex on success, or null on overflow. It evaluates in constant time for a given size. */
char* sodium_bin2hex(char* hex, in size_t hex_maxlen, in ubyte* bin, in size_t bin_len) pure;

/** Hexadecimal decoding.<br>
 * The sodium_hex2bin() function parses a hexadecimal string hex and converts it to a byte sequence.<br>
 * hex does not have to be null terminated, as the number of characters to parse is supplied
 * via the hex_len parameter.<br>
 * ignore is a string of characters to skip. For example, the string ": " allows colons and
 * spaces to be present at any locations in the hexadecimal string. These characters will just
 * be ignored. As a result, "69:FC", "69 FC", "69 : FC" and "69FC" will be valid inputs,
 * and will produce the same output.<br>
 * ignore can be set to null in order to disallow any non-hexadecimal character.<br>
 * bin_maxlen is the maximum number of bytes to put into bin.<br>
 * The parser stops when a non-hexadecimal, non-ignored character is found or when
 * bin_maxlen  bytes have been written.<br>
 * @returns -1 if more than bin_maxlen bytes would be required to store the
 * parsed string. It returns 0 on success and sets hex_end, if it is not null, to a pointer to
 * the character following the last parsed character.
 * It evaluates in constant time for a given length and format.<br>
 * @see https://download.libsodium.org/libsodium/content/helpers/<br> */
int sodium_hex2bin(ubyte* bin, in size_t bin_maxlen, in char* hex, in size_t hex_len
  ,in char* ignore, size_t* bin_len, char** hex_end) pure;

/** Locking memory against swapping
 * The sodium_mlock() function locks at least len_bytes bytes of memory starting at addr.
 * This can help avoid swapping sensitive data to disk.
 * In addition, it is recommended to totally disable swap partitions on machines processing
 * sensitive data, or, as a second choice, use encrypted swap partitions.
 * For similar reasons, on Unix systems, one should also disable core dumps when running
 * crypto code outside a development environment. This can be achieved using a shell built-in
 * such as ulimit or programatically using setrlimit(RLIMIT_CORE, &(struct rlimit) {0, 0}).
 * On operating systems where this feature is implemented, kernel crash dumps should also be
 * disabled (e.g. https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html).
 * sodium_mlock() wraps mlock() and VirtualLock(). Note: Many systems place limits on
 * the amount of memory that may be locked by a process. Care should be taken to raise those
 * limits (e.g. Unix ulimits) where neccessary. sodium_mlock() will return -1 when any limit is
 * reached.
 * On systems where it is supported, sodium_mlock() also wraps madvise() and advises the
 * kernel not to include the locked memory in core dumps.
 */
int sodium_mlock(void* addr, in size_t len_bytes) pure;
	
/** Unlocking memory
 * The sodium_munlock() function should be called after locked memory is not being used any
 * more. It will zero len bytes starting at addr before actually flagging the pages as
 * swappable again. Calling sodium_memzero() prior to sodium_munlock() is thus not required.
 */
int sodium_munlock(void* addr, in size_t len) pure;
	
/** WARNING: sodium_malloc() and sodium_allocarray() are not general-purpose
 * allocation functions.
 *
 * They return a pointer to a region filled with 0xd0 bytes, immediately
 * followed by a guard page.
 * As a result, accessing a single byte after the requested allocation size
 * will intentionally trigger a segmentation fault.
 *
 * A canary and an additional guard page placed before the beginning of the
 * region may also kill the process if a buffer underflow is detected.
 *
 * The memory layout is:
 * [unprotected region size (read only)][guard page (no access)][unprotected pages (read/write)][guard page (no access)]
 * With the layout of the unprotected pages being:
 * [optional padding][16-bytes canary][user region]
 *
 * However:
 * - These functions are significantly slower than standard functions
 * - Each allocation requires 3 or 4 additional pages
 * - The returned address will not be aligned if the allocation size is not
 *   a multiple of the required alignment. For this reason, these functions
 *   are designed to store data, such as secret keys and messages.
 *
 * sodium_malloc() can be used to allocate any libsodium data structure,
 * with the exception of crypto_generichash_state.
 *
 * The crypto_generichash_state structure is packed and its length is
 * either 357 or 361 bytes. For this reason, when using sodium_malloc() to
 * allocate a crypto_generichash_state structure, padding must be added in
 * order to ensure proper alignment:
 * state = sodium_malloc((crypto_generichash_statebytes() + (size_t) 63U)
 *                       & ~(size_t) 63U);
 */
void* sodium_malloc(in size_t size) nothrow;

/** WARNING: sodium_malloc() and sodium_allocarray() are not general-purpose
 * allocation functions.
 *
 * They return a pointer to a region filled with 0xd0 bytes, immediately
 * followed by a guard page.
 * As a result, accessing a single byte after the requested allocation size
 * will intentionally trigger a segmentation fault.
 *
 * A canary and an additional guard page placed before the beginning of the
 * region may also kill the process if a buffer underflow is detected.
 *
 * The memory layout is:
 * [unprotected region size (read only)][guard page (no access)][unprotected pages (read/write)][guard page (no access)]
 * With the layout of the unprotected pages being:
 * [optional padding][16-bytes canary][user region]
 *
 * However:
 * - These functions are significantly slower than standard functions
 * - Each allocation requires 3 or 4 additional pages
 * - The returned address will not be aligned if the allocation size is not
 *   a multiple of the required alignment. For this reason, these functions
 *   are designed to store data, such as secret keys and messages.
 *
 * sodium_malloc() can be used to allocate any libsodium data structure,
 * with the exception of crypto_generichash_state.
 *
 * The crypto_generichash_state structure is packed and its length is
 * either 357 or 361 bytes. For this reason, when using sodium_malloc() to
 * allocate a crypto_generichash_state structure, padding must be added in
 * order to ensure proper alignment:
 * state = sodium_malloc((crypto_generichash_statebytes() + (size_t) 63U)
 *                       & ~(size_t) 63U);
 */
void* sodium_allocarray(in size_t count, in size_t size) nothrow;

void sodium_free(void* ptr) nothrow;
	
/**
 * The sodium_mprotect_noaccess() function makes a region allocated using sodium_malloc() 
 * or sodium_allocarray() inaccessible. It cannot be read or written, but the data are
 * preserved.
 * This function can be used to make confidential data inaccessible except when actually
 * needed for a specific operation.
 */
int sodium_mprotect_noaccess(void* ptr) pure;
	
/**
 * The sodium_mprotect_readonly() function marks a region allocated using sodium_malloc() 
 * or sodium_allocarray() as read-only.
 * Attempting to modify the data will cause the process to terminate.
 */
int sodium_mprotect_readonly(void* ptr) pure;
	
/**
 * The sodium_mprotect_readwrite() function marks a region allocated using sodium_malloc() 
 * or sodium_allocarray() as readable and writable, after having been protected using
 * sodium_mprotect_readonly() or sodium_mprotect_noaccess().
 */
int sodium_mprotect_readwrite(void* ptr) pure;

} // extern(C) /*nothrow*/ @nogc @system


/*  END OF TRANSLATED HEADER */



/* overloaded functions */

import std.exception : enforce, assumeWontThrow, assumeUnique;

/** Zeroing memory.<br>
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero len_bytes bytes starting at pnt, even if
 * optimizations are being applied to the code.
 * @see https://download.libsodium.org/libsodium/content/helpers/memory_management.html<br>
 */
void sodium_memzero(ubyte[] a) pure nothrow @nogc @trusted
{
//  enforce(a !is null, "a is null"); // not necessary
  sodium_memzero(a.ptr, a.length);
}

version(LittleEndian) {
/** Comparing large numbers.<br>
 * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_<br>
 * The two numbers must have the same length len bytes<br>
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.<br>
 * However, it is slower than sodium_memcmp().
 * The comparison is done in constant time for a given length.
 * Throws an Exception if b1_.length != b2_.length
 */
  int sodium_compare(in ubyte[] b1_, in ubyte[] b2_) pure @trusted
  {
    enforce(b1_.length == b2_.length, "b1_.length != b2_.length"); 
//    enforce(b1_ !is null, "b1_ is null"); // not necessary
//    enforce(b2_ !is null, "b2_ is null"); // not necessary
    return  sodium_compare(b1_.ptr, b2_.ptr, b1_.length);
  }
}

/** Testing for all zeros.<br>
 * This function returns 1 if the array contains only zeros.
 * It returns 0 if non-zero bits are found.<br>
 * Its execution time is constant for a given length.<br>
 * This function was introduced in libsodium 1.0.7.
 */
int sodium_is_zero(in ubyte[] n) pure nothrow @nogc @trusted
{
//  enforce(n !is null, "n is null"); // not necessary
  int rv = -1;
  try
    rv = sodium_is_zero(n.ptr, n.length);
  catch (Exception e) { /* Known not to throw */ }
  return  rv;
}

version(LittleEndian) {
  /** Incrementing large numbers.
   * The sodium_increment() function takes an ubyte array representing an arbitrary-long unsigned number,
   * and increments it.
   * It runs in constant-time for a given length, and considers the number to be encoded in little-
   * endian format.
   * sodium_increment() can be used to increment nonces in constant time.
   * This function was introduced in libsodium 1.0.4.
   * Does nothing if the array is null
   */
  void sodium_increment(ubyte[] n) pure nothrow @nogc @trusted
  {
//  enforce(n !is null, "n is null"); // not necessary
    sodium_increment(n.ptr, n.length);
  }

  /** Adding large numbers
   * The sodium_add() function accepts two arrays of unsigned numbers encoded in little-
   * endian format, a and b, both of size len bytes.
   * It computes (a + b) mod 2^(8*len) in constant time for a given length, and overwrites a 
   * with the result.
   * This function was introduced in libsodium 1.0.7.
   * Throws if a_.length != b.length
   * Does nothing if both arrays are null
   */
  void sodium_add(ubyte[] a, in ubyte[] b) pure @trusted
  {
    enforce(a.length == b.length, "a.length != b.length"); 
//    enforce(a !is null, "a is null"); // not necessary
//    enforce(b !is null, "b is null"); // not necessary
    sodium_add(a.ptr, b.ptr, a.length);
  }
}

/** Hexadecimal encoding.<br>
 * The sodium_bin2hex() function converts the bytes stored at bin into a hexadecimal string.<br>
 * The string is stored into a local variable hex, allocated as required.<br>
 * <br>
 * @see https://download.libsodium.org/libsodium/content/helpers/<br>
 * @returns a copy of hex as D string on success, or null on overflow. It evaluates in constant time for a given size.
 * NOTE: This function uses heap memory for the return value
 */
string sodium_bin2hex(in ubyte[] bin) pure nothrow @trusted
{
//  enforce(bin !is null, "bin is null"); // not necessary
  char[] hex = new char[2*bin.length+1];
  if ( assumeWontThrow(sodium_bin2hex(hex.ptr, hex.length, bin.ptr, bin.length)) )
    return hex[0..$-1]; // strips terminating null character; assumeUnique not strictly required, as compiler can infer uniqueness for a pure function
  else
    return null;
}

/** Hexadecimal decoding.<br>
 * The sodium_hex2bin() function parses a hexadecimal string hex and converts it to a byte sequence bin.<br>
 * ignore is a string of characters to skip. For example, the string ": " allows colons and
 * spaces to be present at any locations in the hexadecimal string. These characters will just
 * be ignored. As a result, "69:FC", "69 FC", "69 : FC" and "69FC" will be valid inputs,
 * and will produce the same output.<br>
 * ignore can be set to null in order to disallow any non-hexadecimal character.<br>
 * bin.length is the maximum number of bytes to put into bin, thus bin has to be sized <br>
 * appropriately in advance, as this function doesn't change bin.length.<br>
 * The parser stops when a non-hexadecimal, non-ignored character is found or when
 * bin.length  bytes have been written.<br>
 * bin_len is the number of bytes that actually got written into bin.<br>
 * @returns -1 if more than bin.length bytes would be required to store the
 * parsed string. It returns 0 on success and sets hex_end to a string containing
 * the characters following the last parsed character.
 * It evaluates in constant time for a given length and format.<br>
 * @see https://download.libsodium.org/libsodium/content/helpers/<br>
 * NOTE: This function uses heap memory for it's string parameters, and for the toStringz and idup calls.
 */
int sodium_hex2bin(ubyte[] bin, in string hex, in string ignore, out size_t bin_len, out string hex_end) pure nothrow @trusted
{
  import std.string : toStringz, fromStringz;
  char*  hex_end_ptr;
  /* in the nex function call:
     prefering  toStringz(ignore) i.e. possibly a copy over ignore.ptr is conservative as AFAIK it's not reliable to have a '\0' in memorey behind a D string  */
  int rv = assumeWontThrow(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, toStringz(ignore), &bin_len, &hex_end_ptr));
  hex_end = fromStringz(hex_end_ptr).idup;
  return rv;
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
  import sodium.core : sodium_init;
  import std.algorithm.searching : any, all;
  import std.range : iota, array;

  int rv = sodium_init(); // not shure about sequence of unittests (if core.d's unittest - calling sodium_init - has already been executed seems to depend on sequence of imports)
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

  union anonym {
    ulong    a = 0x40_00_00_00_00_00_00_00UL;
    ubyte[8] b;
  }
  anonym u, v;
  sodium_increment(u.b.ptr, u.b.length);
  assert(u.a == 0x40_00_00_00_00_00_00_01UL);
  
  sodium_add(u.b.ptr, v.b.ptr, u.b.length);
  assert(u.a == 0x80_00_00_00_00_00_00_01UL);
}
}

pure @safe
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
  import std.exception : enforce, assertThrown;

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
    assert(sodium_is_zero(c) == 0);
    d[0] = 253;
    d[4] = 255;
    assert(sodium_compare(c, d) == -1);
    d[0] = d[4] = 254;
    assert(sodium_compare(c, d) ==  0);
    c[0] = 253;
    c[4] = 255;
    assert(sodium_compare(c, d) ==  1);

    assert(sodium_compare(null, null) ==  0);
    ubyte[] dummy = [1];
    assertThrown(enforce( sodium_compare(null, dummy) == -1, new Exception("this should be thrown")));
    assert(sodium_is_zero(null) == 1);

    sodium_memzero(c);
    assert(sodium_is_zero(c) == 1);
    sodium_memzero(null);
  }

  union anonym {
    ulong    a = 0x40_00_00_00_00_00_00_00UL;
    ubyte[8] b;
  }
  anonym u, v;
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
}
}

pure @system
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 3 from sodium.utils.d");
  }
  import std.string : toStringz, fromStringz;

//sodium_bin2hex
  ubyte[] a = [1,2,3,4,255];
  char[] result_out = new char[](11);
  char* result = sodium_bin2hex(result_out.ptr, result_out.length, a.ptr, a.length);
  assert(result.fromStringz==result_out[0..$-1]); // the "strings" result.fromStringz as well as "01020304ff".dup have no terminating \0 character, but result_out has it!
  assert("01020304ff".dup  ==result_out[0..$-1]);

//sodium_hex2bin
 	auto    vbuf = cast(immutable(ubyte)[]) x"ac 9f ff 4e ba"; // for comparison
  string  hex = "ac:9f:ff:4e:bay";
  string  ignore = ":";
  ubyte[] bin = new ubyte[]((hex.length+1)/3);
  size_t  bin_len;
  char*   hex_end;
  assert(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, toStringz(ignore), &bin_len, &hex_end) == 0);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len  == 5);
  assert(hex.ptr+14 == hex_end); // addresses pointing to character y; i.e. hex_end points into hex
  assert(*hex_end == 'y');
  assert(*++hex_end == '\0'); // i.e. a D string is guaranteed to be followed by a '\0' in memory ! Is this always true ???

  --hex.length;
  hex ~= ":fa";
  bin[]   = ubyte.init; // bin.length unchanged; to small now to incorporate all input
  assert(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, toStringz(ignore), &bin_len, &hex_end) == -1);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len == 5);
  assert(*hex_end == 'f');
  assert(*++hex_end == 'a');
  assert(*++hex_end == '\0');
}

pure @safe
unittest // same as before except @safe and wrapping delegates + overloads
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 4 from sodium.utils.d");
  }

//sodium_bin2hex
  ubyte[] a = [1,2,3,4,255];
  char[] result_out = new char[](a.length*2+1);
  char* result = (() @trusted => sodium_bin2hex(result_out.ptr, result_out.length, a.ptr, a.length))();
//  assert(result.fromStringz==result_out[0..$-1]); // the "strings" result.fromStringz as well as "01020304ff".dup have no terminating \0 character, but result_out has it!
  assert("01020304ff" == result_out[0..$-1].idup);
  assert("01020304ff" == sodium_bin2hex(a));
  assert(sodium_bin2hex(null).length == 0);

//sodium_hex2bin overload only
 	auto    vbuf = cast(immutable(ubyte)[]) x"ac 9f ff 4e ba"; // for comparison
  string  hex = "ac:9f:ff:4e:bay";
  string  ignore = ":";
  ubyte[] bin = new ubyte[]((hex.length+1)/3);
  size_t  bin_len;
  string  hex_end;
//  assert(sodium_hex2bin(bin.ptr, bin.length, hex.ptr, hex.length, toStringz(ignore), &bin_len, &hex_end_ptr) == 0);
  
  assert(sodium_hex2bin(bin, hex, ignore, bin_len, hex_end) == 0);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len == 5);
  assert(hex_end == "y");

  --hex.length;
  hex ~= ":fa";
  bin[]   = ubyte.init; // bin.length unchanged
  assert(sodium_hex2bin(bin, hex, ignore, bin_len, hex_end) == -1);
  assert(bin == vbuf); // [172, 159, 255, 78, 186]);
  assert(bin_len == 5);
  assert(hex_end == "fa");

}

pure @system
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

pure @safe
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
  assert( all!"a == 0xD0"(arr_ubyte));
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
