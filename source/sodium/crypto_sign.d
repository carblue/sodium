// D import file generated from 'crypto_sign.d' renamed to 'crypto_sign.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 * THREAD SAFETY: crypto_sign_keypair() is thread-safe,
 * provided that you called sodium_init() once before using any
 * other libsodium function.
 * Other functions, including crypto_sign_seed_keypair() are always thread-safe.
 */

module sodium.crypto_sign;

import sodium.crypto_sign_ed25519;

extern (C) 
{
	enum crypto_sign_BYTES = crypto_sign_ed25519_BYTES;
	size_t crypto_sign_bytes();
	enum crypto_sign_SEEDBYTES = crypto_sign_ed25519_SEEDBYTES;
	size_t crypto_sign_seedbytes();
	enum crypto_sign_PUBLICKEYBYTES = crypto_sign_ed25519_PUBLICKEYBYTES;
	size_t crypto_sign_publickeybytes();
	enum crypto_sign_SECRETKEYBYTES = crypto_sign_ed25519_SECRETKEYBYTES;
	size_t crypto_sign_secretkeybytes();
	immutable(char*) crypto_sign_PRIMITIVE = "ed25519";
	const(char)* crypto_sign_primitive();
	int crypto_sign_seed_keypair(ubyte* pk, ubyte* sk, const(ubyte)* seed);
	int crypto_sign_keypair(ubyte* pk, ubyte* sk);
	int crypto_sign(ubyte* sm, ulong* smlen_p, const(ubyte)* m, ulong mlen, const(ubyte)* sk);
	int crypto_sign_open(ubyte* m, ulong* mlen_p, const(ubyte)* sm, ulong smlen, const(ubyte)* pk);
	int crypto_sign_detached(ubyte* sig, ulong* siglen_p, const(ubyte)* m, ulong mlen, const(ubyte)* sk);
	int crypto_sign_verify_detached(const(ubyte)* sig, const(ubyte)* m, ulong mlen, const(ubyte)* pk);
}
