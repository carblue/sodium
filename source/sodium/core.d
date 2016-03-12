module sodium.core;

/** sodium_init()  initializes the library and should be called before any other function provided by Sodium.
 * The function can be called more than once, but it should not be executed by
 * multiple threads simultaneously. Add appropriate locks around the function call if this
 * scenario can happen in your application.<br>
 * After this function returns, all of the other functions provided by Sodium will be thread-safe.<br>
 * sodium_init() doesn't perform any memory allocations. However, on Unix systems, it
 * opens /dev/urandom and keeps the descriptor open, so that the device remains accessible
 * after a   chroot()  call. Multiple calls to   sodium_init()  do not cause additional descriptors to
 * be opened.<br>
 * @see https://download.libsodium.org/doc/usage/index.html<br>
 * @returns   0   on success,   -1  on failure, and   1  if the library had already been initialized. */
extern (C) int sodium_init() pure nothrow @nogc @safe;
