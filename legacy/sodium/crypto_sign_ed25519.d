// D import file generated from 'crypto_sign_ed25519.d' renamed to 'crypto_sign_ed25519.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_sign_ed25519;

extern (C) 
{
	enum crypto_sign_ed25519_BYTES = 64u;
	size_t crypto_sign_ed25519_bytes();
	enum crypto_sign_ed25519_SEEDBYTES = 32u;
	size_t crypto_sign_ed25519_seedbytes();
	enum crypto_sign_ed25519_PUBLICKEYBYTES = 32u;
	size_t crypto_sign_ed25519_publickeybytes();
	enum crypto_sign_ed25519_SECRETKEYBYTES = 32u + 32u;
	size_t crypto_sign_ed25519_secretkeybytes();
	int crypto_sign_ed25519(ubyte* sm, ulong* smlen_p, const(ubyte)* m, ulong mlen, const(ubyte)* sk);
	int crypto_sign_ed25519_open(ubyte* m, ulong* mlen_p, const(ubyte)* sm, ulong smlen, const(ubyte)* pk);
	int crypto_sign_ed25519_detached(ubyte* sig, ulong* siglen_p, const(ubyte)* m, ulong mlen, const(ubyte)* sk);
	int crypto_sign_ed25519_verify_detached(const(ubyte)* sig, const(ubyte)* m, ulong mlen, const(ubyte)* pk);
	int crypto_sign_ed25519_keypair(ubyte* pk, ubyte* sk);
	int crypto_sign_ed25519_seed_keypair(ubyte* pk, ubyte* sk, const(ubyte)* seed);
	int crypto_sign_ed25519_pk_to_curve25519(ubyte* curve25519_pk, const(ubyte)* ed25519_pk);
	int crypto_sign_ed25519_sk_to_curve25519(ubyte* curve25519_sk, const(ubyte)* ed25519_sk);
	int crypto_sign_ed25519_sk_to_seed(ubyte* seed, const(ubyte)* sk);
	int crypto_sign_ed25519_sk_to_pk(ubyte* pk, const(ubyte)* sk);
}
