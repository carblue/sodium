/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_onetimeauth_H
*/

module deimos.sodium.crypto_onetimeauth;

import deimos.sodium.crypto_onetimeauth_poly1305 : crypto_onetimeauth_poly1305_state,
                                                   crypto_onetimeauth_poly1305_BYTES,
                                                   crypto_onetimeauth_poly1305_KEYBYTES;


extern(C) @nogc :

alias crypto_onetimeauth_state = crypto_onetimeauth_poly1305_state;

size_t  crypto_onetimeauth_statebytes() pure @trusted;

alias crypto_onetimeauth_BYTES = crypto_onetimeauth_poly1305_BYTES;

size_t  crypto_onetimeauth_bytes() pure @trusted;

alias crypto_onetimeauth_KEYBYTES = crypto_onetimeauth_poly1305_KEYBYTES;

size_t  crypto_onetimeauth_keybytes() pure @trusted;

enum crypto_onetimeauth_PRIMITIVE = "poly1305";

const(char)* crypto_onetimeauth_primitive() pure @trusted;

int crypto_onetimeauth(ubyte* out_, const(ubyte)* in_,
                       ulong inlen, const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4)));

int crypto_onetimeauth_verify(const(ubyte)* h, const(ubyte)* in_,
                              ulong inlen, const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 4)));

int crypto_onetimeauth_init(crypto_onetimeauth_state* state,
                            const(ubyte)* key) pure; // __attribute__ ((nonnull));

int crypto_onetimeauth_update(crypto_onetimeauth_state* state,
                              const(ubyte)* in_,
                              ulong inlen) pure; // __attribute__ ((nonnull(1)));

int crypto_onetimeauth_final(crypto_onetimeauth_state* state,
                             ubyte* out_) pure; // __attribute__ ((nonnull));

void crypto_onetimeauth_keygen(ref ubyte[crypto_onetimeauth_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));
