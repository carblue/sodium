// D import file generated from 'randombytes.d' renamed to 'randombytes.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.randombytes;

extern (C) 
{
	struct randombytes_implementation
	{
		const(char)* function() implementation_name;
		uint function() random;
		void function() stir;
		uint function(const uint upper_bound) uniform;
		void function(const(void*) buf, const size_t size) buf;
		int function() close;
	}
	void randombytes_buf(const(void*) buf, const size_t size);
	uint randombytes_random();
	uint randombytes_uniform(const uint upper_bound);
	void randombytes_stir();
	int randombytes_close();
	int randombytes_set_implementation(randombytes_implementation* impl);
	const(char)* randombytes_implementation_name();
	void randombytes(const(ubyte*) buf, const ulong buf_len);
}
