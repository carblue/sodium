/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_kx_H
*/

module deimos.sodium.crypto_kx;


extern(C) @nogc @trusted :


enum crypto_kx_PUBLICKEYBYTES = 32;

size_t crypto_kx_publickeybytes() pure;

enum crypto_kx_SECRETKEYBYTES = 32;

size_t crypto_kx_secretkeybytes() pure;

enum crypto_kx_SEEDBYTES = 32;

size_t crypto_kx_seedbytes() pure;

enum crypto_kx_SESSIONKEYBYTES = 32;

size_t crypto_kx_sessionkeybytes() pure;

enum crypto_kx_PRIMITIVE = "x25519blake2b";

const(char)* crypto_kx_primitive() pure;

int crypto_kx_seed_keypair(ref ubyte[crypto_kx_PUBLICKEYBYTES] pk,
                           ref ubyte[crypto_kx_SECRETKEYBYTES] sk,
                           ref const(ubyte)[crypto_kx_SEEDBYTES] seed) pure; //  __attribute__ ((nonnull));

int crypto_kx_keypair(ref ubyte[crypto_kx_PUBLICKEYBYTES] pk,
                      ref ubyte[crypto_kx_SECRETKEYBYTES] sk) nothrow; // __attribute__ ((nonnull));

int crypto_kx_client_session_keys(ref ubyte[crypto_kx_SESSIONKEYBYTES] rx,
                                  ref ubyte[crypto_kx_SESSIONKEYBYTES] tx,
                                  ref const(ubyte)[crypto_kx_PUBLICKEYBYTES] client_pk,
                                  ref const(ubyte)[crypto_kx_SECRETKEYBYTES] client_sk,
                                  ref const(ubyte)[crypto_kx_PUBLICKEYBYTES] server_pk) pure nothrow; // __attribute__ ((warn_unused_result))  __attribute__ ((nonnull(3, 4, 5)));

int crypto_kx_server_session_keys(ref ubyte[crypto_kx_SESSIONKEYBYTES] rx,
                                  ref ubyte[crypto_kx_SESSIONKEYBYTES] tx,
                                  ref const(ubyte)[crypto_kx_PUBLICKEYBYTES] server_pk,
                                  ref const(ubyte)[crypto_kx_SECRETKEYBYTES] server_sk,
                                  ref const(ubyte)[crypto_kx_PUBLICKEYBYTES] client_pk) pure nothrow; // __attribute__ ((warn_unused_result))  __attribute__ ((nonnull(3, 4, 5)));
