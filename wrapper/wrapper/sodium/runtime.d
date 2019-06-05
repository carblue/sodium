// Written in the D programming language.

module wrapper.sodium.runtime;

import wrapper.sodium.core; // assure sodium got initialized

public import deimos.sodium.runtime;

/** unittest(s) : all deimos/wrapper functions and their attributes **/

@nogc nothrow pure @safe unittest
{
    cast(void) sodium_runtime_has_neon();
    cast(void) sodium_runtime_has_sse2();
    cast(void) sodium_runtime_has_sse3();
    cast(void) sodium_runtime_has_ssse3();
    cast(void) sodium_runtime_has_sse41();
    cast(void) sodium_runtime_has_avx();
    cast(void) sodium_runtime_has_avx2();
    cast(void) sodium_runtime_has_avx512f();
    cast(void) sodium_runtime_has_pclmul();
    cast(void) sodium_runtime_has_aesni();
    cast(void) sodium_runtime_has_rdrand();
}

/*@nogc*/
nothrow pure @safe unittest
{
    import std.stdio : writeln;
    import core.exception : AssertError;

    try
    {
        debug writeln("unittest block 1 from sodium.runtime.d");
        debug writeln("sodium_runtime_has_neon:    ", sodium_runtime_has_neon());
        debug writeln("sodium_runtime_has_sse2:    ", sodium_runtime_has_sse2());
        debug writeln("sodium_runtime_has_sse3:    ", sodium_runtime_has_sse3());
        debug writeln("sodium_runtime_has_ssse3:   ", sodium_runtime_has_ssse3());
        debug writeln("sodium_runtime_has_sse41:   ", sodium_runtime_has_sse41());
        debug writeln("sodium_runtime_has_avx:     ", sodium_runtime_has_avx());
        debug writeln("sodium_runtime_has_avx2:    ", sodium_runtime_has_avx2());
        debug writeln("sodium_runtime_has_avx512f: ", sodium_runtime_has_avx512f());
        debug writeln("sodium_runtime_has_pclmul:  ", sodium_runtime_has_pclmul());
        debug writeln("sodium_runtime_has_aesni:   ", sodium_runtime_has_aesni());
        debug writeln("sodium_runtime_has_rdrand:  ", sodium_runtime_has_rdrand());
    }
    catch (Exception e)
    {
        throw new AssertError("unittest block 1 from sodium.runtime.d", __FILE__, __LINE__);
    }
}
