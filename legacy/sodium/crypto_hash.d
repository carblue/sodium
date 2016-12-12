// D import file generated from 'crypto_hash.d' renamed to 'crypto_hash.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 * WARNING: Unless you absolutely need to use SHA512 for interoperatibility,
 * purposes, you might want to consider crypto_generichash() instead.
 * Unlike SHA512, crypto_generichash() is not vulnerable to length
 * extension attacks.
 */

module sodium.crypto_hash;

import sodium.crypto_hash_sha512;

extern (C) 
{
	enum crypto_hash_BYTES = crypto_hash_sha512_BYTES;
	size_t crypto_hash_bytes();
	int crypto_hash(ubyte* out_, const(ubyte)* in_, ulong inlen);
//	enum crypto_hash_PRIMITIVE = "sha512";
	immutable(char*) crypto_hash_PRIMITIVE = "sha512"; // a D-string, NOT C-nullterminated
	const(char)* crypto_hash_primitive();
}
