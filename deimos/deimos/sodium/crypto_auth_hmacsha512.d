/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_auth_hmacsha512_H
*/

module deimos.sodium.crypto_auth_hmacsha512;

import deimos.sodium.crypto_hash_sha512 : crypto_hash_sha512_state;


extern(C) @nogc :


enum crypto_auth_hmacsha512_BYTES = 64U;

size_t crypto_auth_hmacsha512_bytes() pure @trusted;

enum crypto_auth_hmacsha512_KEYBYTES = 32U;

size_t crypto_auth_hmacsha512_keybytes() pure @trusted;

int crypto_auth_hmacsha512(ubyte* out_,
                           const(ubyte)* in_,
                           ulong inlen,
                           const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 4)));

int crypto_auth_hmacsha512_verify(const(ubyte)* h,
                                  const(ubyte)* in_,
                                  ulong inlen,
                                  const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(1, 4)));

/* ------------------------------------------------------------------------- */

struct crypto_auth_hmacsha512_state {
    crypto_hash_sha512_state ictx;
    crypto_hash_sha512_state octx;
}

size_t crypto_auth_hmacsha512_statebytes() pure @trusted;

int crypto_auth_hmacsha512_init(crypto_auth_hmacsha512_state* state,
                                const(ubyte)* key,
                                size_t keylen) pure; // __attribute__ ((nonnull));

int crypto_auth_hmacsha512_update(crypto_auth_hmacsha512_state* state,
                                  const(ubyte)* in_,
                                  ulong inlen) pure; // __attribute__ ((nonnull(1)));

int crypto_auth_hmacsha512_final(crypto_auth_hmacsha512_state* state,
                                 ubyte* out_) pure; // __attribute__ ((nonnull));

void crypto_auth_hmacsha512_keygen(ref ubyte[crypto_auth_hmacsha512_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));
