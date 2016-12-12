// D import file generated from 'crypto_box_curve25519xsalsa20poly1305.d' renamed to 'crypto_box_curve25519xsalsa20poly1305.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_box_curve25519xsalsa20poly1305;

extern (C) 
{
	enum crypto_box_curve25519xsalsa20poly1305_SEEDBYTES = 32u;
	size_t crypto_box_curve25519xsalsa20poly1305_seedbytes();
	enum crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES = 32u;
	size_t crypto_box_curve25519xsalsa20poly1305_publickeybytes();
	enum crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES = 32u;
	size_t crypto_box_curve25519xsalsa20poly1305_secretkeybytes();
	enum crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES = 32u;
	size_t crypto_box_curve25519xsalsa20poly1305_beforenmbytes();
	enum crypto_box_curve25519xsalsa20poly1305_NONCEBYTES = 24u;
	size_t crypto_box_curve25519xsalsa20poly1305_noncebytes();
	enum crypto_box_curve25519xsalsa20poly1305_MACBYTES = 16u;
	size_t crypto_box_curve25519xsalsa20poly1305_macbytes();
	enum crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES = 16u;
	size_t crypto_box_curve25519xsalsa20poly1305_boxzerobytes();
	enum crypto_box_curve25519xsalsa20poly1305_ZEROBYTES = crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES + crypto_box_curve25519xsalsa20poly1305_MACBYTES;
	size_t crypto_box_curve25519xsalsa20poly1305_zerobytes();
	int crypto_box_curve25519xsalsa20poly1305(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_curve25519xsalsa20poly1305_open(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_curve25519xsalsa20poly1305_seed_keypair(ubyte* pk, ubyte* sk, const(ubyte)* seed);
	int crypto_box_curve25519xsalsa20poly1305_keypair(ubyte* pk, ubyte* sk);
	int crypto_box_curve25519xsalsa20poly1305_beforenm(ubyte* k, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_curve25519xsalsa20poly1305_afternm(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_box_curve25519xsalsa20poly1305_open_afternm(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
}
