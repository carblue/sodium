module sodium.crypto_aead_aes256gcm;

extern (C) 
{
	int crypto_aead_aes256gcm_is_available() pure @nogc @safe;

	enum crypto_aead_aes256gcm_KEYBYTES = 32u;
	size_t crypto_aead_aes256gcm_keybytes() pure @nogc @safe;

	enum crypto_aead_aes256gcm_NSECBYTES = 0u;
	size_t crypto_aead_aes256gcm_nsecbytes() pure @nogc @safe;

	enum crypto_aead_aes256gcm_NPUBBYTES = 12u;
	size_t crypto_aead_aes256gcm_npubbytes() pure @nogc @safe;

	enum crypto_aead_aes256gcm_ABYTES = 16u;
	size_t crypto_aead_aes256gcm_abytes() pure @nogc @safe;

	alias  crypto_aead_aes256gcm_state = align(16) ubyte[512];
	size_t crypto_aead_aes256gcm_statebytes() pure @nogc @safe;

	int crypto_aead_aes256gcm_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k) pure @nogc @safe;

	int crypto_aead_aes256gcm_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k) pure nothrow @nogc @safe;


	int crypto_aead_aes256gcm_encrypt_detached(ubyte* c,
	                                           ubyte* mac,
	                                           ulong* maclen_p,
	                                           const(ubyte)* m,
	                                           ulong mlen,
	                                           const(ubyte)* ad,
	                                           ulong adlen,
	                                           const(ubyte)* nsec,
	                                           const(ubyte)* npub,
	                                           const(ubyte)* k) pure @nogc @safe;

	int crypto_aead_aes256gcm_decrypt_detached(ubyte *m,
	                                           ubyte *nsec,
	                                           const(ubyte)* c,
	                                           ulong clen,
	                                           const(ubyte)* mac,
	                                           const(ubyte)* ad,
	                                           ulong adlen,
	                                           const(ubyte)* npub,
	                                           const(ubyte)* k) pure nothrow @nogc @safe;

/* -- Precomputation interface -- */

	int crypto_aead_aes256gcm_beforenm(crypto_aead_aes256gcm_state* ctx_, const(ubyte)* k) pure @nogc @safe;

	int crypto_aead_aes256gcm_encrypt_afternm(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(crypto_aead_aes256gcm_state)* ctx_) pure @nogc @safe;

	int crypto_aead_aes256gcm_decrypt_afternm(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(crypto_aead_aes256gcm_state)* ctx_) pure nothrow @nogc @safe;

	int crypto_aead_aes256gcm_encrypt_detached_afternm(ubyte* c,
	                                                   ubyte* mac,
	                                                   ulong* maclen_p,
	                                                   const(ubyte)* m,
	                                                   ulong mlen,
	                                                   const(ubyte)* ad,
	                                                   ulong adlen,
	                                                   const(ubyte)* nsec,
	                                                   const(ubyte)* npub,
	                                                   const(crypto_aead_aes256gcm_state)* ctx_) pure @nogc @safe;

	int crypto_aead_aes256gcm_decrypt_detached_afternm(ubyte* m,
	                                                   ubyte* nsec,
	                                                   const(ubyte)* c,
	                                                   ulong clen,
	                                                   const(ubyte)* mac,
	                                                   const(ubyte)* ad,
	                                                   ulong adlen,
	                                                   const(ubyte)* npub,
	                                                   const(crypto_aead_aes256gcm_state)* ctx_) pure nothrow @nogc @safe;

}
