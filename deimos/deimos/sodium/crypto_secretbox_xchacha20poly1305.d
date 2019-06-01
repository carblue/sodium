/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_secretbox_xchacha20poly1305_H
*/

module deimos.sodium.crypto_secretbox_xchacha20poly1305;

version(SODIUM_LIBRARY_MINIMAL) {}
else {

import deimos.sodium.crypto_stream_xchacha20 : crypto_stream_xchacha20_MESSAGEBYTES_MAX;

extern(C) pure @nogc :


enum crypto_secretbox_xchacha20poly1305_KEYBYTES = 32U;

size_t crypto_secretbox_xchacha20poly1305_keybytes() @trusted;

enum crypto_secretbox_xchacha20poly1305_NONCEBYTES = 24U;

size_t crypto_secretbox_xchacha20poly1305_noncebytes() @trusted;

enum crypto_secretbox_xchacha20poly1305_MACBYTES = 16U;

size_t crypto_secretbox_xchacha20poly1305_macbytes() @trusted;

enum crypto_secretbox_xchacha20poly1305_MESSAGEBYTES_MAX =
    (crypto_stream_xchacha20_MESSAGEBYTES_MAX - crypto_secretbox_xchacha20poly1305_MACBYTES);

size_t crypto_secretbox_xchacha20poly1305_messagebytes_max() @trusted;

int crypto_secretbox_xchacha20poly1305_easy(ubyte* c,
                                            const(ubyte)* m,
                                            ulong mlen,
                                            const(ubyte)* n,
                                            const(ubyte)* k); // __attribute__ ((nonnull(1, 4, 5)));

int crypto_secretbox_xchacha20poly1305_open_easy(ubyte* m,
                                                 const(ubyte)* c,
                                                 ulong clen,
                                                 const(ubyte)* n,
                                                 const(ubyte)* k) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));

int crypto_secretbox_xchacha20poly1305_detached(ubyte* c,
                                                ubyte* mac,
                                                const(ubyte)* m,
                                                ulong mlen,
                                                const(ubyte)* n,
                                                const(ubyte)* k); // __attribute__ ((nonnull(1, 2, 5, 6)));

int crypto_secretbox_xchacha20poly1305_open_detached(ubyte* m,
                                                     const(ubyte)* c,
                                                     const(ubyte)* mac,
                                                     ulong clen,
                                                     const(ubyte)* n,
                                                     const(ubyte)* k) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 3, 5, 6)));

}
