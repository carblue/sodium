/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_verify_32_H
*/

module deimos.sodium.crypto_verify_32;


extern(C) pure nothrow @nogc:


enum crypto_verify_32_BYTES = 32U;

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
size_t crypto_verify_32_bytes() @trusted;

int crypto_verify_32(const(ubyte)* x, const(ubyte)* y); // __attribute__ ((warn_unused_result))
