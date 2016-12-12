/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_pwhash_argon2i_H
*/

module sodium.crypto_pwhash_argon2i;


extern(C) pure nothrow :


enum crypto_pwhash_argon2i_ALG_ARGON2I13 = 1;

int crypto_pwhash_argon2i_alg_argon2i13() @trusted;

enum crypto_pwhash_argon2i_SALTBYTES = 16U;

size_t crypto_pwhash_argon2i_saltbytes() @trusted;

enum crypto_pwhash_argon2i_STRBYTES = 128U;

size_t crypto_pwhash_argon2i_strbytes() @trusted;

enum crypto_pwhash_argon2i_STRPREFIX = "$argon2i$";

const(char)* crypto_pwhash_argon2i_strprefix() @system;

enum crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE = 4UL;

size_t crypto_pwhash_argon2i_opslimit_interactive() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE = 33554432UL;

size_t crypto_pwhash_argon2i_memlimit_interactive() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_MODERATE = 6UL;

size_t crypto_pwhash_argon2i_opslimit_moderate() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_MODERATE = 134217728UL;

size_t crypto_pwhash_argon2i_memlimit_moderate() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE = 8UL;

size_t crypto_pwhash_argon2i_opslimit_sensitive() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE = 536870912UL;

size_t crypto_pwhash_argon2i_memlimit_sensitive() @trusted;

int crypto_pwhash_argon2i(ubyte* out_,
                          ulong outlen,
                          const(char*) passwd,
                          ulong passwdlen,
                          const(ubyte*) salt,
                          ulong opslimit, size_t memlimit,
                          int alg) nothrow @system; // __attribute__ ((warn_unused_result));

int crypto_pwhash_argon2i_str(ref char[crypto_pwhash_argon2i_STRBYTES] out_,
                              const(char*) passwd,
                              ulong passwdlen,
                              ulong opslimit, size_t memlimit) nothrow @system; // __attribute__ ((warn_unused_result));

int crypto_pwhash_argon2i_str_verify(ref const(char[crypto_pwhash_argon2i_STRBYTES]) str,
                                     const(char*) passwd,
                                     ulong passwdlen) nothrow @system; // __attribute__ ((warn_unused_result));
