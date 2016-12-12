// D import file generated from 'crypto_auth_hmacsha512256.d' renamed to 'crypto_auth_hmacsha512256.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_auth_hmacsha512256;

import sodium.crypto_auth_hmacsha512;

extern (C) 
{
	enum crypto_auth_hmacsha512256_BYTES = 32u;
	size_t crypto_auth_hmacsha512256_bytes();
	enum crypto_auth_hmacsha512256_KEYBYTES = 32u;
	size_t crypto_auth_hmacsha512256_keybytes();
	int crypto_auth_hmacsha512256(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_auth_hmacsha512256_verify(const(ubyte)* h, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	alias crypto_auth_hmacsha512256_state = crypto_auth_hmacsha512_state;
	size_t crypto_auth_hmacsha512256_statebytes();
	int crypto_auth_hmacsha512256_init(crypto_auth_hmacsha512256_state* state, const(ubyte)* key, size_t keylen);
	int crypto_auth_hmacsha512256_update(crypto_auth_hmacsha512256_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_auth_hmacsha512256_final(crypto_auth_hmacsha512256_state* state, ubyte* out_);
}
