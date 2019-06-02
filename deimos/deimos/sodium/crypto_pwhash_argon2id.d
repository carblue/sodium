/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_pwhash_argon2id_H
*/

module deimos.sodium.crypto_pwhash_argon2id;

import deimos.sodium.export_;

extern(C) nothrow pure :


enum crypto_pwhash_argon2id_ALG_ARGON2ID13 = 2;

int crypto_pwhash_argon2id_alg_argon2id13() @trusted;

enum crypto_pwhash_argon2id_BYTES_MIN = 16U;

size_t crypto_pwhash_argon2id_bytes_min() @trusted;

enum crypto_pwhash_argon2id_BYTES_MAX = SODIUM_MIN(SODIUM_SIZE_MAX, 4294967295U);

size_t crypto_pwhash_argon2id_bytes_max() @trusted;

enum crypto_pwhash_argon2id_PASSWD_MIN = 0U;

size_t crypto_pwhash_argon2id_passwd_min() @trusted;

enum crypto_pwhash_argon2id_PASSWD_MAX = 4294967295U;

size_t crypto_pwhash_argon2id_passwd_max() @trusted;

enum crypto_pwhash_argon2id_SALTBYTES = 16U;

size_t crypto_pwhash_argon2id_saltbytes() @trusted;

enum crypto_pwhash_argon2id_STRBYTES = 128U;

size_t crypto_pwhash_argon2id_strbytes() @trusted;

enum crypto_pwhash_argon2id_STRPREFIX = "$argon2id$";

const(char)* crypto_pwhash_argon2id_strprefix();

enum crypto_pwhash_argon2id_OPSLIMIT_MIN = 1U;

size_t crypto_pwhash_argon2id_opslimit_min() @trusted;

enum crypto_pwhash_argon2id_OPSLIMIT_MAX = 4294967295U;

size_t crypto_pwhash_argon2id_opslimit_max() @trusted;

enum crypto_pwhash_argon2id_MEMLIMIT_MIN = 8192U;

size_t crypto_pwhash_argon2id_memlimit_min() @trusted;

enum crypto_pwhash_argon2id_MEMLIMIT_MAX =
    ((size_t.max >= 4398046510080U) ? 4398046510080U : (size_t.max >= 2147483648U) ? 2147483648U : 32768U);

size_t crypto_pwhash_argon2id_memlimit_max() @trusted;

enum crypto_pwhash_argon2id_OPSLIMIT_INTERACTIVE = 2U;

size_t crypto_pwhash_argon2id_opslimit_interactive() @trusted;

enum crypto_pwhash_argon2id_MEMLIMIT_INTERACTIVE = 67108864U;

size_t crypto_pwhash_argon2id_memlimit_interactive() @trusted;

enum crypto_pwhash_argon2id_OPSLIMIT_MODERATE = 3U;

size_t crypto_pwhash_argon2id_opslimit_moderate() @trusted;

enum crypto_pwhash_argon2id_MEMLIMIT_MODERATE = 268435456U;

size_t crypto_pwhash_argon2id_memlimit_moderate() @trusted;

enum crypto_pwhash_argon2id_OPSLIMIT_SENSITIVE = 4U;

size_t crypto_pwhash_argon2id_opslimit_sensitive() @trusted;

enum crypto_pwhash_argon2id_MEMLIMIT_SENSITIVE = 1073741824U;

size_t crypto_pwhash_argon2id_memlimit_sensitive() @trusted;

int crypto_pwhash_argon2id(ubyte* out_,
                           ulong outlen,
                           const(char*) passwd,
                           ulong passwdlen,
                           const(ubyte*) salt,
                           ulong opslimit, size_t memlimit,
                           int alg); // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2id_str(ref char[crypto_pwhash_argon2id_STRBYTES] out_,
                               const(char*) passwd,
                               ulong passwdlen,
                               ulong opslimit, size_t memlimit); // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2id_str_verify(ref const(char[crypto_pwhash_argon2id_STRBYTES]) str,
                                      const(char*) passwd,
                                      ulong passwdlen); // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));

int crypto_pwhash_argon2id_str_needs_rehash(ref const(char[crypto_pwhash_argon2id_STRBYTES]) str,
                                            ulong opslimit, size_t memlimit); // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));
