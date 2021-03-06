/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_secretbox_H
*/

module deimos.sodium.crypto_secretbox;

import deimos.sodium.crypto_secretbox_xsalsa20poly1305 : crypto_secretbox_xsalsa20poly1305_KEYBYTES,
                                                         crypto_secretbox_xsalsa20poly1305_NONCEBYTES,
                                                         crypto_secretbox_xsalsa20poly1305_MACBYTES,
                                                         crypto_secretbox_xsalsa20poly1305_MESSAGEBYTES_MAX,
                                                         crypto_secretbox_xsalsa20poly1305_ZEROBYTES,
                                                         crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES;


extern(C) @nogc :


alias crypto_secretbox_KEYBYTES = crypto_secretbox_xsalsa20poly1305_KEYBYTES;

size_t  crypto_secretbox_keybytes() pure @trusted;

alias crypto_secretbox_NONCEBYTES = crypto_secretbox_xsalsa20poly1305_NONCEBYTES;

size_t  crypto_secretbox_noncebytes() pure @trusted;

alias crypto_secretbox_MACBYTES = crypto_secretbox_xsalsa20poly1305_MACBYTES;

size_t  crypto_secretbox_macbytes() pure @trusted;

enum crypto_secretbox_PRIMITIVE = "xsalsa20poly1305";

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
const(char)* crypto_secretbox_primitive() pure nothrow @trusted;

alias crypto_secretbox_MESSAGEBYTES_MAX = crypto_secretbox_xsalsa20poly1305_MESSAGEBYTES_MAX;

size_t crypto_secretbox_messagebytes_max() pure @trusted;

int crypto_secretbox_easy(ubyte* c, const(ubyte)* m,
                          ulong mlen, const(ubyte)* n,
                          const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4, 5)));

int crypto_secretbox_open_easy(ubyte* m, const(ubyte)* c,
                               ulong clen, const(ubyte)* n,
                               const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));

int crypto_secretbox_detached(ubyte* c, ubyte* mac,
                              const(ubyte)* m,
                              ulong mlen,
                              const(ubyte)* n,
                              const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 2, 5, 6)));

int crypto_secretbox_open_detached(ubyte* m,
                                   const(ubyte)* c,
                                   const(ubyte)* mac,
                                   ulong clen,
                                   const(ubyte)* n,
                                   const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 3, 5, 6)));

void crypto_secretbox_keygen(ref ubyte[crypto_secretbox_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));

/* -- NaCl compatibility interface ; Requires padding -- */

alias crypto_secretbox_ZEROBYTES = crypto_secretbox_xsalsa20poly1305_ZEROBYTES;

size_t  crypto_secretbox_zerobytes() pure @trusted;

alias crypto_secretbox_BOXZEROBYTES = crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES;

size_t  crypto_secretbox_boxzerobytes() pure @trusted;

int crypto_secretbox(ubyte* c, const(ubyte)* m,
                     ulong mlen, const(ubyte)* n,
                     const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4, 5)));

int crypto_secretbox_open(ubyte* m, const(ubyte)* c,
                          ulong clen, const(ubyte)* n,
                          const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));
