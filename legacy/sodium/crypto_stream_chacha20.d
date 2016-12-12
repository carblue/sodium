// D import file generated from 'crypto_stream_chacha20.d' renamed to 'crypto_stream_chacha20.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

module sodium.crypto_stream_chacha20;

extern (C) 
{
	enum crypto_stream_chacha20_KEYBYTES = 32u;
	size_t crypto_stream_chacha20_keybytes();
	enum crypto_stream_chacha20_NONCEBYTES = 8u;
	size_t crypto_stream_chacha20_noncebytes();
	int crypto_stream_chacha20(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_chacha20_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_chacha20_xor_ic(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, ulong ic, const(ubyte)* k);
	enum crypto_stream_chacha20_IETF_NONCEBYTES = 12u;
	size_t crypto_stream_chacha20_ietf_noncebytes();
	int crypto_stream_chacha20_ietf(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_chacha20_ietf_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_chacha20_ietf_xor_ic(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, uint ic, const(ubyte)* k);

//  int _crypto_stream_chacha20_pick_best_implementation();
}
