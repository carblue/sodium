/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_shorthash_H
*/

module deimos.sodium.crypto_shorthash;

import deimos.sodium.crypto_shorthash_siphash24 : crypto_shorthash_siphash24_BYTES,
                                                  crypto_shorthash_siphash24_KEYBYTES;


extern(C) @nogc :


alias crypto_shorthash_BYTES = crypto_shorthash_siphash24_BYTES;

size_t  crypto_shorthash_bytes() pure @trusted;

alias crypto_shorthash_KEYBYTES = crypto_shorthash_siphash24_KEYBYTES;

size_t  crypto_shorthash_keybytes() pure @trusted;

enum crypto_shorthash_PRIMITIVE = "siphash24";

const(char)* crypto_shorthash_primitive() pure @trusted;

int crypto_shorthash(ubyte* out_, const(ubyte)* in_,
                     ulong inlen, const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4)));

void crypto_shorthash_keygen(ref ubyte[crypto_shorthash_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));
