// Written in the D programming language.

module wrapper.sodium.version_;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.version_ : SODIUM_VERSION_STRING,
                                 SODIUM_LIBRARY_VERSION_MAJOR,
                                 SODIUM_LIBRARY_VERSION_MINOR,
//                               sodium_version_string,
                                 sodium_library_version_major,
                                 sodium_library_version_minor,
                                 sodium_library_minimal;
// in order to use sodium_version_string() from deimos, it must be statically imported explicitely.

import std.string : fromStringz; // is @system

/*
 deimos.sodium.version_.sodium_version_string() gets trusted to return a valid (program lifetime) address, to be evaluated as a null-terminated C string
 added nothrow again for D, i.e. return value must be used (enforced since DMD 2.066.0 by -w compiler switch/warnings enabled)
*/
pragma(inline, true)
string sodium_version_string() pure nothrow @nogc @trusted
{
  static import deimos.sodium.version_;
  return  fromStringz(deimos.sodium.version_.sodium_version_string()); // strips terminating \0 ; compiler infers assumeUnique
}

pure /*nothrow @nogc ; deactivated due to writeln */ @system
unittest
{
  import std.algorithm.comparison : equal;
  import std.stdio : writeln;
  static import deimos.sodium.version_;
  debug writeln("unittest block 1 from sodium.version_.d");
  assert(equal(fromStringz(deimos.sodium.version_.sodium_version_string()), sodium_version_string()));
}

pure nothrow @nogc @safe
unittest
{
  cast(void) sodium_version_string();
  cast(void) sodium_library_version_major();
  cast(void) sodium_library_version_minor();
  cast(void) sodium_library_minimal();
}

pure /*nothrow @nogc ; deactivated due to writeln */ @safe
unittest
{
  import std.stdio : writeln;
  debug writeln("unittest block 2 from sodium.version_.d");
  debug writeln("SODIUM_VERSION_STRING        of binding: ", SODIUM_VERSION_STRING);
  debug writeln("SODIUM_VERSION_STRING        of binary:  ", sodium_version_string());

  debug writeln("SODIUM_LIBRARY_VERSION_MAJOR of binding: ", SODIUM_LIBRARY_VERSION_MAJOR);
  debug writeln("SODIUM_LIBRARY_VERSION_MAJOR of binary:  ", sodium_library_version_major());

  debug writeln("SODIUM_LIBRARY_VERSION_MINOR of binding: ", SODIUM_LIBRARY_VERSION_MINOR);
  debug writeln("SODIUM_LIBRARY_VERSION_MINOR of binary:  ", sodium_library_version_minor());

  debug writeln("sodium_library_minimal()              :  ", sodium_library_minimal());

/*
  if SODIUM_VERSION_STRING of binding and binary don't match:
  I don't track in this binding if function signatures etc. did change among different C source versions and which function was introduced in which version!
  The former is unlikely, so using the binary with this binding (omitting 'new' functions not supported by the binary in use and omitting a unittest build) should work.
  The latter, that functions get added from C source version to version and get tested in the wrapper's unittests is much more likely,
  which will probably result in a linking failure for a unittest build indicating the unresolved symbols:
  Thus the user has to manually comment out those lines of unitests to get a unittest build.
  In order to run the latest binary (my package distribution currently offers version 1.0.8) I did a manual build using checkinstall instead of 'make install',
  which integrates nicely as package in the package system (on Kubuntu).
  Based on matching SODIUM_VERSION_STRING of binding and binary the unittests are tested to compile and run successfully on Linux
*/
}
