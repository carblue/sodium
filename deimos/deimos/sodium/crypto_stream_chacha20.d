/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_stream_chacha20_H
*/

module deimos.sodium.crypto_stream_chacha20;

/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

import deimos.sodium.export_;


extern(C) @nogc:


enum crypto_stream_chacha20_KEYBYTES = 32U;

size_t crypto_stream_chacha20_keybytes() pure @trusted;

enum crypto_stream_chacha20_NONCEBYTES = 8U;

size_t crypto_stream_chacha20_noncebytes() pure @trusted;

alias crypto_stream_chacha20_MESSAGEBYTES_MAX = SODIUM_SIZE_MAX;

size_t crypto_stream_chacha20_messagebytes_max() pure @trusted;

/* ChaCha20 with a 64-bit nonce and a 64-bit counter, as originally designed */

int crypto_stream_chacha20(ubyte* c, ulong clen,
                           const(ubyte)* n, const(ubyte)* k) pure; // __attribute__ ((nonnull));

int crypto_stream_chacha20_xor(ubyte* c, const(ubyte)* m,
                               ulong mlen, const(ubyte)* n,
                               const(ubyte)* k) pure; // __attribute__ ((nonnull));

int crypto_stream_chacha20_xor_ic(ubyte* c, const(ubyte)* m,
                                  ulong mlen,
                                  const(ubyte)* n, ulong ic,
                                  const(ubyte)* k) pure; // __attribute__ ((nonnull));

void crypto_stream_chacha20_keygen(ref ubyte[crypto_stream_chacha20_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));

/* ChaCha20 with a 96-bit nonce and a 32-bit counter (IETF) */

enum crypto_stream_chacha20_ietf_KEYBYTES = 32U;

size_t crypto_stream_chacha20_ietf_keybytes() pure @trusted;

enum crypto_stream_chacha20_ietf_NONCEBYTES = 12U;

size_t crypto_stream_chacha20_ietf_noncebytes() pure @trusted;

enum crypto_stream_chacha20_ietf_MESSAGEBYTES_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX, 64UL * (1UL << 32));

size_t crypto_stream_chacha20_ietf_messagebytes_max() pure @trusted;

int crypto_stream_chacha20_ietf(ubyte* c, ulong clen,
                                const(ubyte)* n, const(ubyte)* k) pure nothrow; // __attribute__ ((nonnull));

int crypto_stream_chacha20_ietf_xor(ubyte* c, const(ubyte)* m,
                                    ulong mlen, const(ubyte)* n,
                                    const(ubyte)* k) pure; // __attribute__ ((nonnull));

int crypto_stream_chacha20_ietf_xor_ic(ubyte* c, const(ubyte)* m,
                                       ulong mlen,
                                       const(ubyte)* n, uint ic,
                                       const(ubyte)* k) pure nothrow; // __attribute__ ((nonnull));

void crypto_stream_chacha20_ietf_keygen(ref ubyte[crypto_stream_chacha20_ietf_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));

/* Aliases */

alias crypto_stream_chacha20_IETF_KEYBYTES         = crypto_stream_chacha20_ietf_KEYBYTES;
alias crypto_stream_chacha20_IETF_NONCEBYTES       = crypto_stream_chacha20_ietf_NONCEBYTES;
alias crypto_stream_chacha20_IETF_MESSAGEBYTES_MAX = crypto_stream_chacha20_ietf_MESSAGEBYTES_MAX;
