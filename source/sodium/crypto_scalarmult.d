// D import file generated from 'crypto_scalarmult.d' renamed to 'crypto_scalarmult.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_scalarmult;

import sodium.crypto_scalarmult_curve25519;

extern (C) 
{
	enum crypto_scalarmult_BYTES = crypto_scalarmult_curve25519_BYTES;
	size_t crypto_scalarmult_bytes();
	enum crypto_scalarmult_SCALARBYTES = crypto_scalarmult_curve25519_SCALARBYTES;
	size_t crypto_scalarmult_scalarbytes();
	immutable(char*) crypto_scalarmult_PRIMITIVE = "curve25519";
	const(char)* crypto_scalarmult_primitive();
	int crypto_scalarmult_base(ubyte* q, const(ubyte)* n);
	int crypto_scalarmult(ubyte* q, const(ubyte)* n, const(ubyte)* p);
}
