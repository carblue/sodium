/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_generichash_H
*/

module deimos.sodium.crypto_generichash;

import deimos.sodium.crypto_generichash_blake2b : crypto_generichash_blake2b_state,
                                                  crypto_generichash_blake2b_BYTES_MIN,
                                                  crypto_generichash_blake2b_BYTES_MAX,
                                                  crypto_generichash_blake2b_BYTES,
                                                  crypto_generichash_blake2b_KEYBYTES_MIN,
                                                  crypto_generichash_blake2b_KEYBYTES_MAX,
                                                  crypto_generichash_blake2b_KEYBYTES;


extern(C) @nogc :


alias crypto_generichash_BYTES_MIN = crypto_generichash_blake2b_BYTES_MIN;

size_t  crypto_generichash_bytes_min() pure @trusted;

alias crypto_generichash_BYTES_MAX = crypto_generichash_blake2b_BYTES_MAX;

size_t  crypto_generichash_bytes_max() pure @trusted;

alias crypto_generichash_BYTES = crypto_generichash_blake2b_BYTES;

size_t  crypto_generichash_bytes() pure @trusted;

alias crypto_generichash_KEYBYTES_MIN = crypto_generichash_blake2b_KEYBYTES_MIN;

size_t  crypto_generichash_keybytes_min() pure @trusted;

alias crypto_generichash_KEYBYTES_MAX = crypto_generichash_blake2b_KEYBYTES_MAX;

size_t  crypto_generichash_keybytes_max() pure @trusted;

alias crypto_generichash_KEYBYTES = crypto_generichash_blake2b_KEYBYTES;

size_t  crypto_generichash_keybytes() pure @trusted;

enum crypto_generichash_PRIMITIVE = "blake2b";

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
const(char)* crypto_generichash_primitive() pure nothrow @trusted;

alias crypto_generichash_state = crypto_generichash_blake2b_state;

size_t  crypto_generichash_statebytes() pure @trusted;

int crypto_generichash(ubyte* out_, size_t outlen,
                       const(ubyte)* in_, ulong inlen,
                       const(ubyte)* key, size_t keylen) pure;

int crypto_generichash_init(crypto_generichash_state* state,
                            const(ubyte)* key,
                            const size_t keylen, const size_t outlen) pure;

int crypto_generichash_update(crypto_generichash_state* state,
                              const(ubyte)* in_,
                              ulong inlen) pure;

int crypto_generichash_final(crypto_generichash_state* state,
                             ubyte* out_, const size_t outlen) pure;

void crypto_generichash_keygen(ref ubyte[crypto_generichash_KEYBYTES] k) nothrow @trusted;
