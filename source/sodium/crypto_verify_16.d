// D import file generated from 'crypto_verify_16.d' renamed to 'crypto_verify_16.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_verify_16;

extern (C) 
{
	enum crypto_verify_16_BYTES = 16u;
	size_t crypto_verify_16_bytes();
	int crypto_verify_16(const(ubyte)* x, const(ubyte)* y);
}
