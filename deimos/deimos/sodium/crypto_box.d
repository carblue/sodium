/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_box_H
*/

module deimos.sodium.crypto_box;

/*
 * THREAD SAFETY: crypto_box_keypair() is thread-safe,
 * provided that sodium_init() was called before.
 *
 * Other functions are always thread-safe.
 */

import deimos.sodium.crypto_box_curve25519xsalsa20poly1305 : crypto_box_curve25519xsalsa20poly1305_SEEDBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_NONCEBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_MACBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_MESSAGEBYTES_MAX,
                                                             crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_ZEROBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES;


extern(C) @nogc :


alias crypto_box_SEEDBYTES = crypto_box_curve25519xsalsa20poly1305_SEEDBYTES;

size_t  crypto_box_seedbytes() pure @trusted;

alias crypto_box_PUBLICKEYBYTES = crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES;

size_t  crypto_box_publickeybytes() pure @trusted;

alias crypto_box_SECRETKEYBYTES = crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES;

size_t  crypto_box_secretkeybytes() pure @trusted;

alias crypto_box_NONCEBYTES = crypto_box_curve25519xsalsa20poly1305_NONCEBYTES;

size_t  crypto_box_noncebytes() pure @trusted;

alias crypto_box_MACBYTES = crypto_box_curve25519xsalsa20poly1305_MACBYTES;

size_t  crypto_box_macbytes() pure @trusted;

alias crypto_box_MESSAGEBYTES_MAX = crypto_box_curve25519xsalsa20poly1305_MESSAGEBYTES_MAX;

size_t  crypto_box_messagebytes_max() pure @trusted;

enum crypto_box_PRIMITIVE = "curve25519xsalsa20poly1305";

const(char)* crypto_box_primitive() pure @trusted;

int crypto_box_seed_keypair(ubyte* pk, ubyte* sk,
                            const(ubyte)* seed) pure; // __attribute__ ((nonnull));

int crypto_box_keypair(ubyte* pk, ubyte* sk) nothrow; // __attribute__ ((nonnull));

int crypto_box_easy(ubyte* c, const(ubyte)* m,
                    ulong mlen, const(ubyte)* n,
                    const(ubyte)* pk, const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 4, 5, 6)));

int crypto_box_open_easy(ubyte* m, const(ubyte)* c,
                         ulong clen, const(ubyte)* n,
                         const(ubyte)* pk, const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5, 6)));

int crypto_box_detached(ubyte* c, ubyte* mac,
                        const(ubyte)* m, ulong mlen,
                        const(ubyte)* n, const(ubyte)* pk,
                        const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 2, 5, 6, 7)));

int crypto_box_open_detached(ubyte* m, const(ubyte)* c,
                             const(ubyte)* mac,
                             ulong clen,
                             const(ubyte)* n,
                             const(ubyte)* pk,
                             const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 3, 5, 6, 7)));

/* -- Precomputation interface -- */

alias crypto_box_BEFORENMBYTES = crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES;

size_t  crypto_box_beforenmbytes() pure @trusted;

int crypto_box_beforenm(ubyte* k, const(ubyte)* pk,
                        const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_box_easy_afternm(ubyte* c, const(ubyte)* m,
                            ulong mlen, const(ubyte)* n,
                            const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4, 5)));

int crypto_box_open_easy_afternm(ubyte* m, const(ubyte)* c,
                                 ulong clen, const(ubyte)* n,
                                 const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));

int crypto_box_detached_afternm(ubyte* c, ubyte* mac,
                                const(ubyte)* m, ulong mlen,
                                const(ubyte)* n, const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 2, 5, 6)));

int crypto_box_open_detached_afternm(ubyte* m, const(ubyte)* c,
                                     const(ubyte)* mac,
                                     ulong clen, const(ubyte)* n,
                                     const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 3, 5, 6)));

/* -- Ephemeral SK interface -- */

enum crypto_box_SEALBYTES = (crypto_box_PUBLICKEYBYTES + crypto_box_MACBYTES);

size_t crypto_box_sealbytes() pure @trusted;

int crypto_box_seal(ubyte* c, const(ubyte)* m,
                    ulong mlen, const(ubyte)* pk) pure; // __attribute__ ((nonnull(1, 4)));

int crypto_box_seal_open(ubyte* m, const(ubyte)* c,
                         ulong clen,
                         const(ubyte)* pk, const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));

/* -- NaCl compatibility interface ; Requires padding -- */

alias crypto_box_ZEROBYTES = crypto_box_curve25519xsalsa20poly1305_ZEROBYTES;

size_t  crypto_box_zerobytes() pure @trusted;

alias crypto_box_BOXZEROBYTES = crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES;

size_t  crypto_box_boxzerobytes() pure @trusted;

int crypto_box(ubyte* c, const(ubyte)* m,
               ulong mlen, const(ubyte)* n,
               const(ubyte)* pk, const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 4, 5, 6)));

int crypto_box_open(ubyte* m, const(ubyte)* c,
                    ulong clen, const(ubyte)* n,
                    const(ubyte)* pk, const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5, 6)));

int crypto_box_afternm(ubyte* c, const(ubyte)* m,
                       ulong mlen, const(ubyte)* n,
                       const(ubyte)* k); // __attribute__ ((nonnull(1, 4, 5)));

int crypto_box_open_afternm(ubyte* m, const(ubyte)* c,
                            ulong clen, const(ubyte)* n,
                            const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));
