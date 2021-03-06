/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_aead_xchacha20poly1305_H
*/

module deimos.sodium.crypto_aead_xchacha20poly1305;

import deimos.sodium.export_;

extern(C) @nogc :


enum crypto_aead_xchacha20poly1305_ietf_KEYBYTES = 32U;

size_t crypto_aead_xchacha20poly1305_ietf_keybytes() pure @trusted;

enum crypto_aead_xchacha20poly1305_ietf_NSECBYTES = 0U;

size_t crypto_aead_xchacha20poly1305_ietf_nsecbytes() pure @trusted;

enum crypto_aead_xchacha20poly1305_ietf_NPUBBYTES = 24U;

size_t crypto_aead_xchacha20poly1305_ietf_npubbytes() pure @trusted;

enum crypto_aead_xchacha20poly1305_ietf_ABYTES = 16U;

size_t crypto_aead_xchacha20poly1305_ietf_abytes() pure @trusted;

enum crypto_aead_xchacha20poly1305_ietf_MESSAGEBYTES_MAX =
    (SODIUM_SIZE_MAX - crypto_aead_xchacha20poly1305_ietf_ABYTES);

size_t crypto_aead_xchacha20poly1305_ietf_messagebytes_max() pure @trusted;

int crypto_aead_xchacha20poly1305_ietf_encrypt(ubyte* c,
                                               ulong* clen_p,
                                               const(ubyte)* m,
                                               ulong mlen,
                                               const(ubyte)* ad,
                                               ulong adlen,
                                               const(ubyte)* nsec,
                                               const(ubyte)* npub,
                                               const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 8, 9)));

int crypto_aead_xchacha20poly1305_ietf_decrypt(ubyte* m,
                                               ulong* mlen_p,
                                               ubyte* nsec,
                                               const(ubyte)* c,
                                               ulong clen,
                                               const(ubyte)* ad,
                                               ulong adlen,
                                               const(ubyte)* npub,
                                               const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(4, 8, 9)));

int crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ubyte* c,
                                                        ubyte* mac,
                                                        ulong* maclen_p,
                                                        const(ubyte)* m,
                                                        ulong mlen,
                                                        const(ubyte)* ad,
                                                        ulong adlen,
                                                        const(ubyte)* nsec,
                                                        const(ubyte)* npub,
                                                        const(ubyte)* k) pure; // __attribute__ ((nonnull(1, 2, 9, 10)));

int crypto_aead_xchacha20poly1305_ietf_decrypt_detached(ubyte* m,
                                                        ubyte* nsec,
                                                        const(ubyte)* c,
                                                        ulong clen,
                                                        const(ubyte)* mac,
                                                        const(ubyte)* ad,
                                                        ulong adlen,
                                                        const(ubyte)* npub,
                                                        const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(3, 5, 8, 9)));

void crypto_aead_xchacha20poly1305_ietf_keygen(ref ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k) nothrow @trusted; // __attribute__ ((nonnull));

/* Aliases */

alias crypto_aead_xchacha20poly1305_IETF_KEYBYTES         = crypto_aead_xchacha20poly1305_ietf_KEYBYTES;
alias crypto_aead_xchacha20poly1305_IETF_NSECBYTES        = crypto_aead_xchacha20poly1305_ietf_NSECBYTES;
alias crypto_aead_xchacha20poly1305_IETF_NPUBBYTES        = crypto_aead_xchacha20poly1305_ietf_NPUBBYTES;
alias crypto_aead_xchacha20poly1305_IETF_ABYTES           = crypto_aead_xchacha20poly1305_ietf_ABYTES;
alias crypto_aead_xchacha20poly1305_IETF_MESSAGEBYTES_MAX = crypto_aead_xchacha20poly1305_ietf_MESSAGEBYTES_MAX;
