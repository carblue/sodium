// D import file generated from 'crypto_aead_chacha20poly1305.d' renamed to 'crypto_aead_chacha20poly1305.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_aead_chacha20poly1305;

extern (C) 
{
	enum crypto_aead_chacha20poly1305_KEYBYTES = 32u;
	size_t crypto_aead_chacha20poly1305_keybytes();
	enum crypto_aead_chacha20poly1305_NSECBYTES = 0u;
	size_t crypto_aead_chacha20poly1305_nsecbytes();
	enum crypto_aead_chacha20poly1305_NPUBBYTES = 8u;
	size_t crypto_aead_chacha20poly1305_npubbytes();
	enum crypto_aead_chacha20poly1305_ABYTES = 16u;
	size_t crypto_aead_chacha20poly1305_abytes();
	int crypto_aead_chacha20poly1305_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	int crypto_aead_chacha20poly1305_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
	enum crypto_aead_chacha20poly1305_IETF_NPUBBYTES = 12u;
	size_t crypto_aead_chacha20poly1305_ietf_npubbytes();
	int crypto_aead_chacha20poly1305_ietf_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	int crypto_aead_chacha20poly1305_ietf_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
}
