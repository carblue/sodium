// D import file generated from 'crypto_stream_salsa2012.d' renamed to 'crypto_stream_salsa2012.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_stream_salsa2012;

extern (C) 
{
	enum crypto_stream_salsa2012_KEYBYTES = 32u;
	size_t crypto_stream_salsa2012_keybytes();
	enum crypto_stream_salsa2012_NONCEBYTES = 8u;
	size_t crypto_stream_salsa2012_noncebytes();
	int crypto_stream_salsa2012(ubyte* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_salsa2012_xor(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
}
