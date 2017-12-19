/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_core_ed25519_H
*/

module deimos.sodium.crypto_core_ed25519;


extern(C) @nogc :


enum crypto_core_ed25519_BYTES = 32;

size_t crypto_core_ed25519_bytes() pure @trusted;

enum crypto_core_ed25519_UNIFORMBYTES = 32;

size_t crypto_core_ed25519_uniformbytes() pure @trusted;

int crypto_core_ed25519_is_valid_point(const(ubyte)* p) nothrow;

int crypto_core_ed25519_add(ubyte* r,
                            const(ubyte)* p, const(ubyte)* q) nothrow;

int crypto_core_ed25519_sub(ubyte* r,
                            const(ubyte)* p, const(ubyte)* q) nothrow;

int crypto_core_ed25519_from_uniform(ubyte* p, const(ubyte)* r) nothrow;
