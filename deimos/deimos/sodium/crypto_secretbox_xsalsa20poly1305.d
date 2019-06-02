/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_secretbox_xsalsa20poly1305_H
*/

module deimos.sodium.crypto_secretbox_xsalsa20poly1305;

import deimos.sodium.crypto_stream_xsalsa20 : crypto_stream_xsalsa20_MESSAGEBYTES_MAX;

extern(C) @nogc :


enum crypto_secretbox_xsalsa20poly1305_KEYBYTES = 32U;

size_t crypto_secretbox_xsalsa20poly1305_keybytes() pure @trusted;

enum crypto_secretbox_xsalsa20poly1305_NONCEBYTES = 24U;

size_t crypto_secretbox_xsalsa20poly1305_noncebytes() pure @trusted;

enum crypto_secretbox_xsalsa20poly1305_MACBYTES = 16U;

size_t crypto_secretbox_xsalsa20poly1305_macbytes() pure @trusted;

/* Only for the libsodium API - The NaCl compatibility API would require BOXZEROBYTES extra bytes */
enum crypto_secretbox_xsalsa20poly1305_MESSAGEBYTES_MAX =
    (crypto_stream_xsalsa20_MESSAGEBYTES_MAX - crypto_secretbox_xsalsa20poly1305_MACBYTES);

size_t crypto_secretbox_xsalsa20poly1305_messagebytes_max() pure @trusted;

int crypto_secretbox_xsalsa20poly1305(ubyte* c,
                                      const(ubyte)* m,
                                      ulong mlen,
                                      const(ubyte)* n,
                                      const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4, 5)));

int crypto_secretbox_xsalsa20poly1305_open(ubyte* m,
                                           const(ubyte)* c,
                                           ulong clen,
                                           const(ubyte)* n,
                                           const(ubyte)* k) pure nothrow; //  __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));

void crypto_secretbox_xsalsa20poly1305_keygen(ref ubyte[crypto_secretbox_xsalsa20poly1305_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));

/* -- NaCl compatibility interface ; Requires padding -- */

enum crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES = 16U;

size_t crypto_secretbox_xsalsa20poly1305_boxzerobytes() pure @trusted;

enum crypto_secretbox_xsalsa20poly1305_ZEROBYTES =
    (crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES +
     crypto_secretbox_xsalsa20poly1305_MACBYTES);

size_t crypto_secretbox_xsalsa20poly1305_zerobytes() pure @trusted;
