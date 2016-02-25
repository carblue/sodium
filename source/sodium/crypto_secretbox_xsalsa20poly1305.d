// D import file generated from 'crypto_secretbox_xsalsa20poly1305.d' renamed to 'crypto_secretbox_xsalsa20poly1305.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_secretbox_xsalsa20poly1305;

extern (C) 
{
	enum crypto_secretbox_xsalsa20poly1305_KEYBYTES = 32u;
	size_t crypto_secretbox_xsalsa20poly1305_keybytes();
	enum crypto_secretbox_xsalsa20poly1305_NONCEBYTES = 24u;
	size_t crypto_secretbox_xsalsa20poly1305_noncebytes();
	enum crypto_secretbox_xsalsa20poly1305_ZEROBYTES = 32u;
	size_t crypto_secretbox_xsalsa20poly1305_zerobytes();
	enum crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES = 16u;
	size_t crypto_secretbox_xsalsa20poly1305_boxzerobytes();
	enum crypto_secretbox_xsalsa20poly1305_MACBYTES = crypto_secretbox_xsalsa20poly1305_ZEROBYTES - crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES;
	size_t crypto_secretbox_xsalsa20poly1305_macbytes();
	int crypto_secretbox_xsalsa20poly1305(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_secretbox_xsalsa20poly1305_open(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
}
