/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_runtime_H
*/

module deimos.sodium.runtime;

extern (C) @nogc nothrow pure @trusted:

int sodium_runtime_has_neon();

int sodium_runtime_has_sse2();

int sodium_runtime_has_sse3();

int sodium_runtime_has_ssse3();

int sodium_runtime_has_sse41();

int sodium_runtime_has_avx();

int sodium_runtime_has_avx2(); // available since version 1.0.9 ?

int sodium_runtime_has_avx512f(); // available since version 1.0.14

int sodium_runtime_has_pclmul();

int sodium_runtime_has_aesni();

int sodium_runtime_has_rdrand(); // available since version 1.0.16
