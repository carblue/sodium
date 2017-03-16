/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_core_H
*/

module wrapper.sodium.core;

version(DigitalMars) { pragma(lib, "sodium"); } // In order to come into effect, DUB has to be invoked with option dub build --build-mode=allAtOnce  or e.g. DMD invoked omitting the -c switch

public import  deimos.sodium.core;

shared static this() {
  import std.exception : enforce;
  enforce(sodium_init() == 0, "Initialization of Sodium failed");
}

@safe
unittest
{
  debug {
    import std.stdio : writeln;
    writeln("unittest block 1 from sodium.core.d");
  }
  assert(sodium_init() == 1);

version(Posix)
{
  import std.process : executeShell;
  auto cat = executeShell("cat /proc/sys/kernel/random/entropy_avail");
  if (cat.status != 0)
    writeln("Failed to receive data from random/entropy_avail");
  else
    writeln("entropy_avail: ", cat.output);
}
}
