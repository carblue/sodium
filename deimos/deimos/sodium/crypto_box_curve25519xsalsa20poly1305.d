/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_box_curve25519xsalsa20poly1305_H
*/

module deimos.sodium.crypto_box_curve25519xsalsa20poly1305;

import deimos.sodium.crypto_stream_xsalsa20 : crypto_stream_xsalsa20_MESSAGEBYTES_MAX;

extern(C) @nogc :


enum crypto_box_curve25519xsalsa20poly1305_SEEDBYTES = 32U;

size_t crypto_box_curve25519xsalsa20poly1305_seedbytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES = 32U;

size_t crypto_box_curve25519xsalsa20poly1305_publickeybytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES = 32U;

size_t crypto_box_curve25519xsalsa20poly1305_secretkeybytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES = 32U;

size_t crypto_box_curve25519xsalsa20poly1305_beforenmbytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_NONCEBYTES = 24U;

size_t crypto_box_curve25519xsalsa20poly1305_noncebytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_MACBYTES = 16U;

size_t crypto_box_curve25519xsalsa20poly1305_macbytes() pure @trusted;

/* Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes */
enum crypto_box_curve25519xsalsa20poly1305_MESSAGEBYTES_MAX =
    (crypto_stream_xsalsa20_MESSAGEBYTES_MAX - crypto_box_curve25519xsalsa20poly1305_MACBYTES);

size_t crypto_box_curve25519xsalsa20poly1305_messagebytes_max() pure @trusted;

int crypto_box_curve25519xsalsa20poly1305_seed_keypair(ubyte* pk,
                                                       ubyte* sk,
                                                       const(ubyte)* seed) pure; // __attribute__ ((nonnull));

int crypto_box_curve25519xsalsa20poly1305_keypair(ubyte* pk,
                                                  ubyte* sk) nothrow; // __attribute__ ((nonnull));

int crypto_box_curve25519xsalsa20poly1305_beforenm(ubyte* k,
                                                   const(ubyte)* pk,
                                                   const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result))  __attribute__ ((nonnull));

/* -- NaCl compatibility interface ; Requires padding -- */

enum crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES = 16U;

size_t crypto_box_curve25519xsalsa20poly1305_boxzerobytes() pure @trusted;

enum crypto_box_curve25519xsalsa20poly1305_ZEROBYTES =
    (crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES +
     crypto_box_curve25519xsalsa20poly1305_MACBYTES);

size_t crypto_box_curve25519xsalsa20poly1305_zerobytes() pure @trusted;

int crypto_box_curve25519xsalsa20poly1305(ubyte* c,
                                          const(ubyte)* m,
                                          ulong mlen,
                                          const(ubyte)* n,
                                          const(ubyte)* pk,
                                          const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result))  __attribute__ ((nonnull(1, 4, 5, 6)));

int crypto_box_curve25519xsalsa20poly1305_open(ubyte* m,
                                               const(ubyte)* c,
                                               ulong clen,
                                               const(ubyte)* n,
                                               const(ubyte)* pk,
                                               const(ubyte)* sk) pure nothrow; // __attribute__ ((warn_unused_result))  __attribute__ ((nonnull(2, 4, 5, 6)));

int crypto_box_curve25519xsalsa20poly1305_afternm(ubyte* c,
                                                  const(ubyte)* m,
                                                  ulong mlen,
                                                  const(ubyte)* n,
                                                  const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4, 5)));

int crypto_box_curve25519xsalsa20poly1305_open_afternm(ubyte* m,
                                                       const(ubyte)* c,
                                                       ulong clen,
                                                       const(ubyte)* n,
                                                       const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));
