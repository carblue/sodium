// D import file generated from 'crypto_shorthash_siphash24.d' renamed to 'crypto_shorthash_siphash24.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_shorthash_siphash24;

extern (C) 
{
	enum crypto_shorthash_siphash24_BYTES = 8u;
	size_t crypto_shorthash_siphash24_bytes();
	enum crypto_shorthash_siphash24_KEYBYTES = 16u;
	size_t crypto_shorthash_siphash24_keybytes();
	int crypto_shorthash_siphash24(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
}
