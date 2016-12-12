module sodium.runtime;

extern(C) pure /*nothrow*/ @nogc @trusted
{
  int sodium_runtime_has_neon();
  int sodium_runtime_has_sse2();
  int sodium_runtime_has_sse3();
  int sodium_runtime_has_ssse3();
  int sodium_runtime_has_sse41();
  int sodium_runtime_has_avx();
  int sodium_runtime_has_avx2();  // not available in version 1.0.8
  int sodium_runtime_has_pclmul();
  int sodium_runtime_has_aesni();
}


/*  END OF TRANSLATED HEADER */



@safe
unittest {
  import std.stdio : writeln, writefln;
  debug writeln("unittest block 1 from sodium.runtime.d");
  writefln("sodium_runtime_has_neon:   %s",sodium_runtime_has_neon());
  writefln("sodium_runtime_has_sse2:   %s",sodium_runtime_has_sse2());
  writefln("sodium_runtime_has_sse3:   %s",sodium_runtime_has_sse3());
  writefln("sodium_runtime_has_ssse3:  %s",sodium_runtime_has_ssse3());
  writefln("sodium_runtime_has_sse41:  %s",sodium_runtime_has_sse41());
  writefln("sodium_runtime_has_avx:    %s",sodium_runtime_has_avx());
//  writefln("sodium_runtime_has_avx2:   %s",sodium_runtime_has_avx2());
  writefln("sodium_runtime_has_pclmul: %s",sodium_runtime_has_pclmul());
  writefln("sodium_runtime_has_aesni:  %s",sodium_runtime_has_aesni());
}