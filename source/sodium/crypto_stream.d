/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

// D import file generated from 'crypto_stream.d' renamed to 'crypto_stream.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_stream;
import sodium.crypto_stream_xsalsa20;
extern (C) 
{
	enum crypto_stream_KEYBYTES = crypto_stream_xsalsa20_KEYBYTES;
	size_t crypto_stream_keybytes();
	enum crypto_stream_NONCEBYTES = crypto_stream_xsalsa20_NONCEBYTES;
	size_t crypto_stream_noncebytes();
	immutable(char*) crypto_stream_PRIMITIVE = "xsalsa20";
	const(char)* crypto_stream_primitive();
	int crypto_stream(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
}
