// D import file generated from 'crypto_generichash.d' renamed to 'crypto_generichash.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_generichash;

import sodium.crypto_generichash_blake2b;

extern (C) 
{
	enum crypto_generichash_BYTES_MIN = crypto_generichash_blake2b_BYTES_MIN;
	size_t crypto_generichash_bytes_min();
	enum crypto_generichash_BYTES_MAX = crypto_generichash_blake2b_BYTES_MAX;
	size_t crypto_generichash_bytes_max();
	enum crypto_generichash_BYTES = crypto_generichash_blake2b_BYTES;
	size_t crypto_generichash_bytes();
	enum crypto_generichash_KEYBYTES_MIN = crypto_generichash_blake2b_KEYBYTES_MIN;
	size_t crypto_generichash_keybytes_min();
	enum crypto_generichash_KEYBYTES_MAX = crypto_generichash_blake2b_KEYBYTES_MAX;
	size_t crypto_generichash_keybytes_max();
	enum crypto_generichash_KEYBYTES = crypto_generichash_blake2b_KEYBYTES;
	size_t crypto_generichash_keybytes();
	immutable(char*) crypto_generichash_PRIMITIVE = "blake2b";
	const(char)* crypto_generichash_primitive();
	alias crypto_generichash_state = crypto_generichash_blake2b_state;
	size_t crypto_generichash_statebytes();
	int crypto_generichash(ubyte* out_, size_t outlen, const(ubyte)* in_, ulong inlen, const(ubyte)* key, size_t keylen);
	int crypto_generichash_init(crypto_generichash_state* state, const(ubyte)* key, const size_t keylen, const size_t outlen);
	int crypto_generichash_update(crypto_generichash_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_generichash_final(crypto_generichash_state* state, ubyte* out_, const size_t outlen);
}
