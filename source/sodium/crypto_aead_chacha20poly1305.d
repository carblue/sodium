module sodium.crypto_aead_chacha20poly1305;

extern (C) 
{
	enum crypto_aead_chacha20poly1305_KEYBYTES = 32u;
	size_t crypto_aead_chacha20poly1305_keybytes() pure @nogc @safe;

	enum crypto_aead_chacha20poly1305_NSECBYTES = 0u;
	size_t crypto_aead_chacha20poly1305_nsecbytes() pure @nogc @safe;

	enum crypto_aead_chacha20poly1305_NPUBBYTES = 8u;
	size_t crypto_aead_chacha20poly1305_npubbytes() pure @nogc @safe;

	enum crypto_aead_chacha20poly1305_ABYTES = 16u;
	size_t crypto_aead_chacha20poly1305_abytes() pure @nogc @safe;

	int crypto_aead_chacha20poly1305_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k) pure @nogc @safe;
	int crypto_aead_chacha20poly1305_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k) pure nothrow @nogc @safe;

	enum crypto_aead_chacha20poly1305_IETF_NPUBBYTES = 12u;
	size_t crypto_aead_chacha20poly1305_ietf_npubbytes() pure @nogc @safe;

	int crypto_aead_chacha20poly1305_ietf_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k) pure @nogc @safe;
	int crypto_aead_chacha20poly1305_ietf_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k) pure nothrow @nogc @safe;
}
