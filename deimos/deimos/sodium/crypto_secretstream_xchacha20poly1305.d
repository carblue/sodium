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

extern (C) :

enum crypto_secretstream_xchacha20poly1305_ABYTES =
    (1U + crypto_aead_xchacha20poly1305_ietf_ABYTES);

size_t crypto_secretstream_xchacha20poly1305_abytes();

alias crypto_secretstream_xchacha20poly1305_HEADERBYTES =
    crypto_aead_xchacha20poly1305_ietf_NPUBBYTES;

size_t crypto_secretstream_xchacha20poly1305_headerbytes();

alias crypto_secretstream_xchacha20poly1305_KEYBYTES =
    crypto_aead_xchacha20poly1305_ietf_KEYBYTES;

size_t crypto_secretstream_xchacha20poly1305_keybytes();

enum crypto_secretstream_xchacha20poly1305_MESSAGEBYTES_MAX =
    SODIUM_MIN(SODIUM_SIZE_MAX, ((1UL << 32) - 2UL) * 64UL);

size_t crypto_secretstream_xchacha20poly1305_messagebytes_max();

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_MESSAGE = 0x00;

ubyte crypto_secretstream_xchacha20poly1305_tag_message();

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_PUSH    = 0x01;

ubyte crypto_secretstream_xchacha20poly1305_tag_push();

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_REKEY   = 0x02;

ubyte crypto_secretstream_xchacha20poly1305_tag_rekey();

enum ubyte crypto_secretstream_xchacha20poly1305_TAG_FINAL =
    (crypto_secretstream_xchacha20poly1305_TAG_PUSH |
     crypto_secretstream_xchacha20poly1305_TAG_REKEY);

ubyte crypto_secretstream_xchacha20poly1305_tag_final();

struct crypto_secretstream_xchacha20poly1305_state {
    ubyte[crypto_stream_chacha20_ietf_KEYBYTES]   k;
    ubyte[crypto_stream_chacha20_ietf_NONCEBYTES] nonce;
    ubyte[8]                                      _pad;
}

size_t crypto_secretstream_xchacha20poly1305_statebytes();

void crypto_secretstream_xchacha20poly1305_keygen
   (ref ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES] k);

int crypto_secretstream_xchacha20poly1305_init_push
   (crypto_secretstream_xchacha20poly1305_state* state,
    ref ubyte[crypto_secretstream_xchacha20poly1305_HEADERBYTES] header,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES]) k);

int crypto_secretstream_xchacha20poly1305_push
   (crypto_secretstream_xchacha20poly1305_state* state,
    ubyte* c, ulong* clen_p,
    const(ubyte)* m, ulong mlen,
    const(ubyte)* ad, ulong adlen, ubyte tag);

int crypto_secretstream_xchacha20poly1305_init_pull
   (crypto_secretstream_xchacha20poly1305_state* state,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_HEADERBYTES]) header,
    ref const(ubyte[crypto_secretstream_xchacha20poly1305_KEYBYTES]) k);

int crypto_secretstream_xchacha20poly1305_pull
   (crypto_secretstream_xchacha20poly1305_state* state,
    ubyte* m, ulong* mlen_p, ubyte* tag_p,
    const(ubyte)* c, ulong clen,
    const(ubyte)* ad, ulong adlen);

void crypto_secretstream_xchacha20poly1305_rekey
    (crypto_secretstream_xchacha20poly1305_state* state);

