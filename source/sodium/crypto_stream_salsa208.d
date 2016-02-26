/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

// D import file generated from 'crypto_stream_salsa208.d' renamed to 'crypto_stream_salsa208.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_stream_salsa208;
extern (C) 
{
	enum crypto_stream_salsa208_KEYBYTES = 32u;
	size_t crypto_stream_salsa208_keybytes();
	enum crypto_stream_salsa208_NONCEBYTES = 8u;
	size_t crypto_stream_salsa208_noncebytes();
	int crypto_stream_salsa208(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_salsa208_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
}
