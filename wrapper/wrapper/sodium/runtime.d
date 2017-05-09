// Written in the D programming language.

module wrapper.sodium.runtime;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.runtime;


pure nothrow @nogc @safe
unittest {
  cast(void) sodium_runtime_has_neon();
  cast(void) sodium_runtime_has_sse2();
  cast(void) sodium_runtime_has_sse3();
  cast(void) sodium_runtime_has_ssse3();
  cast(void) sodium_runtime_has_sse41();
  cast(void) sodium_runtime_has_avx();
  cast(void) sodium_runtime_has_avx2();  // not available in version 1.0.8
  cast(void) sodium_runtime_has_pclmul();
  cast(void) sodium_runtime_has_aesni();
}

pure /*nothrow @nogc ; deactivated due to writeln */ @safe
unittest {
  import std.stdio : writeln; // writeln is not @nogc and not nothrow
  debug writeln("unittest block 1 from sodium.runtime.d");
  debug writeln("sodium_runtime_has_neon:   ",sodium_runtime_has_neon());
  debug writeln("sodium_runtime_has_sse2:   ",sodium_runtime_has_sse2());
  debug writeln("sodium_runtime_has_sse3:   ",sodium_runtime_has_sse3());
  debug writeln("sodium_runtime_has_ssse3:  ",sodium_runtime_has_ssse3());
  debug writeln("sodium_runtime_has_sse41:  ",sodium_runtime_has_sse41());
  debug writeln("sodium_runtime_has_avx:    ",sodium_runtime_has_avx());
  debug writeln("sodium_runtime_has_avx2:   ",sodium_runtime_has_avx2());  // not available in version 1.0.8
  debug writeln("sodium_runtime_has_pclmul: ",sodium_runtime_has_pclmul());
  debug writeln("sodium_runtime_has_aesni:  ",sodium_runtime_has_aesni());
}
