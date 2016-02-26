// D import file generated from 'core.d' renamed to 'core.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.core;

/** sodium_init() initializes the library and should be called before any other function provided by Sodium.
 * Warning: Call this function within "synchronized { ... }" only !
 * After this function returns, all of the other functions provided by Sodium will be thread-safe.
 * @returns returns 0 on success, -1 on failure, and 1 if the library had already been initialized. */
extern (C) int sodium_init();
