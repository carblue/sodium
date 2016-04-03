// D import file generated from 'crypto_pwhash.d' renamed to 'crypto_pwhash.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_pwhash;

import sodium.crypto_pwhash_argon2i;

extern (C) 
{
	enum crypto_pwhash_ALG_ARGON2I13 = crypto_pwhash_argon2i_ALG_ARGON2I13;
	int crypto_pwhash_alg_argon2i13();
	enum crypto_pwhash_ALG_DEFAULT = crypto_pwhash_ALG_ARGON2I13;
	int crypto_pwhash_alg_default();
	enum crypto_pwhash_SALTBYTES = crypto_pwhash_argon2i_SALTBYTES;
	size_t crypto_pwhash_saltbytes();
	enum crypto_pwhash_STRBYTES = crypto_pwhash_argon2i_STRBYTES;
	size_t crypto_pwhash_strbytes();
	immutable(char*) crypto_pwhash_STRPREFIX = crypto_pwhash_argon2i_STRPREFIX;
	const(char)* crypto_pwhash_strprefix();
	enum crypto_pwhash_OPSLIMIT_INTERACTIVE = crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE;
	size_t crypto_pwhash_opslimit_interactive();
	enum crypto_pwhash_MEMLIMIT_INTERACTIVE = crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE;
	size_t crypto_pwhash_memlimit_interactive();
	enum crypto_pwhash_OPSLIMIT_MODERATE = crypto_pwhash_argon2i_OPSLIMIT_MODERATE;
	size_t crypto_pwhash_opslimit_moderate();
	enum crypto_pwhash_MEMLIMIT_MODERATE = crypto_pwhash_argon2i_MEMLIMIT_MODERATE;
	size_t crypto_pwhash_memlimit_moderate();
	enum crypto_pwhash_OPSLIMIT_SENSITIVE = crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE;
	size_t crypto_pwhash_opslimit_sensitive();
	enum crypto_pwhash_MEMLIMIT_SENSITIVE = crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE;
	size_t crypto_pwhash_memlimit_sensitive();
	pure nothrow @nogc @safe int crypto_pwhash(const(ubyte*) out_, ulong outlen, const(char*) passwd, ulong passwdlen, const(ubyte*) salt, ulong opslimit, size_t memlimit, int alg);
	pure nothrow @nogc @safe int crypto_pwhash_str(ref char[crypto_pwhash_STRBYTES] out_, const(char*) passwd, ulong passwdlen, ulong opslimit, size_t memlimit);
	pure nothrow @nogc @safe int crypto_pwhash_str_verify(ref const(char)[crypto_pwhash_STRBYTES] str, const(char*) passwd, ulong passwdlen);
	immutable(char*) crypto_pwhash_PRIMITIVE = "argon2i";
	pure nothrow @nogc @safe const(char)* crypto_pwhash_primitive();
}
