/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_verify_16_H
*/

module deimos.sodium.crypto_verify_16;


extern(C) pure nothrow @nogc:


enum crypto_verify_16_BYTES = 16U;

/* Deviating from C header, in D the following function expresses __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
size_t crypto_verify_16_bytes() @trusted;

int crypto_verify_16(const(ubyte)* x, const(ubyte)* y); // __attribute__ ((warn_unused_result))
