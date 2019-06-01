/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_core_ed25519_H
*/

module deimos.sodium.crypto_core_ed25519;

version(SODIUM_LIBRARY_MINIMAL) {}
else {


extern(C) @nogc :


enum crypto_core_ed25519_BYTES = 32U;

size_t crypto_core_ed25519_bytes() pure @trusted;

enum crypto_core_ed25519_UNIFORMBYTES = 32U;

size_t crypto_core_ed25519_uniformbytes() pure @trusted;

enum crypto_core_ed25519_HASHBYTES = 64U;

size_t crypto_core_ed25519_hashbytes() pure @trusted;

enum crypto_core_ed25519_SCALARBYTES = 32U;

size_t crypto_core_ed25519_scalarbytes() pure @trusted;

enum crypto_core_ed25519_NONREDUCEDSCALARBYTES = 64;

size_t crypto_core_ed25519_nonreducedscalarbytes() pure @trusted;

int crypto_core_ed25519_is_valid_point(const(ubyte)* p) nothrow; // __attribute__ ((nonnull));

int crypto_core_ed25519_add(ubyte* r,
                            const(ubyte)* p, const(ubyte)* q) nothrow; // __attribute__ ((nonnull));

int crypto_core_ed25519_sub(ubyte* r,
                            const(ubyte)* p, const(ubyte)* q) nothrow; // __attribute__ ((nonnull));

int crypto_core_ed25519_from_uniform(ubyte* p, const(ubyte)* r) nothrow; // __attribute__ ((nonnull));

int crypto_core_ed25519_from_hash(ubyte* p, const(ubyte)* h) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_random(ubyte* p) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_random(ubyte* r) nothrow; // __attribute__ ((nonnull));

int crypto_core_ed25519_scalar_invert(ubyte* recip, const(ubyte)* s) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_negate(ubyte* neg, const(ubyte)* s) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_complement(ubyte* comp, const(ubyte)* s) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_add(ubyte* z, const(ubyte)* x,
                                    const(ubyte)* y) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_sub(ubyte* z, const(ubyte)* x,
                                    const(ubyte)* y) nothrow; // __attribute__ ((nonnull));

void crypto_core_ed25519_scalar_mul(ubyte* z, const(ubyte)* x,
                                    const(ubyte)* y) nothrow; // __attribute__ ((nonnull));

/*
 * The interval `s` is sampled from should be at least 317 bits to ensure almost
 * uniformity of `r` over `L`.
 */
void crypto_core_ed25519_scalar_reduce(ubyte* r, const(ubyte)* s) nothrow; // __attribute__ ((nonnull));

}
