// D import file generated from 'crypto_pwhash_argon2i.d' renamed to 'crypto_pwhash_argon2i.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_pwhash_argon2i;

extern (C) 
{
	enum crypto_pwhash_argon2i_ALG_ARGON2I13 = 1;
	int crypto_pwhash_argon2i_alg_argon2i13();
	enum crypto_pwhash_argon2i_SALTBYTES = 16u;
	size_t crypto_pwhash_argon2i_saltbytes();
	enum crypto_pwhash_argon2i_STRBYTES = 128u;
	size_t crypto_pwhash_argon2i_strbytes();
	immutable(char*) crypto_pwhash_argon2i_STRPREFIX = "$argon2i$";
	const(char)* crypto_pwhash_argon2i_strprefix();
	enum crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE = 4LU;
	size_t crypto_pwhash_argon2i_opslimit_interactive();
	enum crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE = 33554432LU;
	size_t crypto_pwhash_argon2i_memlimit_interactive();
	enum crypto_pwhash_argon2i_OPSLIMIT_MODERATE = 6LU;
	size_t crypto_pwhash_argon2i_opslimit_moderate();
	enum crypto_pwhash_argon2i_MEMLIMIT_MODERATE = 134217728LU;
	size_t crypto_pwhash_argon2i_memlimit_moderate();
	enum crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE = 8LU;
	size_t crypto_pwhash_argon2i_opslimit_sensitive();
	enum crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE = 536870912LU;
	size_t crypto_pwhash_argon2i_memlimit_sensitive();
	pure nothrow @nogc @safe int crypto_pwhash_argon2i(const(ubyte*) out_, ulong outlen, const(char*) passwd, ulong passwdlen, const(ubyte*) salt, ulong opslimit, size_t memlimit, int alg);
	pure nothrow @nogc @safe int crypto_pwhash_argon2i_str(ref char[crypto_pwhash_argon2i_STRBYTES] out_, const(char*) passwd, ulong passwdlen, ulong opslimit, size_t memlimit);
	pure nothrow @nogc @safe int crypto_pwhash_argon2i_str_verify(ref const(char)[crypto_pwhash_argon2i_STRBYTES] str, const(char*) passwd, ulong passwdlen);
	int _crypto_pwhash_argon2i_pick_best_implementation();
}
