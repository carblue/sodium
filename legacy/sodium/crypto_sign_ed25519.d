/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_sign_ed25519_H
*/

module sodium.crypto_sign_ed25519;


extern(C) pure @nogc :


enum crypto_sign_ed25519_BYTES = 64U;

size_t crypto_sign_ed25519_bytes() @trusted;

enum crypto_sign_ed25519_SEEDBYTES = 32U;

size_t crypto_sign_ed25519_seedbytes() @trusted;

enum crypto_sign_ed25519_PUBLICKEYBYTES = 32U;

size_t crypto_sign_ed25519_publickeybytes() @trusted;

enum crypto_sign_ed25519_SECRETKEYBYTES = (32U + 32U);

size_t crypto_sign_ed25519_secretkeybytes() @trusted;

int crypto_sign_ed25519(ubyte* sm, ulong* smlen_p,
                        const(ubyte)* m, ulong mlen,
                        const(ubyte)* sk) @system;

int crypto_sign_ed25519_open(ubyte* m, ulong* mlen_p,
                             const(ubyte)* sm, ulong smlen,
                             const(ubyte)* pk) nothrow @system; //  __attribute__ ((warn_unused_result))

int crypto_sign_ed25519_detached(ubyte* sig,
                                 ulong* siglen_p,
                                 const(ubyte)* m,
                                 ulong mlen,
                                 const(ubyte)* sk) @system;

int crypto_sign_ed25519_verify_detached(const(ubyte)* sig,
                                        const(ubyte)* m,
                                        ulong mlen,
                                        const(ubyte)* pk) nothrow @system; //  __attribute__ ((warn_unused_result))

int crypto_sign_ed25519_keypair(ubyte* pk, ubyte* sk) @system;

int crypto_sign_ed25519_seed_keypair(ubyte* pk, ubyte* sk,
                                     const(ubyte)* seed) @system;

int crypto_sign_ed25519_pk_to_curve25519(ubyte* curve25519_pk,
                                         const(ubyte)* ed25519_pk) nothrow @system; //  __attribute__ ((warn_unused_result))

int crypto_sign_ed25519_sk_to_curve25519(ubyte* curve25519_sk,
                                         const(ubyte)* ed25519_sk) @system;

int crypto_sign_ed25519_sk_to_seed(ubyte* seed,
                                   const(ubyte)* sk) @system;

int crypto_sign_ed25519_sk_to_pk(ubyte* pk, const(ubyte)* sk) @system;
