/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_aead_aes256gcm_H
*/
/*
 * WARNING: Despite being the most popular AEAD construction due to its
 * use in TLS, safely using AES-GCM in a different context is tricky.
 *
 * No more than ~ 350 GB of input data should be encrypted with a given key.
 * This is for ~ 16 KB messages -- Actual figures vary according to
 * message sizes.
 *
 * In addition, nonces are short and repeated nonces would totally destroy
 * the security of this scheme.
 *
 * Nonces should thus come from atomic counters, which can be difficult to
 * set up in a distributed environment.
 *
 * Unless you absolutely need AES-GCM, use crypto_aead_xchacha20poly1305_ietf_*()
 * instead. It doesn't have any of these limitations.
 * Or, if you don't need to authenticate additional data, just stick to
 * crypto_secretbox().
 */

module deimos.sodium.crypto_aead_aes256gcm;

import deimos.sodium.export_;

extern(C) @nogc :


int crypto_aead_aes256gcm_is_available() pure @trusted;

enum crypto_aead_aes256gcm_KEYBYTES = 32U;

size_t crypto_aead_aes256gcm_keybytes() pure @trusted;

enum crypto_aead_aes256gcm_NSECBYTES = 0U;

size_t crypto_aead_aes256gcm_nsecbytes() pure @trusted;

enum crypto_aead_aes256gcm_NPUBBYTES = 12U;

size_t crypto_aead_aes256gcm_npubbytes() pure @trusted;

enum crypto_aead_aes256gcm_ABYTES   = 16U;

size_t crypto_aead_aes256gcm_abytes() pure @trusted;

enum crypto_aead_aes256gcm_MESSAGEBYTES_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX - crypto_aead_aes256gcm_ABYTES,
               (16UL * ((1UL << 32) - 2UL)) - crypto_aead_aes256gcm_ABYTES);

size_t crypto_aead_aes256gcm_messagebytes_max() pure @trusted;

alias  crypto_aead_aes256gcm_state = align(16) ubyte[512]; // typedef CRYPTO_ALIGN(16) unsigned char crypto_aead_aes256gcm_state[512];

size_t crypto_aead_aes256gcm_statebytes() pure @trusted;

int crypto_aead_aes256gcm_encrypt(ubyte* c,
                                  ulong* clen_p,
                                  const(ubyte)* m,
                                  ulong mlen,
                                  const(ubyte)* ad,
                                  ulong adlen,
                                  const(ubyte)* nsec,
                                  const(ubyte)* npub,
                                  const(ubyte)* k) pure;

int crypto_aead_aes256gcm_decrypt(ubyte* m,
                                  ulong* mlen_p,
                                  ubyte* nsec,
                                  const(ubyte)* c,
                                  ulong clen,
                                  const(ubyte)* ad,
                                  ulong adlen,
                                  const(ubyte)* npub,
                                  const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result))

int crypto_aead_aes256gcm_encrypt_detached(ubyte* c,
                                           ubyte* mac,
                                           ulong* maclen_p,
                                           const(ubyte)* m,
                                           ulong mlen,
                                           const(ubyte)* ad,
                                           ulong adlen,
                                           const(ubyte)* nsec,
                                           const(ubyte)* npub,
                                           const(ubyte)* k) pure;

int crypto_aead_aes256gcm_decrypt_detached(ubyte *m,
                                           ubyte *nsec,
                                           const(ubyte)* c,
                                           ulong clen,
                                           const(ubyte)* mac,
                                           const(ubyte)* ad,
                                           ulong adlen,
                                           const(ubyte)* npub,
                                           const(ubyte)* k) pure nothrow; // __attribute__ ((warn_unused_result))

/* -- Precomputation interface -- */

int crypto_aead_aes256gcm_beforenm(crypto_aead_aes256gcm_state* ctx_,
                                   const(ubyte)* k) pure;

int crypto_aead_aes256gcm_encrypt_afternm(ubyte* c,
                                          ulong* clen_p,
                                          const(ubyte)* m,
                                          ulong mlen,
                                          const(ubyte)* ad,
                                          ulong adlen,
                                          const(ubyte)* nsec,
                                          const(ubyte)* npub,
                                          const(crypto_aead_aes256gcm_state)* ctx_) pure;

int crypto_aead_aes256gcm_decrypt_afternm(ubyte* m,
                                          ulong* mlen_p,
                                          ubyte* nsec,
                                          const(ubyte)* c,
                                          ulong clen,
                                          const(ubyte)* ad,
                                          ulong adlen,
                                          const(ubyte)* npub,
                                          const(crypto_aead_aes256gcm_state)* ctx_) pure nothrow; // __attribute__ ((warn_unused_result))

int crypto_aead_aes256gcm_encrypt_detached_afternm(ubyte* c,
                                                   ubyte* mac,
                                                   ulong* maclen_p,
                                                   const(ubyte)* m,
                                                   ulong mlen,
                                                   const(ubyte)* ad,
                                                   ulong adlen,
                                                   const(ubyte)* nsec,
                                                   const(ubyte)* npub,
                                                   const(crypto_aead_aes256gcm_state)* ctx_) pure;

int crypto_aead_aes256gcm_decrypt_detached_afternm(ubyte* m,
                                                   ubyte* nsec,
                                                   const(ubyte)* c,
                                                   ulong clen,
                                                   const(ubyte)* mac,
                                                   const(ubyte)* ad,
                                                   ulong adlen,
                                                   const(ubyte)* npub,
                                                   const(crypto_aead_aes256gcm_state)* ctx_) pure nothrow; // __attribute__ ((warn_unused_result))

void crypto_aead_aes256gcm_keygen(ref ubyte[crypto_aead_aes256gcm_KEYBYTES] k) nothrow @trusted;
