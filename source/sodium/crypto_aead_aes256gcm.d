// D import file generated from 'crypto_aead_aes256gcm.d' renamed to 'crypto_aead_aes256gcm.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_aead_aes256gcm;

extern (C) 
{
	int crypto_aead_aes256gcm_is_available();
	enum crypto_aead_aes256gcm_KEYBYTES = 32u;
	size_t crypto_aead_aes256gcm_keybytes();
	enum crypto_aead_aes256gcm_NSECBYTES = 0u;
	size_t crypto_aead_aes256gcm_nsecbytes();
	enum crypto_aead_aes256gcm_NPUBBYTES = 12u;
	size_t crypto_aead_aes256gcm_npubbytes();
	enum crypto_aead_aes256gcm_ABYTES = 16u;
	size_t crypto_aead_aes256gcm_abytes();
	alias crypto_aead_aes256gcm_state = ubyte[512];
	size_t crypto_aead_aes256gcm_statebytes();
	int crypto_aead_aes256gcm_encrypt(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(ubyte)* k);
	int crypto_aead_aes256gcm_decrypt(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(ubyte)* k) pure nothrow @nogc @safe;
	int crypto_aead_aes256gcm_beforenm(crypto_aead_aes256gcm_state* ctx_, const(ubyte)* k);
	int crypto_aead_aes256gcm_encrypt_afternm(ubyte* c, ulong* clen_p, const(ubyte)* m, ulong mlen, const(ubyte)* ad, ulong adlen, const(ubyte)* nsec, const(ubyte)* npub, const(crypto_aead_aes256gcm_state)* ctx_);
	int crypto_aead_aes256gcm_decrypt_afternm(ubyte* m, ulong* mlen_p, ubyte* nsec, const(ubyte)* c, ulong clen, const(ubyte)* ad, ulong adlen, const(ubyte)* npub, const(crypto_aead_aes256gcm_state)* ctx_) pure nothrow @nogc @safe;
}
