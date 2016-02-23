// D import file generated from 'utils.d' renamed to 'utils.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.utils;

extern (C) 
{
	void sodium_memzero(const(void*) pnt, const size_t len);
	int sodium_memcmp(const(void*) b1_, const(void*) b2_, size_t len);
	int sodium_compare(const(ubyte)* b1_, const(ubyte)* b2_, size_t len);
	int sodium_is_zero(const(ubyte)* n, const size_t nlen);
	void sodium_increment(ubyte* n, const size_t nlen);
	void sodium_add(ubyte* a, const(ubyte)* b, const size_t len);
	char* sodium_bin2hex(const(char*) hex, const size_t hex_maxlen, const(ubyte*) bin, const size_t bin_len);
	int sodium_hex2bin(const(ubyte)* bin, const size_t bin_maxlen, const(char*) hex, const size_t hex_len, const(char*) ignore, const(size_t*) bin_len, const(char**) hex_end);
	int sodium_mlock(const(void*) addr, const size_t len);
	int sodium_munlock(const(void*) addr, const size_t len);
	void* sodium_malloc(const size_t size);
	void* sodium_allocarray(size_t count, size_t size);
	void sodium_free(void* ptr);
	int sodium_mprotect_noaccess(void* ptr);
	int sodium_mprotect_readonly(void* ptr);
	int sodium_mprotect_readwrite(void* ptr);
}
