// D import file generated from 'runtime.d' renamed to 'runtime.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.runtime;

extern (C) 
{
	int sodium_runtime_has_neon();
	int sodium_runtime_has_sse2();
	int sodium_runtime_has_sse3();
	int sodium_runtime_has_ssse3();
	int sodium_runtime_has_sse41();
	int sodium_runtime_has_avx();
	int sodium_runtime_has_pclmul();
	int sodium_runtime_has_aesni();
	int _sodium_runtime_get_cpu_features();
}
