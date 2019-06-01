/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_verify_64_H
*/

module deimos.sodium.crypto_verify_64;


extern(C) @nogc nothrow pure :


enum crypto_verify_64_BYTES = 64U;

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
size_t crypto_verify_64_bytes() @trusted;

int crypto_verify_64(const(ubyte)* x, const(ubyte)* y); // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull));
