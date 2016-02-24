// D import file generated from 'crypto_verify_64.d' renamed to 'crypto_verify_64.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_verify_64;

extern (C) 
{
	enum crypto_verify_64_BYTES = 64u;
	size_t crypto_verify_64_bytes();
	int crypto_verify_64(const(ubyte)* x, const(ubyte)* y);
}
