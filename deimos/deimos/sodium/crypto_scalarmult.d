/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_scalarmult_H
*/

module deimos.sodium.crypto_scalarmult;

import deimos.sodium.crypto_scalarmult_curve25519 : crypto_scalarmult_curve25519_BYTES,
                                                    crypto_scalarmult_curve25519_SCALARBYTES;


extern(C) pure @nogc :


alias crypto_scalarmult_BYTES = crypto_scalarmult_curve25519_BYTES;

size_t  crypto_scalarmult_bytes() @trusted;

alias crypto_scalarmult_SCALARBYTES = crypto_scalarmult_curve25519_SCALARBYTES;

size_t  crypto_scalarmult_scalarbytes() @trusted;

enum crypto_scalarmult_PRIMITIVE = "curve25519";

const(char)* crypto_scalarmult_primitive() @trusted;

int crypto_scalarmult_base(ubyte* q, const(ubyte)* n); // __attribute__ ((nonnull));

/*
 * NOTE: Do not use the result of this function directly for key exchange.
 *
 * Hash the result with the public keys in order to compute a shared
 * secret key: H(q || client_pk || server_pk)
 *
 * Or unless this is not an option, use the crypto_kx() API instead.
 */
int crypto_scalarmult(ubyte* q, const(ubyte)* n,
                      const(ubyte)* p) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));
