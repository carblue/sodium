/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_core_H
*/

/**
 * Initialization and 'abort process' related functions.
 */

module deimos.sodium.core;

//version(DigitalMars) { pragma(lib, "sodium"); } // In order to come into effect, DUB has to be invoked with option dub build --build-mode=allAtOnce  or e.g. DMD invoked omitting the -c switch

extern (C) @nogc nothrow @trusted:

/** Library initialization.
 * Deviating from C, D can't express "warn about an unused return value" here, because the function is impure.
 *
 * sodium_init() initializes the library and should be called before any other function provided
 * by Sodium.
 * The function can be called more than once, and can be called simultaneously from multiple
 * threads since version 1.0.11.
 * After this function returns, all of the other functions provided by Sodium will be thread-safe.
 * sodium_init() doesn't perform any memory allocations. However, on Unix systems, it may
 * open  /dev/urandom  and keep the descriptor open, so that the device remains accessible
 * after a  chroot()  call.
 * Multiple calls to  sodium_init()  do not cause additional descriptors to be opened.
 * Before returning, the function ensures that the system's random number generator has been
 * properly seeded.
 * On some Linux systems, this may take some time, especially when called right after a reboot
 * of the system.
 * Returns: 0  on success,  -1  on failure, and  1  if the library had already been initialized.
 * See_Also: https://download.libsodium.org/doc/quickstart#boilerplate
*/
int sodium_init(); // __attribute__ ((warn_unused_result))

/* ---- */

/// Set a misuse_handler
/// Returns: 0  on success,  -1  otherwise
int sodium_set_misuse_handler(void function() nothrow @safe handler);

/// Aborts the process. but possibly first calls a misuse_handler (if one is set).
void sodium_misuse(); // __attribute__ ((noreturn));
