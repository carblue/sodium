/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_pwhash_argon2i_H
*/

module deimos.sodium.crypto_pwhash_argon2i;

import deimos.sodium.export_;


extern(C) pure @nogc :


enum crypto_pwhash_argon2i_ALG_ARGON2I13 = 1;

int crypto_pwhash_argon2i_alg_argon2i13() @trusted;

enum crypto_pwhash_argon2i_BYTES_MIN = 16U;

size_t crypto_pwhash_argon2i_bytes_min() @trusted;

enum crypto_pwhash_argon2i_BYTES_MAX = SODIUM_MIN(SODIUM_SIZE_MAX, 4294967295U);

size_t crypto_pwhash_argon2i_bytes_max() @trusted;

enum crypto_pwhash_argon2i_PASSWD_MIN = 0U;

size_t crypto_pwhash_argon2i_passwd_min() @trusted;

enum crypto_pwhash_argon2i_PASSWD_MAX = 4294967295U;

size_t crypto_pwhash_argon2i_passwd_max() @trusted;

enum crypto_pwhash_argon2i_SALTBYTES = 16U;

size_t crypto_pwhash_argon2i_saltbytes() @trusted;

enum crypto_pwhash_argon2i_STRBYTES = 128U;

size_t crypto_pwhash_argon2i_strbytes() @trusted;

enum crypto_pwhash_argon2i_STRPREFIX = "$argon2i$";

const(char)* crypto_pwhash_argon2i_strprefix() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_MIN = 3U;

size_t crypto_pwhash_argon2i_opslimit_min() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_MAX = 4294967295U;

size_t crypto_pwhash_argon2i_opslimit_max() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_MIN = 8192U;

size_t crypto_pwhash_argon2i_memlimit_min() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_MAX =
    ((size_t.max >= 4398046510080U) ? 4398046510080U : (size_t.max >= 2147483648U) ? 2147483648U : 32768U);

size_t crypto_pwhash_argon2i_memlimit_max() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_INTERACTIVE = 4U;

size_t crypto_pwhash_argon2i_opslimit_interactive() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_INTERACTIVE = 33554432U;

size_t crypto_pwhash_argon2i_memlimit_interactive() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_MODERATE = 6U;

size_t crypto_pwhash_argon2i_opslimit_moderate() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_MODERATE = 134217728U;

size_t crypto_pwhash_argon2i_memlimit_moderate() @trusted;

enum crypto_pwhash_argon2i_OPSLIMIT_SENSITIVE = 8U;

size_t crypto_pwhash_argon2i_opslimit_sensitive() @trusted;

enum crypto_pwhash_argon2i_MEMLIMIT_SENSITIVE = 536870912U;

size_t crypto_pwhash_argon2i_memlimit_sensitive() @trusted;

int crypto_pwhash_argon2i(ubyte* out_,
                          ulong outlen,
                          const(char*) passwd,
                          ulong passwdlen,
                          const(ubyte*) salt,
                          ulong opslimit, size_t memlimit,
                          int alg) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2i_str(ref char[crypto_pwhash_argon2i_STRBYTES] out_,
                              const(char*) passwd,
                              ulong passwdlen,
                              ulong opslimit, size_t memlimit) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2i_str_verify(ref const(char[crypto_pwhash_argon2i_STRBYTES]) str,
                                     const(char*) passwd,
                                     ulong passwdlen) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2i_str_needs_rehash(ref const(char[crypto_pwhash_argon2i_STRBYTES]) str,
                                           ulong opslimit, size_t memlimit) nothrow; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));
