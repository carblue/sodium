// D import file generated from 'crypto_sign_edwards25519sha512batch.d' renamed to 'crypto_sign_edwards25519sha512batch.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

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


module sodium.crypto_sign_edwards25519sha512batch;

extern (C) 
{
	enum crypto_sign_edwards25519sha512batch_BYTES = 64u;
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") size_t crypto_sign_edwards25519sha512batch_bytes();
	enum crypto_sign_edwards25519sha512batch_PUBLICKEYBYTES = 32u;
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") size_t crypto_sign_edwards25519sha512batch_publickeybytes();
	enum crypto_sign_edwards25519sha512batch_SECRETKEYBYTES = 32u + 32u;
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") size_t crypto_sign_edwards25519sha512batch_secretkeybytes();
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") int crypto_sign_edwards25519sha512batch(ubyte* sm, ulong* smlen_p, const(ubyte)* m, ulong mlen, const(ubyte)* sk);
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") int crypto_sign_edwards25519sha512batch_open(ubyte* m, ulong* mlen_p, const(ubyte)* sm, ulong smlen, const(ubyte)* pk);
	deprecated("Please use the high-level crypto_sign_*() functions instead in new projects.") int crypto_sign_edwards25519sha512batch_keypair(ubyte* pk, ubyte* sk);
}
