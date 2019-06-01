/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_stream_H
*/

module deimos.sodium.crypto_stream;

/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */


import deimos.sodium.crypto_stream_xsalsa20 : crypto_stream_xsalsa20_KEYBYTES,
                                              crypto_stream_xsalsa20_NONCEBYTES,
                                              crypto_stream_xsalsa20_MESSAGEBYTES_MAX;


extern(C) @nogc :


alias crypto_stream_KEYBYTES = crypto_stream_xsalsa20_KEYBYTES;

size_t  crypto_stream_keybytes() pure @trusted;

alias crypto_stream_NONCEBYTES = crypto_stream_xsalsa20_NONCEBYTES;

size_t  crypto_stream_noncebytes() pure @trusted;

alias crypto_stream_MESSAGEBYTES_MAX = crypto_stream_xsalsa20_MESSAGEBYTES_MAX;

size_t  crypto_stream_messagebytes_max() pure @trusted;

enum crypto_stream_PRIMITIVE = "xsalsa20";

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
const(char)* crypto_stream_primitive() pure nothrow @trusted;

int crypto_stream(ubyte* c, ulong clen,
                  const(ubyte)* n, const(ubyte)* k) pure; // __attribute__ ((nonnull));

int crypto_stream_xor(ubyte* c, const(ubyte)* m,
                      ulong mlen, const(ubyte)* n,
                      const(ubyte)* k) pure; // __attribute__ ((nonnull));

void crypto_stream_keygen(ref ubyte[crypto_stream_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));
