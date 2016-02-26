// D import file generated from 'utils.d' renamed to 'utils.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.utils;

extern (C) 
{
	/** The sodium_memzero() function tries to effectively zero len bytes starting at pnt, even if optimizations are being applied to the code. */
	void sodium_memzero(const(void*) pnt, const size_t len);
	
	/**
	 * When a comparison involves secret data (e.g. key, authentication tag), is it critical to use a
	 * constant-time comparison function in order to mitigate side-channel attacks.
	 * The sodium_memcmp() function can be used for this purpose.
	 *
	 * WARNING: sodium_memcmp() must be used to verify if two secret keys are equal, in constant time.
	 * This function is not designed for lexicographical comparisons.
	 *
	 * @returns 0 if the keys are equal, and -1 if they differ.
	 */
	int sodium_memcmp(const(void*) b1_, const(void*) b2_, size_t len);
	
	/**
	 * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
	 * It is suitable for lexicographical comparisons, or to compare nonces
	 * and counters stored in little-endian format.
	 * However, it is slower than sodium_memcmp().
	 */
	int sodium_compare(const(ubyte)* b1_, const(ubyte)* b2_, size_t len);
	
	/**
	 * This function returns 1 if the nlen bytes vector pointed by n contains only zeros.
	 * It returns 0 if non-zero bits are found.
	 * Its execution time is constant for a given length.
	 */
	int sodium_is_zero(const(ubyte)* n, const size_t nlen);
	
	/**
	 * The sodium_increment() function takes a pointer to an arbitrary-long unsigned number, and increments it.
	 * It runs in constant-time for a given length, and considers the number to be encoded in little-endian format.
	 * sodium_increment()  can be used to increment nonces in constant time.
	 */
	void sodium_increment(ubyte* n, const size_t nlen);

	void sodium_add(ubyte* a, const(ubyte)* b, const size_t len);
	char* sodium_bin2hex(const(char*) hex, const size_t hex_maxlen, const(ubyte*) bin, const size_t bin_len);
	int sodium_hex2bin(const(ubyte)* bin, const size_t bin_maxlen, const(char*) hex, const size_t hex_len, const(char*) ignore, const(size_t*) bin_len, const(char**) hex_end);
	
	/**
	 * The sodium_mlock() function locks at least len bytes of memory starting at addr.
	 * This can help avoid swapping sensitive data to disk.
	 * On systems where it is supported, sodium_mlock() also wraps madvise() and advises the
	 * kernel not to include the locked memory in core dumps.
	 */
	int sodium_mlock(const(void*) addr, const size_t len);
	
	/**
	 * The sodium_munlock() function should be called after locked memory is not being used any
	 * more. It will zero len bytes starting at addr before actually flagging the pages as
	 * swappable again. Calling sodium_memzero() prior to sodium_munlock() is thus not required.
	 */
	int sodium_munlock(const(void*) addr, const size_t len);
	
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

	void* sodium_malloc(const size_t size);
	void* sodium_allocarray(size_t count, size_t size);
	void sodium_free(void* ptr);
	
	/**
	 * The sodium_mprotect_noaccess() function makes a region allocated using sodium_malloc() 
	 * or sodium_allocarray() inaccessible. It cannot be read or written, but the data are
	 * preserved.
	 * This function can be used to make confidential data inaccessible except when actually
	 * needed for a specific operation.
	 */
	int sodium_mprotect_noaccess(void* ptr);
	
	/**
	 * The sodium_mprotect_readonly() function marks a region allocated using sodium_malloc() 
	 * or sodium_allocarray() as read-only.
	 * Attempting to modify the data will cause the process to terminate.
	 */
	int sodium_mprotect_readonly(void* ptr);
	
	/**
	 * The sodium_mprotect_readwrite() function marks a region allocated using sodium_malloc() 
	 * or sodium_allocarray() as readable and writable, after having been protected using
	 * sodium_mprotect_readonly() or sodium_mprotect_noaccess().
	 */
	int sodium_mprotect_readwrite(void* ptr);
}
