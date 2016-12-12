// D import file generated from 'crypto_pwhash_scryptsalsa208sha256.d' renamed to 'crypto_pwhash_scryptsalsa208sha256.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.crypto_pwhash_scryptsalsa208sha256;

extern (C)
{
	enum crypto_pwhash_scryptsalsa208sha256_SALTBYTES = 32u;
	size_t crypto_pwhash_scryptsalsa208sha256_saltbytes();
	enum crypto_pwhash_scryptsalsa208sha256_STRBYTES = 102u;
	size_t crypto_pwhash_scryptsalsa208sha256_strbytes();
	immutable(char*) crypto_pwhash_scryptsalsa208sha256_STRPREFIX = "$7$";
	const(char)* crypto_pwhash_scryptsalsa208sha256_strprefix();
	enum crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_INTERACTIVE = 524288LU;
	size_t crypto_pwhash_scryptsalsa208sha256_opslimit_interactive();
	enum crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_INTERACTIVE = 16777216LU;
	size_t crypto_pwhash_scryptsalsa208sha256_memlimit_interactive();
	enum crypto_pwhash_scryptsalsa208sha256_OPSLIMIT_SENSITIVE = 33554432LU;
	size_t crypto_pwhash_scryptsalsa208sha256_opslimit_sensitive();
	enum crypto_pwhash_scryptsalsa208sha256_MEMLIMIT_SENSITIVE = 1073741824LU;
	size_t crypto_pwhash_scryptsalsa208sha256_memlimit_sensitive();
	int crypto_pwhash_scryptsalsa208sha256(const(ubyte*) out_, ulong outlen, const(char*) passwd, ulong passwdlen, const(ubyte*) salt, ulong opslimit, size_t memlimit);
	int crypto_pwhash_scryptsalsa208sha256_str(ref char[crypto_pwhash_scryptsalsa208sha256_STRBYTES] out_, const(char*) passwd, ulong passwdlen, ulong opslimit, size_t memlimit);
	int crypto_pwhash_scryptsalsa208sha256_str_verify(ref const(char)[crypto_pwhash_scryptsalsa208sha256_STRBYTES] str, const(char*) passwd, ulong passwdlen);
	int crypto_pwhash_scryptsalsa208sha256_ll(const(ubyte)* passwd, size_t passwdlen, const(ubyte)* salt, size_t saltlen, ulong N, uint r, uint p, ubyte* buf, size_t buflen);
}
