/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_secretstream_xchacha20poly1305_H
*/

module deimos.sodium.crypto_secretstream_xchacha20poly1305;

//#include <stddef.h>
//
import deimos.sodium.crypto_aead_xchacha20poly1305;
import deimos.sodium.crypto_stream_chacha20;
import deimos.sodium.export_;

extern (C) @nogc nothrow :

enum crypto_secretstream_xchacha20poly1305_ABYTES =
    (1U + crypto_aead_xchacha20poly1305_ietf_ABYTES);

size_t crypto_secretstream_xchacha20poly1305_abytes() @trusted;

alias crypto_secretstream_xchacha20poly1305_HEADERBYTES =
    crypto_aead_xchacha20poly1305_ietf_NPUBBYTES;

size_t crypto_secretstream_xchacha20poly1305_headerbytes() @trusted;

alias crypto_secretstream_xchacha20poly1305_KEYBYTES =
    crypto_aead_xchacha20poly1305_ietf_KEYBYTES;

size_t crypto_secretstream_xchacha20poly1305_keybytes() @trusted;

version(bin_v1_0_16)
enum crypto_secretstream_xchacha20poly1305_MESSAGEBYTES_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX, ((1UL << 32) - 2UL) * 64UL);
else
enum crypto_secretstream_xchacha20poly1305_MESSAGEBYTES_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX - crypto_secretstream_xchacha20poly1305_ABYTES,
              (64UL * ((1UL << 32) - 2UL)));

size_t crypto_secretstream_xchacha20poly1305_messagebytes_max() @trusted;

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_MESSAGE = 0x00;

ubyte crypto_secretstream_xchacha20poly1305_tag_message() @trusted;

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_PUSH    = 0x01;

ubyte crypto_secretstream_xchacha20poly1305_tag_push() @trusted;

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_REKEY   = 0x02;

ubyte crypto_secretstream_xchacha20poly1305_tag_rekey() @trusted;

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_FINAL =
    (crypto_secretstream_xchacha20poly1305_TAG_PUSH |
     crypto_secretstream_xchacha20poly1305_TAG_REKEY);

ubyte crypto_secretstream_xchacha20poly1305_tag_final() @trusted;

struct crypto_secretstream_xchacha20poly1305_state {
    ubyte[crypto_stream_chacha20_ietf_KEYBYTES]   k;
    ubyte[crypto_stream_chacha20_ietf_NONCEBYTES] nonce;
    ubyte[8]                                      _pad;
}

size_t crypto_secretstream_xchacha20poly1305_statebytes();

void crypto_secretstream_xchacha20poly1305_keygen
   (ref ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES] k); // __attribute__ ((nonnull));

int crypto_secretstream_xchacha20poly1305_init_push
   (crypto_secretstream_xchacha20poly1305_state* state,
    ref ubyte[crypto_secretstream_xchacha20poly1305_HEADERBYTES] header,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES]) k); // __attribute__ ((nonnull));

int crypto_secretstream_xchacha20poly1305_push
   (crypto_secretstream_xchacha20poly1305_state* state,
    ubyte* c, ulong* clen_p,
    const(ubyte)* m, ulong mlen,
    const(ubyte)* ad, ulong adlen, ubyte tag); // __attribute__ ((nonnull(1)));

int crypto_secretstream_xchacha20poly1305_init_pull
   (crypto_secretstream_xchacha20poly1305_state* state,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_HEADERBYTES]) header,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES]) k); // __attribute__ ((nonnull));

int crypto_secretstream_xchacha20poly1305_pull
   (crypto_secretstream_xchacha20poly1305_state* state,
    ubyte* m, ulong* mlen_p, ubyte* tag_p,
    const(ubyte)* c, ulong clen,
    const(ubyte)* ad, ulong adlen); // __attribute__ ((nonnull(1)));

void crypto_secretstream_xchacha20poly1305_rekey
    (crypto_secretstream_xchacha20poly1305_state* state);

