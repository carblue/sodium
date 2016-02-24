// D import file generated from 'crypto_onetimeauth.d' renamed to 'crypto_onetimeauth.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_onetimeauth;

import sodium.crypto_onetimeauth_poly1305;

extern (C) 
{
	alias crypto_onetimeauth_state = crypto_onetimeauth_poly1305_state;
	size_t crypto_onetimeauth_statebytes();
	enum crypto_onetimeauth_BYTES = crypto_onetimeauth_poly1305_BYTES;
	size_t crypto_onetimeauth_bytes();
	enum crypto_onetimeauth_KEYBYTES = crypto_onetimeauth_poly1305_KEYBYTES;
	size_t crypto_onetimeauth_keybytes();
	immutable(char*) crypto_onetimeauth_PRIMITIVE = "poly1305";
	const(char)* crypto_onetimeauth_primitive();
	int crypto_onetimeauth(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_onetimeauth_verify(const(ubyte)* h, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_onetimeauth_init(crypto_onetimeauth_state* state, const(ubyte)* key);
	int crypto_onetimeauth_update(crypto_onetimeauth_state* state, const(ubyte)* in_, ulong inlen);
	int crypto_onetimeauth_final(crypto_onetimeauth_state* state, ubyte* out_);
}
