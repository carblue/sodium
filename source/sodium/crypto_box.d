// D import file generated from 'crypto_box.d' renamed to 'crypto_box.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

/*
 * THREAD SAFETY: crypto_box_keypair() is thread-safe,
 * provided that you called sodium_init() once before using any
 * other libsodium function.
 * Other functions are always thread-safe.
 */

module sodium.crypto_box;

import sodium.crypto_box_curve25519xsalsa20poly1305;

extern (C) 
{
	enum crypto_box_SEEDBYTES = crypto_box_curve25519xsalsa20poly1305_SEEDBYTES;
	size_t crypto_box_seedbytes();
	enum crypto_box_PUBLICKEYBYTES = crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES;
	size_t crypto_box_publickeybytes();
	enum crypto_box_SECRETKEYBYTES = crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES;
	size_t crypto_box_secretkeybytes();
	enum crypto_box_NONCEBYTES = crypto_box_curve25519xsalsa20poly1305_NONCEBYTES;
	size_t crypto_box_noncebytes();
	enum crypto_box_MACBYTES = crypto_box_curve25519xsalsa20poly1305_MACBYTES;
	size_t crypto_box_macbytes();
	immutable(char*) crypto_box_PRIMITIVE = "curve25519xsalsa20poly1305";
	const(char)* crypto_box_primitive();
	int crypto_box_seed_keypair(ubyte* pk, ubyte* sk, const(ubyte)* seed);
	int crypto_box_keypair(ubyte* pk, ubyte* sk);
	int crypto_box_easy(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_open_easy(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_detached(ubyte* c, ubyte* mac, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_open_detached(ubyte* m, const(ubyte)* c, const(ubyte)* mac, ulong clen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	alias crypto_box_BEFORENMBYTES = crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES;
	size_t crypto_box_beforenmbytes();
	int crypto_box_beforenm(ubyte* k, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_easy_afternm(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_box_open_easy_afternm(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
	int crypto_box_detached_afternm(ubyte* c, ubyte* mac, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_box_open_detached_afternm(ubyte* m, const(ubyte)* c, const(ubyte)* mac, ulong clen, const(ubyte)* n, const(ubyte)* k);
	enum crypto_box_SEALBYTES = crypto_box_PUBLICKEYBYTES + crypto_box_MACBYTES;
	size_t crypto_box_sealbytes();
	int crypto_box_seal(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* pk);
	int crypto_box_seal_open(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* pk, const(ubyte)* sk);
	enum crypto_box_ZEROBYTES = crypto_box_curve25519xsalsa20poly1305_ZEROBYTES;
	size_t crypto_box_zerobytes();
	enum crypto_box_BOXZEROBYTES = crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES;
	size_t crypto_box_boxzerobytes();
	int crypto_box(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_open(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* pk, const(ubyte)* sk);
	int crypto_box_afternm(ubyte* c, const(ubyte)* m, ulong mlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_box_open_afternm(ubyte* m, const(ubyte)* c, ulong clen, const(ubyte)* n, const(ubyte)* k);
}
