// D import file generated from 'crypto_verify_32.d' renamed to 'crypto_verify_32.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_verify_32;

extern (C) 
{
	enum crypto_verify_32_BYTES = 32u;
	size_t crypto_verify_32_bytes();
	int crypto_verify_32(const(ubyte)* x, const(ubyte)* y);
}
