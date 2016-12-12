/*
 *  WARNING: This is just a stream cipher. It is NOT authenticated encryption.
 *  While it provides some protection against eavesdropping, it does NOT
 *  provide any security against active attacks.
 *  Unless you know what you're doing, what you are looking for is probably
 *  the crypto_box functions.
 */

// D import file generated from 'crypto_stream_aes128ctr.d'

module sodium.crypto_stream_aes128ctr;

extern (C) 
{
	enum crypto_stream_aes128ctr_KEYBYTES = 16u;
	size_t crypto_stream_aes128ctr_keybytes();
	enum crypto_stream_aes128ctr_NONCEBYTES = 16u;
	size_t crypto_stream_aes128ctr_noncebytes();
	enum crypto_stream_aes128ctr_BEFORENMBYTES = 1408u;
	size_t crypto_stream_aes128ctr_beforenmbytes();
	int crypto_stream_aes128ctr(ubyte* out_, ulong outlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_aes128ctr_xor(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* n, const(ubyte)* k);
	int crypto_stream_aes128ctr_beforenm(ubyte* c, const(ubyte)* k);
	int crypto_stream_aes128ctr_afternm(ubyte* out_, ulong len, const(ubyte)* nonce, const(ubyte)* c);
	int crypto_stream_aes128ctr_xor_afternm(ubyte* out_, const(ubyte)* in_, ulong len, const(ubyte)* nonce, const(ubyte)* c);
}
