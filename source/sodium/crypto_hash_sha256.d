// D import file generated from 'crypto_hash_sha256.d' renamed to 'crypto_hash_sha256.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 * WARNING: Unless you absolutely need to use SHA256 for interoperatibility,
 * purposes, you might want to consider crypto_generichash() instead.
 * Unlike SHA256, crypto_generichash() is not vulnerable to length
 * extension attacks.
 */

module sodium.crypto_hash_sha256;

extern (C) 
{
	struct crypto_hash_sha256_state
	{
		uint[8] state;
		ulong[2] count;
		ubyte[64] buf;
	}
	size_t crypto_hash_sha256_statebytes();
	immutable crypto_hash_sha256_BYTES = 32u;
	size_t crypto_hash_sha256_bytes();
	int crypto_hash_sha256(ubyte* out_, const(ubyte)* in_, ulong inlen);
	int crypto_hash_sha256_init(crypto_hash_sha256_state* state);
	int crypto_hash_sha256_update(crypto_hash_sha256_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_hash_sha256_final(crypto_hash_sha256_state* state, ubyte* out_);
}
