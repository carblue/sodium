/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_box_curve25519xchacha20poly1305_H
*/

module deimos.sodium.crypto_box_curve25519xchacha20poly1305;

import deimos.sodium.crypto_stream_xchacha20;


extern(C) pure @nogc :


enum crypto_box_curve25519xchacha20poly1305_SEEDBYTES = 32U;

size_t crypto_box_curve25519xchacha20poly1305_seedbytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_PUBLICKEYBYTES = 32U;

size_t crypto_box_curve25519xchacha20poly1305_publickeybytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_SECRETKEYBYTES = 32U;

size_t crypto_box_curve25519xchacha20poly1305_secretkeybytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_BEFORENMBYTES = 32U;

size_t crypto_box_curve25519xchacha20poly1305_beforenmbytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_NONCEBYTES = 24U;

size_t crypto_box_curve25519xchacha20poly1305_noncebytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_MACBYTES = 16U;

size_t crypto_box_curve25519xchacha20poly1305_macbytes() @trusted;

enum crypto_box_curve25519xchacha20poly1305_MESSAGEBYTES_MAX =
    (crypto_stream_xchacha20_MESSAGEBYTES_MAX - crypto_box_curve25519xchacha20poly1305_MACBYTES);

size_t crypto_box_curve25519xchacha20poly1305_messagebytes_max() @trusted;

int crypto_box_curve25519xchacha20poly1305_seed_keypair(ubyte* pk,
                                                        ubyte* sk,
                                                        const(ubyte)* seed);

int crypto_box_curve25519xchacha20poly1305_keypair(ubyte* pk,
                                                   ubyte* sk);

int crypto_box_curve25519xchacha20poly1305_easy(ubyte* c,
                                                const(ubyte)* m,
                                                ulong mlen,
                                                const(ubyte)* n,
                                                const(ubyte)* pk,
                                                const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));

int crypto_box_curve25519xchacha20poly1305_open_easy(ubyte* m,
                                                     const(ubyte)* c,
                                                     ulong clen,
                                                     const(ubyte)* n,
                                                     const(ubyte)* pk,
                                                     const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));

int crypto_box_curve25519xchacha20poly1305_detached(ubyte* c,
                                                    ubyte* mac,
                                                    const(ubyte)* m,
                                                    ulong mlen,
                                                    const(ubyte)* n,
                                                    const(ubyte)* pk,
                                                    const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));

int crypto_box_curve25519xchacha20poly1305_open_detached(ubyte* m,
                                                         const(ubyte)* c,
                                                         const(ubyte)* mac,
                                                         ulong clen,
                                                         const(ubyte)* n,
                                                         const(ubyte)* pk,
                                                         const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));

/* -- Precomputation interface -- */

int crypto_box_curve25519xchacha20poly1305_beforenm(ubyte* k,
                                                    const(ubyte)* pk,
                                                    const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));

int crypto_box_curve25519xchacha20poly1305_easy_afternm(ubyte* c,
                                                        const(ubyte)* m,
                                                        ulong mlen,
                                                        const(ubyte)* n,
                                                        const(ubyte)* k);

int crypto_box_curve25519xchacha20poly1305_open_easy_afternm(ubyte* m,
                                                             const(ubyte)* c,
                                                             ulong clen,
                                                             const(ubyte)* n,
                                                             const(ubyte)* k) nothrow; // __attribute__ ((warn_unused_result));

int crypto_box_curve25519xchacha20poly1305_detached_afternm(ubyte* c,
                                                            ubyte* mac,
                                                            const(ubyte)* m,
                                                            ulong mlen,
                                                            const(ubyte)* n,
                                                            const(ubyte)* k);

int crypto_box_curve25519xchacha20poly1305_open_detached_afternm(ubyte* m,
                                                                 const(ubyte)* c,
                                                                 const(ubyte)* mac,
                                                                 ulong clen,
                                                                 const(ubyte)* n,
                                                                 const(ubyte)* k) nothrow; // __attribute__ ((warn_unused_result));


/* -- Ephemeral SK interface -- */

enum crypto_box_curve25519xchacha20poly1305_SEALBYTES =
    (crypto_box_curve25519xchacha20poly1305_PUBLICKEYBYTES +
     crypto_box_curve25519xchacha20poly1305_MACBYTES);

size_t crypto_box_curve25519xchacha20poly1305_sealbytes() @trusted;

int crypto_box_curve25519xchacha20poly1305_seal(ubyte* c,
                                                const(ubyte)* m,
                                                ulong mlen,
                                                const(ubyte)* pk);

int crypto_box_curve25519xchacha20poly1305_seal_open(ubyte* m,
                                                     const(ubyte)* c,
                                                     ulong clen,
                                                     const(ubyte)* pk,
                                                     const(ubyte)* sk) nothrow; // __attribute__ ((warn_unused_result));
