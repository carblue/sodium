/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_scalarmult_ed25519_H
*/

module deimos.sodium.crypto_scalarmult_ed25519;


extern(C) @nogc :


enum crypto_scalarmult_ed25519_BYTES = 32U;

size_t crypto_scalarmult_ed25519_bytes() pure @trusted;

enum crypto_scalarmult_ed25519_SCALARBYTES = 32U;

size_t crypto_scalarmult_ed25519_scalarbytes() pure @trusted;

/*
 * NOTE: Do not use the result of this function directly.
 *
 * Hash the result with the public keys in order to compute a shared
 * secret key: H(q || client_pk || server_pk)
 *
 * Or unless this is not an option, use the crypto_kx() API instead.
 */
int crypto_scalarmult_ed25519(ubyte* q, const(ubyte)* n,
                              const(ubyte)* p) pure nothrow; // __attribute__ ((warn_unused_result));

int crypto_scalarmult_ed25519_base(ubyte* q, const(ubyte)* n) nothrow;
