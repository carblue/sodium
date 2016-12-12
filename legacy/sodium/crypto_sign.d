/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_sign_H
*/

module sodium.crypto_sign;

/*
 * THREAD SAFETY: crypto_sign_keypair() is thread-safe,
 * provided that you called sodium_init() once before using any
 * other libsodium function.
 * Other functions, including crypto_sign_seed_keypair() are always thread-safe.
 */

import sodium.crypto_sign_ed25519 : crypto_sign_ed25519_BYTES,
                                    crypto_sign_ed25519_SEEDBYTES.
                                    crypto_sign_ed25519_PUBLICKEYBYTES,
                                    crypto_sign_ed25519_SECRETKEYBYTES;


extern(C) pure @nogc :


alias crypto_sign_BYTES = crypto_sign_ed25519_BYTES;

size_t  crypto_sign_bytes() @trusted;

alias crypto_sign_SEEDBYTES = crypto_sign_ed25519_SEEDBYTES;

size_t  crypto_sign_seedbytes() @trusted;

alias crypto_sign_PUBLICKEYBYTES = crypto_sign_ed25519_PUBLICKEYBYTES;

size_t  crypto_sign_publickeybytes() @trusted;

alias crypto_sign_SECRETKEYBYTES = crypto_sign_ed25519_SECRETKEYBYTES;

size_t  crypto_sign_secretkeybytes() @trusted;

enum crypto_sign_PRIMITIVE = "ed25519";

const(char)* crypto_sign_primitive() @system;

int crypto_sign_seed_keypair(ubyte* pk, ubyte* sk,
                             const(ubyte)* seed) @system;

int crypto_sign_keypair(ubyte* pk, ubyte* sk) @system;

int crypto_sign(ubyte* sm, ulong* smlen_p,
                const(ubyte)* m, ulong mlen,
                const(ubyte)* sk) @system;

int crypto_sign_open(ubyte* m, ulong* mlen_p,
                     const(ubyte)* sm, ulong smlen,
                     const(ubyte)* pk) nothrow @system; // __attribute__ ((warn_unused_result))

int crypto_sign_detached(ubyte* sig, ulong* siglen_p,
                         const(ubyte)* m, ulong mlen,
                         const(ubyte)* sk) @system;

int crypto_sign_verify_detached(const(ubyte)* sig,
                                const(ubyte)* m,
                                ulong mlen,
                                const(ubyte)* pk) nothrow @system; // __attribute__ ((warn_unused_result))
