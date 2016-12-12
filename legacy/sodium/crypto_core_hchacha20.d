// D import file generated from 'crypto_core_hchacha20.d' renamed to 'crypto_core_hchacha20.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_core_hchacha20;

extern (C) 
{
	enum crypto_core_hchacha20_OUTPUTBYTES = 32u;
	size_t crypto_core_hchacha20_outputbytes();
	enum crypto_core_hchacha20_INPUTBYTES = 16u;
	size_t crypto_core_hchacha20_inputbytes();
	enum crypto_core_hchacha20_KEYBYTES = 32u;
	size_t crypto_core_hchacha20_keybytes();
	enum crypto_core_hchacha20_CONSTBYTES = 16u;
	size_t crypto_core_hchacha20_constbytes();
	int crypto_core_hchacha20(ubyte* out_, const(ubyte)* in_, const(ubyte)* k, const(ubyte)* c);
}
