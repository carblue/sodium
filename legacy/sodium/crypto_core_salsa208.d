// D import file generated from 'crypto_core_salsa208.d' renamed to 'crypto_core_salsa208.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_core_salsa208;

extern (C) 
{
	enum crypto_core_salsa208_OUTPUTBYTES = 64u;
	size_t crypto_core_salsa208_outputbytes();
	enum crypto_core_salsa208_INPUTBYTES = 16u;
	size_t crypto_core_salsa208_inputbytes();
	enum crypto_core_salsa208_KEYBYTES = 32u;
	size_t crypto_core_salsa208_keybytes();
	enum crypto_core_salsa208_CONSTBYTES = 16u;
	size_t crypto_core_salsa208_constbytes();
	int crypto_core_salsa208(ubyte* out_, const(ubyte)* in_, const(ubyte)* k, const(ubyte)* c);
}
