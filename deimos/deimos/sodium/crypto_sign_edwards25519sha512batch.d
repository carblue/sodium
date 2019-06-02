/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_sign_edwards25519sha512batch_H
*/

module deimos.sodium.crypto_sign_edwards25519sha512batch;

import deimos.sodium.export_;

/*
 * WARNING: This construction was a prototype, which should not be used
 * any more in new projects.
 *
 * crypto_sign_edwards25519sha512batch is provided for applications
 * initially built with NaCl, but as recommended by the author of this
 * construction, new applications should use ed25519 instead.
 *
 * In Sodium, you should use the high-level crypto_sign_*() functions instead.
 */


extern(C) @nogc :


enum crypto_sign_edwards25519sha512batch_BYTES = 64U;
enum crypto_sign_edwards25519sha512batch_PUBLICKEYBYTES = 32U;
enum crypto_sign_edwards25519sha512batch_SECRETKEYBYTES = (32U + 32U);
enum crypto_sign_edwards25519sha512batch_MESSAGEBYTES_MAX = (SODIUM_SIZE_MAX - crypto_sign_edwards25519sha512batch_BYTES);


deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") :


int crypto_sign_edwards25519sha512batch(ubyte* sm,
                                        ulong* smlen_p,
                                        const(ubyte)* m,
                                        ulong mlen,
                                        const(ubyte)* sk) pure; // __attribute__ ((nonnull(1, 5)));

int crypto_sign_edwards25519sha512batch_open(ubyte* m,
                                             ulong* mlen_p,
                                             const(ubyte)* sm,
                                             ulong smlen,
                                             const(ubyte)* pk) pure; // __attribute__ ((nonnull(3, 5)));

int crypto_sign_edwards25519sha512batch_keypair(ubyte* pk,
                                                ubyte* sk) nothrow; // __attribute__ ((nonnull));
