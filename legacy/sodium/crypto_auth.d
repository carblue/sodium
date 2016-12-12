module sodium.crypto_auth;

import sodium.crypto_auth_hmacsha512256;

extern (C)
{
	enum crypto_auth_BYTES = crypto_auth_hmacsha512256_BYTES;
	size_t crypto_auth_bytes();

	enum crypto_auth_KEYBYTES = crypto_auth_hmacsha512256_KEYBYTES;
	size_t crypto_auth_keybytes();

	immutable(char*) crypto_auth_PRIMITIVE = "hmacsha512256";
	const(char)* crypto_auth_primitive();

	int crypto_auth(ubyte* out_, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
	int crypto_auth_verify(const(ubyte)* h, const(ubyte)* in_, ulong inlen, const(ubyte)* k);
}
