// D import file generated from 'crypto_core_salsa2012.d' renamed to 'crypto_core_salsa2012.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_core_salsa2012;

extern (C) 
{
	enum crypto_core_salsa2012_OUTPUTBYTES = 64u;
	size_t crypto_core_salsa2012_outputbytes();
	enum crypto_core_salsa2012_INPUTBYTES = 16u;
	size_t crypto_core_salsa2012_inputbytes();
	enum crypto_core_salsa2012_KEYBYTES = 32u;
	size_t crypto_core_salsa2012_keybytes();
	enum crypto_core_salsa2012_CONSTBYTES = 16u;
	size_t crypto_core_salsa2012_constbytes();
	int crypto_core_salsa2012(ubyte* out_, const(ubyte)* in_, const(ubyte)* k, const(ubyte)* c);
}
