module sodium.core;

version(DigitalMars) { pragma(lib, "sodium"); } // no effect when using DUB; only when invoking DMD directly with all source files for compiling+linking in one go (not separated steps)

/**  sodium_init()  initializes the library and should be called before any other function provided by Sodium.<br>
 * The function can be called more than once, and can be called simultaneously from multiple threads
 * since version 1.0.11. For older versions, add appropriate locks around the function call if this
 * scenario can happen in your application.<br>
 * After this function returns, all of the other functions provided by Sodium will be thread-safe.<br>
 * sodium_init() doesn't perform any memory allocations. However, on Unix systems, it may open
 * /dev/urandom and keep the descriptor open, so that the device remains accessible after a chroot() call.
 * Multiple calls to sodium_init() do not cause additional descriptors to be opened.<br>
 * @see https://download.libsodium.org/libsodium/content/usage/<br>
 * @returns 0 on success, -1 on failure, and 1 if the library had already been initialized. */
extern(C) int sodium_init() pure nothrow @nogc @trusted;


pure /* nothrow @nogc*/ @safe
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 1 from sodium.core.d");
  }
  int rv = sodium_init(); // maybe, it's not the first call to sodium_init, because unittest of app.d and any (implementation defined order!) of app.d's sodium imports may have precedence
  assert(rv == 0 || rv == 1);
}
