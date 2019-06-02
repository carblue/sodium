/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_kdf_blake2b_H
*/

module deimos.sodium.crypto_kdf_blake2b;


extern(C) @nogc pure :


enum crypto_kdf_blake2b_BYTES_MIN = 16U;

size_t crypto_kdf_blake2b_bytes_min() @trusted;

enum crypto_kdf_blake2b_BYTES_MAX = 64U;

size_t crypto_kdf_blake2b_bytes_max() @trusted;

enum crypto_kdf_blake2b_CONTEXTBYTES = 8U;

size_t crypto_kdf_blake2b_contextbytes() @trusted;

enum crypto_kdf_blake2b_KEYBYTES = 32U;

size_t crypto_kdf_blake2b_keybytes() @trusted;

int crypto_kdf_blake2b_derive_from_key(ubyte* subkey, size_t subkey_len,
                                       ulong subkey_id,
                                       ref const(char)[crypto_kdf_blake2b_CONTEXTBYTES] ctx,
                                       ref const(ubyte)[crypto_kdf_blake2b_KEYBYTES] key); // __attribute__ ((nonnull));
