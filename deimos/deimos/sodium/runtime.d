/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_runtime_H
*/

module deimos.sodium.runtime;

/* Deviating from the C header, in D the following strongly pure (and nothrow) functions express __attribute__ ((warn_unused_result))
   as well (if compiler warnings are enabled); remove either pure or nothrow from next line to match the C header in this regard. */

extern(C) @nogc nothrow pure @trusted :


int sodium_runtime_has_neon();

int sodium_runtime_has_sse2();

int sodium_runtime_has_sse3();

int sodium_runtime_has_ssse3();

int sodium_runtime_has_sse41();

int sodium_runtime_has_avx();

int sodium_runtime_has_avx2();  // available since version 1.0.9 ?

int sodium_runtime_has_avx512f(); // available since version 1.0.14

int sodium_runtime_has_pclmul();

int sodium_runtime_has_aesni();

int sodium_runtime_has_rdrand(); // available since version 1.0.16
