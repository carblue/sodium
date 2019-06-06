/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_utils_H
*/

/**
 * Utility functions.
 */

module deimos.sodium.utils;

extern (C) @nogc nothrow:

/** Zeroing memory.
 *
 * After use, sensitive data should be overwritten, but memset() and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The sodium_memzero() function tries to effectively zero `len` bytes starting at `pnt`, even if
 * optimizations are being applied to the code.
 * See_Also: https://download.libsodium.org/doc/memory_management#zeroing-memory
 */
void sodium_memzero(void* pnt, const size_t len) pure;

/** Clearing the stack.
 *
 * The sodium_stackzero() function clears  len bytes above the current stack pointer, to
 * overwrite sensitive values that may have been temporarily stored on the stack.
 * Note that these values can still be present in registers.
 * History: This function was introduced in libsodium 1.0.16.
 * See_Also: https://download.libsodium.org/doc/helpers#clearing-the-stack
*/
void sodium_stackzero(const size_t len) pure;

/** Constant-time test for equality.
 *
 * WARNING: sodium_memcmp() must be used to verify if two secret keys
 * are equal, in constant time.
 * This function is not designed for lexicographical comparisons.
 * Returns: 0 if the keys are equal, and -1 if they differ.
 * See_Also: https://download.libsodium.org/doc/helpers#constant-time-test-for-equality
 */
int sodium_memcmp(const(void*) b1_, const(void*) b2_, size_t len) pure; // __attribute__ ((warn_unused_result))

/** Comparing large numbers.
 *
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.
 * However, it is slower than sodium_memcmp().
 * The comparison is done in constant time for a given length.
 * Returns: -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
 * See_Also: https://download.libsodium.org/doc/helpers#comparing-large-numbers
 */
int sodium_compare(const(ubyte)* b1_, const(ubyte)* b2_, size_t len) pure; // __attribute__ ((warn_unused_result));

/** Testing for all zeros.
 *
 * It's execution time is constant for a given length.
 * Returns:  1  if the `nlen` bytes vector pointed by `n` contains only zeros.
 *           0  if non-zero bits are found.
 * See_Also: https://download.libsodium.org/doc/helpers#testing-for-all-zeros
 */
int sodium_is_zero(const(ubyte)* n, const size_t nlen) pure;

/// See_Also: https://download.libsodium.org/doc/helpers#incrementing-large-numbers
void sodium_increment(ubyte* n, const size_t nlen) pure;

/// See_Also: https://download.libsodium.org/doc/helpers#adding-large-numbers
void sodium_add(ubyte* a, const(ubyte)* b, const size_t len) pure;

version(bin_v1_0_16) {}
else {
    /// See_Also: https://download.libsodium.org/doc/helpers#substracting-large-numbers
    void sodium_sub(ubyte* a, const(ubyte)* b, const size_t len) pure;
}

/// Returns: hex
/// See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
char* sodium_bin2hex(char* hex, const size_t hex_maxlen, const(ubyte*) bin, const size_t bin_len) pure; // __attribute__ ((nonnull(1)));

/// Returns:  0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/helpers#hexadecimal-encoding-decoding
int sodium_hex2bin(ubyte* bin, const size_t bin_maxlen, const(char*) hex, const size_t hex_len,
        const(char*) ignore, size_t* bin_len, const(char)** hex_end) pure; // __attribute__ ((nonnull(1)));

/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
enum int sodium_base64_VARIANT_ORIGINAL            = 1;
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
enum int sodium_base64_VARIANT_ORIGINAL_NO_PADDING = 3;
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
enum int sodium_base64_VARIANT_URLSAFE             = 5;
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
enum int sodium_base64_VARIANT_URLSAFE_NO_PADDING  = 7;

/** #define sodium_base64_ENCODED_LEN(BIN_LEN, VARIANT)
 * Computes the required length to encode BIN_LEN bytes as a base64 string
 * using the given variant. The computed length includes a trailing \0.
 */
size_t sodium_base64_ENCODED_LEN()(const size_t BIN_LEN, const int VARIANT) {
    return  (BIN_LEN / 3) * 4 +
    (((BIN_LEN - (BIN_LEN / 3) * 3) | (((BIN_LEN) - (BIN_LEN / 3U) * 3U) >> 1)) & 1U) *
     (4 - (~(((VARIANT & 2U) >> 1) - 1) & (3 - (BIN_LEN - (BIN_LEN / 3) * 3)))) + 1;
}

/// Returns: sodium_base64_encoded length required, e.g. for b64 in sodium_bin2base64.
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
size_t sodium_base64_encoded_len(const size_t bin_len, const int variant) pure @trusted;

/// Returns: b64
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
char* sodium_bin2base64(char* b64, const size_t b64_maxlen, const(ubyte*) bin, const size_t bin_len, const int variant) pure; // __attribute__ ((nonnull(1)));

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/helpers#base64-encoding-decoding
int sodium_base642bin(ubyte* bin, const size_t bin_maxlen, const(char*) b64, const size_t b64_len,
        const(char*) ignore, size_t* bin_len, const(char)** b64_end, const int variant) pure; // __attribute__ ((nonnull(1)));

/**
 * The  sodium_mlock()  function locks at least `len` bytes of memory starting at `addr`.
 * This can help avoid swapping sensitive data to disk.
 * Returns: 0  on success,  -1  otherwise
 * See_Also: https://download.libsodium.org/doc/memory_management#locking-memory
 */
int sodium_mlock(void* addr, const size_t len); // __attribute__ ((nonnull));

/**
 * The  sodium_munlock()  function should be called after locked memory is not being used any more.
 * It will zero `len` bytes starting at `addr` before actually flagging the pages as
 * swappable again. Calling  sodium_memzero()  prior to  sodium_munlock()  is thus not required.
 * Returns: 0  on success,  -1  otherwise
 * See_Also: https://download.libsodium.org/doc/memory_management#locking-memory
 */
int sodium_munlock(void* addr, const size_t len); // __attribute__ ((nonnull));

/* WARNING: sodium_malloc() and sodium_allocarray() are not general-purpose
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
 * sodium_malloc() can be used to allocate any libsodium data structure.
 *
 * The crypto_generichash_state structure is packed and its length is
 * either 357 or 361 bytes. For this reason, when using sodium_malloc() to
 * allocate a crypto_generichash_state structure, padding must be added in
 * order to ensure proper alignment. crypto_generichash_statebytes()
 * returns the rounded up structure size, and should be prefered to sizeof():
 * state = sodium_malloc(crypto_generichash_statebytes());
 */

/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
void* sodium_malloc(const size_t size); // __attribute__ ((malloc));

/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
void* sodium_allocarray(size_t count, size_t size); // __attribute__ ((malloc));

/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
void sodium_free(void* ptr);

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
int sodium_mprotect_noaccess(void* ptr); // __attribute__ ((nonnull));

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
int sodium_mprotect_readonly(void* ptr); // __attribute__ ((nonnull));

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/memory_management#guarded-heap-allocations
int sodium_mprotect_readwrite(void* ptr); // __attribute__ ((nonnull));

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
int sodium_pad(size_t* padded_buflen_p, ubyte* buf, size_t unpadded_buflen, size_t blocksize, size_t max_buflen) pure; // __attribute__ ((nonnull(2)));

/// Returns: 0  on success,  -1  otherwise
/// See_Also: https://download.libsodium.org/doc/padding#usage
int sodium_unpad(size_t* unpadded_buflen_p, const(ubyte)* buf, size_t padded_buflen, size_t blocksize) pure; // __attribute__ ((nonnull(2)));
