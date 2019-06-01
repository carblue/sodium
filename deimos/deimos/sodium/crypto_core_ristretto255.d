/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_core_ristretto255_H
*/

module deimos.sodium.crypto_core_ristretto255;


extern(C) @nogc nothrow /*pure*/ :


enum crypto_core_ristretto255_BYTES = 32U;

size_t crypto_core_ristretto255_bytes() @trusted;

enum crypto_core_ristretto255_HASHBYTES = 64U;

size_t crypto_core_ristretto255_hashbytes() @trusted;

enum crypto_core_ristretto255_SCALARBYTES = 32U;

size_t crypto_core_ristretto255_scalarbytes() @trusted;

enum crypto_core_ristretto255_NONREDUCEDSCALARBYTES = 64U;

size_t crypto_core_ristretto255_nonreducedscalarbytes() @trusted;

int crypto_core_ristretto255_is_valid_point(const(ubyte)* p); // __attribute__ ((nonnull));

int crypto_core_ristretto255_add(ubyte* r,
                                 const(ubyte)* p, const(ubyte)* q); // __attribute__ ((nonnull));

int crypto_core_ristretto255_sub(ubyte* r,
                                 const(ubyte)* p, const(ubyte)* q); // __attribute__ ((nonnull));

int crypto_core_ristretto255_from_hash(ubyte* p,
                                       const(ubyte)* r); // __attribute__ ((nonnull));

void crypto_core_ristretto255_random(ubyte* p); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_random(ubyte* r); // __attribute__ ((nonnull));

int crypto_core_ristretto255_scalar_invert(ubyte* recip,
                                           const(ubyte)* s); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_negate(ubyte* neg,
                                            const(ubyte)* s); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_complement(ubyte* comp,
                                                const(ubyte)* s); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_add(ubyte* z,
                                         const(ubyte)* x,
                                         const(ubyte)* y); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_sub(ubyte* z,
                                         const(ubyte)* x,
                                         const(ubyte)* y); // __attribute__ ((nonnull));

void crypto_core_ristretto255_scalar_mul(ubyte* z,
                                         const(ubyte)* x,
                                         const(ubyte)* y); // __attribute__ ((nonnull));

/*
 * The interval `s` is sampled from should be at least 317 bits to ensure almost
 * uniformity of `r` over `L`.
 */
void crypto_core_ristretto255_scalar_reduce(ubyte* r,
                                            const(ubyte)* s); // __attribute__ ((nonnull));
