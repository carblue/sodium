// D import file generated from 'crypto_hash_sha512.d' renamed to 'crypto_hash_sha512.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 * WARNING: Unless you absolutely need to use SHA512 for interoperatibility,
 * purposes, you might want to consider crypto_generichash() instead.
 * Unlike SHA512, crypto_generichash() is not vulnerable to length
 * extension attacks.
 */

module sodium.crypto_hash_sha512;
extern (C) 
{
	struct crypto_hash_sha512_state
	{
		ulong[8] state;
		ulong[2] count;
		ubyte[128] buf;
	}
	size_t crypto_hash_sha512_statebytes();
	enum crypto_hash_sha512_BYTES = 64u;
	size_t crypto_hash_sha512_bytes();
	int crypto_hash_sha512(ubyte* out_, const(ubyte)* in_, ulong inlen);
	int crypto_hash_sha512_init(crypto_hash_sha512_state* state);
	int crypto_hash_sha512_update(crypto_hash_sha512_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_hash_sha512_final(crypto_hash_sha512_state* state, ubyte* out_);
}
