/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_stream_aes128ctr_H
*/

module deimos.sodium.crypto_stream_aes128ctr;

/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

import deimos.sodium.export_;


extern(C) pure @nogc :


enum crypto_stream_aes128ctr_KEYBYTES = 16U;

size_t crypto_stream_aes128ctr_keybytes() @trusted;

enum crypto_stream_aes128ctr_NONCEBYTES = 16U;

size_t crypto_stream_aes128ctr_noncebytes() @trusted;

enum crypto_stream_aes128ctr_BEFORENMBYTES = 1408U;

size_t crypto_stream_aes128ctr_beforenmbytes() @trusted;

enum crypto_stream_aes128ctr_SIZE_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX, 16UL * (1UL << 32));

deprecated :

int crypto_stream_aes128ctr(ubyte* out_, ulong outlen,
                            const(ubyte)* n, const(ubyte)* k);

int crypto_stream_aes128ctr_xor(ubyte* out_, const(ubyte)* in_,
                                ulong inlen, const(ubyte)* n,
                                const(ubyte)* k);

int crypto_stream_aes128ctr_beforenm(ubyte* c, const(ubyte)* k);

int crypto_stream_aes128ctr_afternm(ubyte* out_, ulong len,
                                    const(ubyte)* nonce, const(ubyte)* c);

int crypto_stream_aes128ctr_xor_afternm(ubyte* out_, const(ubyte)* in_,
                                        ulong len,
                                        const(ubyte)* nonce,
                                        const(ubyte)* c);
