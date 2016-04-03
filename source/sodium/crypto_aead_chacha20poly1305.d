// D import file generated from 'crypto_aead_chacha20poly1305.d' renamed to 'crypto_aead_chacha20poly1305.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_aead_chacha20poly1305;

extern (C) 
{
	enum crypto_aead_chacha20poly1305_ietf_KEYBYTES = 32u;
	size_t crypto_aead_chacha20poly1305_ietf_keybytes();
	enum crypto_aead_chacha20poly1305_ietf_NSECBYTES = 0u;
	size_t crypto_aead_chacha20poly1305_ietf_nsecbytes();
	enum crypto_aead_chacha20poly1305_ietf_NPUBBYTES = 12u;
	size_t crypto_aead_chacha20poly1305_ietf_npubbytes();
	enum crypto_aead_chacha20poly1305_ietf_ABYTES = 16u;
	size_t crypto_aead_chacha20poly1305_ietf_abytes();
	int crypto_aead_chacha20poly1305_ietf_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	pure nothrow @nogc @safe int crypto_aead_chacha20poly1305_ietf_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
	int crypto_aead_chacha20poly1305_ietf_encrypt_detached(ubyte* c, ubyte* mac, ulong* maclen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	pure nothrow @nogc @safe int crypto_aead_chacha20poly1305_ietf_decrypt_detached(ubyte* m, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* mac, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
	enum crypto_aead_chacha20poly1305_KEYBYTES = 32u;
	size_t crypto_aead_chacha20poly1305_keybytes();
	enum crypto_aead_chacha20poly1305_NSECBYTES = 0u;
	size_t crypto_aead_chacha20poly1305_nsecbytes();
	enum crypto_aead_chacha20poly1305_NPUBBYTES = 8u;
	size_t crypto_aead_chacha20poly1305_npubbytes();
	enum crypto_aead_chacha20poly1305_ABYTES = 16u;
	size_t crypto_aead_chacha20poly1305_abytes();
	int crypto_aead_chacha20poly1305_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	pure nothrow @nogc @safe int crypto_aead_chacha20poly1305_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
	int crypto_aead_chacha20poly1305_encrypt_detached(ubyte* c, ubyte* mac, ulong* maclen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	pure nothrow @nogc @safe int crypto_aead_chacha20poly1305_decrypt_detached(ubyte* m, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* mac, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k);
	alias crypto_aead_chacha20poly1305_IETF_KEYBYTES = crypto_aead_chacha20poly1305_ietf_KEYBYTES;
	alias crypto_aead_chacha20poly1305_IETF_NSECBYTES = crypto_aead_chacha20poly1305_ietf_NSECBYTES;
	alias crypto_aead_chacha20poly1305_IETF_NPUBBYTES = crypto_aead_chacha20poly1305_ietf_NPUBBYTES;
	alias crypto_aead_chacha20poly1305_IETF_ABYTES = crypto_aead_chacha20poly1305_ietf_ABYTES;
}
