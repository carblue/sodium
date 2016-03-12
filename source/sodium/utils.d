module sodium.utils;

extern (C) :

/**
 * Zeroing memory.
 * After use, sensitive data should be overwritten, but   memset()  and hand-written code can be
 * silently stripped out by an optimizing compiler or by the linker.
 * The   sodium_memzero()  function tries to effectively zero   len  bytes starting at   pnt  , even if
 * optimizations are being applied to the code. */
void sodium_memzero(const(void*) pnt, const size_t len);

/**
 * Constant-time test for equality.
 * When a comparison involves secret data (e.g. key, authentication tag), is it critical to use a
 * constant-time comparison function in order to mitigate side-channel attacks.
 * The   sodium_memcmp()   function can be used for this purpose.<br>
 * The function returns   0   if the   len  bytes pointed to by   b1_   match the   len   bytes pointed
 * to by   b2_  . Otherwise, it returns   -1 .<br>
 * WARNING: sodium_memcmp() must be used to verify if two secret keys are equal, in constant time.<br>
 * This function is not designed for lexicographical comparisons and is not a generic replacement
 * for   memcmp().
 */
int sodium_memcmp(const(void*) b1_, const(void*) b2_, size_t len);

/**
 * Comparing large numbers.
 * sodium_compare() returns -1 if b1_ < b2_, 1 if b1_ > b2_ and 0 if b1_ == b2_
 * It is suitable for lexicographical comparisons, or to compare nonces
 * and counters stored in little-endian format.
 * However, it is slower than sodium_memcmp().
 */
int sodium_compare(const(ubyte)* b1_, const(ubyte)* b2_, size_t len);
	
/**
 * Testing for all zeros.
 * This function returns   1  if the   nlen   bytes vector pointed by   n   contains only zeros.
 * It returns   0  if non-zero bits are found.<br>
 * Its execution time is constant for a given length.<br>
 * This function was introduced in libsodium 1.0.7. */
int sodium_is_zero(const(ubyte)* n, const size_t nlen);
	
/**
 * Incrementing large numbers.
 * The   sodium_increment()  function takes a pointer to an arbitrary-long unsigned number, and
 * increments it.
 * It runs in constant-time for a given length, and considers the number to be encoded in little-
 * endian format.
 * sodium_increment()  can be used to increment nonces in constant time.
 * This function was introduced in libsodium 1.0.4. */
void sodium_increment(ubyte* n, const size_t nlen);

/**
 * Adding large numbers
 * The   sodium_add()  function accepts two pointers to unsigned numbers encoded in little-
 * endian format,   a   and   b , both of size   len  bytes.
 * It computes   (a + b) mod 2^(8*len)  in constant time for a given length, and overwrites   a 
 * with the result.
 * This function was introduced in libsodium 1.0.7. */
void sodium_add(ubyte* a, const(ubyte)* b, const size_t len);

/**
 * Hexadecimal encoding.
 * The   sodium_bin2hex()  function converts   bin_len   bytes stored at   bin  into a hexadecimal
 * string.
 * The string is stored into   hex  and includes a nul byte (  \0  ) terminator.
 * hex_maxlen  is the maximum number of bytes that the function is allowed to write starting at
 * hex  . It should be at least   bin_len * 2 + 1  .
 * The function returns   hex  on success, or   null  on overflow. It evaluates in constant time for
 * a given size. */
char* sodium_bin2hex(const(char*) hex, const size_t hex_maxlen, const(ubyte*) bin, const size_t bin_len);


/**
 * Hexadecimal decoding.
 * The   sodium_hex2bin()  function parses a hexadecimal string   hex  and converts it to a byte
 * sequence.
 * hex   does not have to be nul terminated, as the number of characters to parse is supplied
 * via the   hex_len   parameter.
 * ignore  is a string of characters to skip. For example, the string   ": "   allows columns and
 * spaces to be present at any locations in the hexadecimal string. These characters will just
 * be ignored. As a result,   "69:FC" ,   "69 FC"  ,   "69 : FC"  and   "69FC"  will be valid inputs,
 * and will produce the same output.
 * ignore  can be set to   null   in order to disallow any non-hexadecimal character.
 * bin_maxlen  is the maximum number of bytes to put into   bin .
 * The parser stops when a non-hexadecimal, non-ignored character is found or when
 * bin_maxlen  bytes have been written.
 * The function returns   -1  if more than   bin_maxlen   bytes would be required to store the
 * parsed string. It returns   0  on success and sets   hex_end  , if it is not   null , to a pointer to
 * the character following the last parsed character.
 * It evaluates in constant time for a given length and format. */
int sodium_hex2bin(const(ubyte)* bin, const size_t bin_maxlen, const(char*) hex, const size_t hex_len, const(char*) ignore, const(size_t*) bin_len, const(char**) hex_end);

/**
 * Locking memory
 * The   sodium_mlock()   function locks at least   len  bytes of memory starting at   addr.
 * This can help avoid swapping sensitive data to disk.
 * In addition, it is recommended to totally disable swap partitions on machines processing
 * sensitive data, or, as a second choice, use encrypted swap partitions.
 * For similar reasons, on Unix systems, one should also disable core dumps when running
 * crypto code outside a development environment. This can be achieved using a shell built-in
 * such as   ulimit   or programatically using   setrlimit(RLIMIT_CORE, &(struct rlimit) {0, 0})  .
 * On operating systems where this feature is implemented, kernel crash dumps should also be
 * disabled (e.g. https://help.ubuntu.com/lts/serverguide/kernel-crash-dump.html).
 * sodium_mlock()   wraps   mlock()  and   VirtualLock()  . Note: Many systems place limits on
 * the amount of memory that may be locked by a process. Care should be taken to raise those
 * limits (e.g. Unix ulimits) where neccessary.   sodium_lock()   will return   -1   when any limit is
 * reached.
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
	void* sodium_malloc(const size_t size);
	
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

