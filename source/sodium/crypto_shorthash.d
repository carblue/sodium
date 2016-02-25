// D import file generated from 'crypto_shorthash.d' renamed to 'crypto_shorthash.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_shorthash;

import sodium.crypto_shorthash_siphash24;

extern (C) 
{
	enum crypto_shorthash_BYTES = crypto_shorthash_siphash24_BYTES;
	size_t crypto_shorthash_bytes();
	enum crypto_shorthash_KEYBYTES = crypto_shorthash_siphash24_KEYBYTES;
	size_t crypto_shorthash_keybytes();
	immutable(char*) crypto_shorthash_PRIMITIVE = "siphash24";
	const(char)* crypto_shorthash_primitive();
	int crypto_shorthash(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
}
