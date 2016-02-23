// D import file generated from 'crypto_auth_hmacsha512.d' renamed to 'crypto_auth_hmacsha512.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_auth_hmacsha512;

import sodium.crypto_hash_sha512;
extern (C) 
{
	enum crypto_auth_hmacsha512_BYTES = 64u;
	size_t crypto_auth_hmacsha512_bytes();
	enum crypto_auth_hmacsha512_KEYBYTES = 32u;
	size_t crypto_auth_hmacsha512_keybytes();
	int crypto_auth_hmacsha512(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_auth_hmacsha512_verify(const(ubyte)* h, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	struct crypto_auth_hmacsha512_state
	{
		crypto_hash_sha512_state ictx;
		crypto_hash_sha512_state octx;
	}
	size_t crypto_auth_hmacsha512_statebytes();
	int crypto_auth_hmacsha512_init(crypto_auth_hmacsha512_state* state, const(ubyte)* key, size_t keylen);
	int crypto_auth_hmacsha512_update(crypto_auth_hmacsha512_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_auth_hmacsha512_final(crypto_auth_hmacsha512_state* state, ubyte* out_);
}
