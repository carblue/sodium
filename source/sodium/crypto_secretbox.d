// D import file generated from 'crypto_secretbox.d' renamed to 'crypto_secretbox.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_secretbox;

import sodium.crypto_secretbox_xsalsa20poly1305;

extern (C) 
{
	enum crypto_secretbox_KEYBYTES = crypto_secretbox_xsalsa20poly1305_KEYBYTES;
	size_t crypto_secretbox_keybytes();
	enum crypto_secretbox_NONCEBYTES = crypto_secretbox_xsalsa20poly1305_NONCEBYTES;
	size_t crypto_secretbox_noncebytes();
	enum crypto_secretbox_MACBYTES = crypto_secretbox_xsalsa20poly1305_MACBYTES;
	size_t crypto_secretbox_macbytes();
	immutable(char*) crypto_secretbox_PRIMITIVE = "xsalsa20poly1305";
	const(char)* crypto_secretbox_primitive();
	int crypto_secretbox_easy(ubyte* c, const ubyte* m, ulong mlen, const ubyte* n, const ubyte* k);
	int crypto_secretbox_open_easy(ubyte* m, const ubyte* c, ulong clen, const ubyte* n, const ubyte* k);
	int crypto_secretbox_detached(ubyte* c, ubyte* mac, const ubyte* m, ulong mlen, const ubyte* n, const ubyte* k);
	int crypto_secretbox_open_detached(ubyte* m, const ubyte* c, const ubyte* mac, ulong clen, const ubyte* n, const ubyte* k);
	enum crypto_secretbox_ZEROBYTES = crypto_secretbox_xsalsa20poly1305_ZEROBYTES;
	size_t crypto_secretbox_zerobytes();
	enum crypto_secretbox_BOXZEROBYTES = crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES;
	size_t crypto_secretbox_boxzerobytes();
	int crypto_secretbox(ubyte* c, const ubyte* m, ulong mlen, const ubyte* n, const ubyte* k);
	int crypto_secretbox_open(ubyte* m, const ubyte* c, ulong clen, const ubyte* n, const ubyte* k);
}
