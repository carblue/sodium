// D import file generated from 'crypto_onetimeauth_poly1305.d' renamed to 'crypto_onetimeauth_poly1305.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_onetimeauth_poly1305;
extern (C) 
{
	align (16)struct crypto_onetimeauth_poly1305_state
	{
		ubyte[256] opaque;
	}
	enum crypto_onetimeauth_poly1305_BYTES = 16u;
	size_t crypto_onetimeauth_poly1305_bytes();
	enum crypto_onetimeauth_poly1305_KEYBYTES = 32u;
	size_t crypto_onetimeauth_poly1305_keybytes();
	int crypto_onetimeauth_poly1305(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_onetimeauth_poly1305_verify(const(ubyte)* h, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_onetimeauth_poly1305_init(crypto_onetimeauth_poly1305_state* state, const(ubyte)* key);
	int crypto_onetimeauth_poly1305_update(crypto_onetimeauth_poly1305_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_onetimeauth_poly1305_final(crypto_onetimeauth_poly1305_state* state, ubyte* out_);
	int _crypto_onetimeauth_poly1305_pick_best_implementation();
}
