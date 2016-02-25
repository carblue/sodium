// D import file generated from 'crypto_scalarmult_curve25519.d' renamed to 'crypto_scalarmult_curve25519.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_scalarmult_curve25519;

extern (C) 
{
	enum crypto_scalarmult_curve25519_BYTES = 32u;
	size_t crypto_scalarmult_curve25519_bytes();
	enum crypto_scalarmult_curve25519_SCALARBYTES = 32u;
	size_t crypto_scalarmult_curve25519_scalarbytes();
	int crypto_scalarmult_curve25519(ubyte* q, const(ubyte)* n, const(ubyte)* p);
	int crypto_scalarmult_curve25519_base(ubyte* q, const(ubyte)* n);
	int _crypto_scalarmult_curve25519_pick_best_implementation();
}
