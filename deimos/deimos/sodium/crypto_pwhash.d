/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_pwhash_H
*/

module deimos.sodium.crypto_pwhash;

import deimos.sodium.crypto_pwhash_argon2i : crypto_pwhash_argon2i_ALG_ARGON2I13;

import deimos.sodium.crypto_pwhash_argon2id: crypto_pwhash_argon2id_ALG_ARGON2ID13,
                                             crypto_pwhash_argon2id_BYTES_MIN,
                                             crypto_pwhash_argon2id_BYTES_MAX,
                                             crypto_pwhash_argon2id_PASSWD_MIN,
                                             crypto_pwhash_argon2id_PASSWD_MAX,
                                             crypto_pwhash_argon2id_SALTBYTES,
                                             crypto_pwhash_argon2id_STRBYTES,
                                             crypto_pwhash_argon2id_STRPREFIX,
                                             crypto_pwhash_argon2id_OPSLIMIT_MIN,
                                             crypto_pwhash_argon2id_OPSLIMIT_MAX,
                                             crypto_pwhash_argon2id_MEMLIMIT_MIN,
                                             crypto_pwhash_argon2id_MEMLIMIT_MAX,
                                             crypto_pwhash_argon2id_OPSLIMIT_INTERACTIVE,
                                             crypto_pwhash_argon2id_MEMLIMIT_INTERACTIVE,
                                             crypto_pwhash_argon2id_OPSLIMIT_MODERATE,
                                             crypto_pwhash_argon2id_MEMLIMIT_MODERATE,
                                             crypto_pwhash_argon2id_OPSLIMIT_SENSITIVE,
                                             crypto_pwhash_argon2id_MEMLIMIT_SENSITIVE;


extern(C) pure @nogc :

alias crypto_pwhash_ALG_ARGON2I13  = crypto_pwhash_argon2i_ALG_ARGON2I13;

int crypto_pwhash_alg_argon2i13() @trusted;

alias crypto_pwhash_ALG_ARGON2ID13 = crypto_pwhash_argon2id_ALG_ARGON2ID13;

int crypto_pwhash_alg_argon2id13() @trusted;


alias crypto_pwhash_ALG_DEFAULT = crypto_pwhash_ALG_ARGON2ID13;

int crypto_pwhash_alg_default() @trusted;

alias crypto_pwhash_BYTES_MIN = crypto_pwhash_argon2id_BYTES_MIN;

size_t crypto_pwhash_bytes_min() @trusted;

alias crypto_pwhash_BYTES_MAX = crypto_pwhash_argon2id_BYTES_MAX;

size_t crypto_pwhash_bytes_max() @trusted;

alias crypto_pwhash_PASSWD_MIN = crypto_pwhash_argon2id_PASSWD_MIN;

size_t crypto_pwhash_passwd_min() @trusted;

alias crypto_pwhash_PASSWD_MAX = crypto_pwhash_argon2id_PASSWD_MAX;

size_t crypto_pwhash_passwd_max() @trusted;

alias crypto_pwhash_SALTBYTES = crypto_pwhash_argon2id_SALTBYTES;

size_t crypto_pwhash_saltbytes() @trusted;

alias crypto_pwhash_STRBYTES = crypto_pwhash_argon2id_STRBYTES;

size_t crypto_pwhash_strbytes() @trusted;

alias crypto_pwhash_STRPREFIX = crypto_pwhash_argon2id_STRPREFIX;

const(char)* crypto_pwhash_strprefix() @trusted;

alias crypto_pwhash_OPSLIMIT_MIN = crypto_pwhash_argon2id_OPSLIMIT_MIN;

size_t crypto_pwhash_opslimit_min() @trusted;

alias crypto_pwhash_OPSLIMIT_MAX = crypto_pwhash_argon2id_OPSLIMIT_MAX;

size_t crypto_pwhash_opslimit_max() @trusted;

alias crypto_pwhash_MEMLIMIT_MIN = crypto_pwhash_argon2id_MEMLIMIT_MIN;

size_t crypto_pwhash_memlimit_min() @trusted;

alias crypto_pwhash_MEMLIMIT_MAX = crypto_pwhash_argon2id_MEMLIMIT_MAX;

size_t crypto_pwhash_memlimit_max() @trusted;

alias crypto_pwhash_OPSLIMIT_INTERACTIVE = crypto_pwhash_argon2id_OPSLIMIT_INTERACTIVE;

size_t crypto_pwhash_opslimit_interactive() @trusted;

alias crypto_pwhash_MEMLIMIT_INTERACTIVE = crypto_pwhash_argon2id_MEMLIMIT_INTERACTIVE;

size_t crypto_pwhash_memlimit_interactive() @trusted;

alias crypto_pwhash_OPSLIMIT_MODERATE = crypto_pwhash_argon2id_OPSLIMIT_MODERATE;

size_t crypto_pwhash_opslimit_moderate() @trusted;

alias crypto_pwhash_MEMLIMIT_MODERATE = crypto_pwhash_argon2id_MEMLIMIT_MODERATE;

size_t crypto_pwhash_memlimit_moderate() @trusted;

alias crypto_pwhash_OPSLIMIT_SENSITIVE = crypto_pwhash_argon2id_OPSLIMIT_SENSITIVE;

size_t crypto_pwhash_opslimit_sensitive() @trusted;

alias crypto_pwhash_MEMLIMIT_SENSITIVE = crypto_pwhash_argon2id_MEMLIMIT_SENSITIVE;

size_t crypto_pwhash_memlimit_sensitive() @trusted;

/*
 * With this function, do not forget to store all parameters, including the
 * algorithm identifier in order to produce deterministic output.
 * The crypto_pwhash_* definitions, including crypto_pwhash_ALG_DEFAULT,
 * may change.
 */
int crypto_pwhash(ubyte* out_, ulong outlen,
                  const(char*) passwd, ulong passwdlen,
                  const(ubyte*) salt,
                  ulong opslimit, size_t memlimit, int alg) nothrow; // __attribute__ ((warn_unused_result));

/*
 * The output string already includes all the required parameters, including
 * the algorithm identifier. The string is all that has to be stored in
 * order to verify a password.
 */
int crypto_pwhash_str(ref char[crypto_pwhash_STRBYTES] out_,
                      const(char*) passwd, ulong passwdlen,
                      ulong opslimit, size_t memlimit) nothrow; // __attribute__ ((warn_unused_result));

int crypto_pwhash_str_alg(ref char[crypto_pwhash_STRBYTES] out_,
                          const(char*) passwd, ulong passwdlen,
                          ulong opslimit, size_t memlimit, int alg) nothrow; // __attribute__ ((warn_unused_result));

int crypto_pwhash_str_verify(ref const(char[crypto_pwhash_STRBYTES]) str,
                             const(char*) passwd,
                             ulong passwdlen) nothrow; // __attribute__ ((warn_unused_result));

int crypto_pwhash_str_needs_rehash(ref const(char[crypto_pwhash_STRBYTES]) str,
                                   ulong opslimit, size_t memlimit) nothrow; // __attribute__ ((warn_unused_result));

enum crypto_pwhash_PRIMITIVE = "argon2i";

const(char)* crypto_pwhash_primitive() nothrow @trusted; // __attribute__ ((warn_unused_result))
