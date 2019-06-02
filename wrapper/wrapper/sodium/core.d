// Written in the D programming language.

module wrapper.sodium.core;

public
import  deimos.sodium.core;

shared static this() {
  static import std.exception;
  std.exception.enforce(sodium_init() == 0, "Initialization of Sodium failed");
}


@nogc nothrow @safe
unittest
{
  assert(sodium_init() == 1);
}

version(Posix)
@safe unittest
{
  import std.stdio : writeln; // writeln is not @nogc and not nothrow
  import std.process : executeShell; // executeShell is not @nogc and not nothrow
  writeln("unittest block 1 from sodium.core.d");
  auto cat = executeShell("cat /proc/sys/kernel/random/entropy_avail");
  writeln("entropy_avail: ", (cat.status==0 ? cat.output : "-1")); // -1 means: executeShell's command failed
}
