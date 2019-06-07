/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define randombytes_H
*/

/**
 * Functions related to randomness.
 * See_Also: https://download.libsodium.org/doc/generating_random_data#usage
 */

module deimos.sodium.randombytes;

import deimos.sodium.export_;


extern(C) nothrow :

/// See_Also:
struct randombytes_implementation {
    const(char)* function()                             implementation_name; /* required */
    uint         function()                             random;              /* required */
    void         function()                             stir;                /* optional */
    uint         function(const uint upper_bound)       uniform;             /* optional, a default implementation will be used if null */
    void         function(void* buf, const size_t size) buf;                 /* required */
    int          function()                             close;               /* optional */
}

@nogc :

///
enum randombytes_BYTES_MAX = SODIUM_MIN(SODIUM_SIZE_MAX, uint.max); // 0xffff_ffffU

/* my understanding of the pure attribute in D is, that the following functions (except randombytes_seedbytes and randombytes_buf_deterministic)
   are impure: they depend on hidden global mutable state */


///
enum ubyte randombytes_SEEDBYTES = 32U;

/// Returns: 32
size_t randombytes_seedbytes() pure @trusted;

/// fills `buf` with `size` unpredictable bytes.
void randombytes_buf(scope void* buf, const size_t size); // __attribute__ ((nonnull));

/// same as randombytes_buf, but based on seed delivers reproducible 'unpredictable' bytes
void randombytes_buf_deterministic(void* buf, const size_t size,
                                   ref const(ubyte)[randombytes_SEEDBYTES] seed) pure; // __attribute__ ((nonnull));

/// Returns: an unpredictable value between 0 and uint.max (included)
uint randombytes_random() @trusted;

/// Returns: an unpredictable value between 0 and upper_bound (excluded)
uint randombytes_uniform(const uint upper_bound) @trusted;

/// reseeds the pseudo-random number generator
void randombytes_stir() @trusted;

/// closes the pseudo-random number generator
/// Returns:
int randombytes_close() @trusted;

///
int randombytes_set_implementation(scope randombytes_implementation* impl); // __attribute__ ((nonnull));

/// Returns: name of current active randombytes_implementation
const(char)* randombytes_implementation_name();

/* -- NaCl compatibility interface -- */

/// same as randombytes_buf, fills `buf` with `buf_len` unpredictable bytes.
void randombytes(scope ubyte* buf, const ulong buf_len); // __attribute__ ((nonnull));
