/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_auth_H
*/

module deimos.sodium.crypto_auth;

import deimos.sodium.crypto_auth_hmacsha512256 : crypto_auth_hmacsha512256_BYTES,
                                                 crypto_auth_hmacsha512256_KEYBYTES;


extern(C) @nogc :


alias crypto_auth_BYTES = crypto_auth_hmacsha512256_BYTES;

size_t  crypto_auth_bytes() pure @trusted;

alias crypto_auth_KEYBYTES = crypto_auth_hmacsha512256_KEYBYTES;

size_t  crypto_auth_keybytes() pure @trusted;

enum crypto_auth_PRIMITIVE = "hmacsha512256";

const(char)* crypto_auth_primitive() pure @trusted;

int crypto_auth(ubyte* out_, const(ubyte)* in_,
                ulong inlen, const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4)));

int crypto_auth_verify(const(ubyte)* h, const(ubyte)* in_,
                       ulong inlen, const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 4)));

void crypto_auth_keygen(ref ubyte[crypto_auth_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));
