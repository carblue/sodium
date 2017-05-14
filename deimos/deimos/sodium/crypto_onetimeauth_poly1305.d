/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_onetimeauth_poly1305_H
*/

module deimos.sodium.crypto_onetimeauth_poly1305;


extern(C) @nogc :


align(16) struct crypto_onetimeauth_poly1305_state {
    ubyte[256] opaque;
}

size_t crypto_onetimeauth_poly1305_statebytes() pure @trusted;

enum crypto_onetimeauth_poly1305_BYTES = 16U;

size_t crypto_onetimeauth_poly1305_bytes() pure @trusted;

enum crypto_onetimeauth_poly1305_KEYBYTES = 32U;

size_t crypto_onetimeauth_poly1305_keybytes() pure @trusted;

int crypto_onetimeauth_poly1305(ubyte* out_,
                                const(ubyte)* in_,
                                ulong inlen,
                                const(ubyte)* k) pure;

int crypto_onetimeauth_poly1305_verify(const(ubyte)* h,
                                       const(ubyte)* in_,
                                       ulong inlen,
                                       const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result));

int crypto_onetimeauth_poly1305_init(crypto_onetimeauth_poly1305_state* state,
                                     const(ubyte)* key) pure;

int crypto_onetimeauth_poly1305_update(crypto_onetimeauth_poly1305_state* state,
                                       const(ubyte)* in_,
                                       ulong inlen) pure;

int crypto_onetimeauth_poly1305_final(crypto_onetimeauth_poly1305_state* state,
                                      ubyte* out_) pure;

void crypto_onetimeauth_poly1305_keygen(ref ubyte[crypto_onetimeauth_poly1305_KEYBYTES] k) nothrow @trusted;
