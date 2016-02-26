/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

// D import file generated from 'crypto_stream_xsalsa20.d' renamed to 'crypto_stream_xsalsa20.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_stream_xsalsa20;

extern (C) 
{
	enum crypto_stream_xsalsa20_KEYBYTES = 32u;
	size_t crypto_stream_xsalsa20_keybytes();
	enum crypto_stream_xsalsa20_NONCEBYTES = 24u;
	size_t crypto_stream_xsalsa20_noncebytes();
	int crypto_stream_xsalsa20(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_xsalsa20_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_xsalsa20_xor_ic(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, ulong ic, const(ubyte)* k);
}
