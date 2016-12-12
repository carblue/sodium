module sodium.version_;

//immutable(char*) SODIUM_VERSION_STRING = "1.0.11";
enum SODIUM_VERSION_STRING = "1.0.11"; // now a D string
enum SODIUM_LIBRARY_VERSION_MAJOR = 9;
enum SODIUM_LIBRARY_VERSION_MINOR = 3;

extern(C) pure /*nothrow*/ @nogc
{
	const(char)* sodium_version_string() @system;
	int sodium_library_version_major() @trusted;
	int sodium_library_version_minor() @trusted;
}


/*  END OF TRANSLATED HEADER */


/**
 Intention is to overload C function      sodium_version_string,
 but missing parameters force a new name: sodium_version_stringD (didn't want to introduce an arbitrary unused parameter)
 We trust to receive a valid address from sodium_version_string() to be evaluated as a null-terminated C string and do a copy afterwards
 added nothrow again for D, i.e. return value must be used
*/
string sodium_version_stringD() pure nothrow @trusted
{
  import std.string : fromStringz; // @system
  const(char)[] c_arr;
  try
    c_arr = fromStringz(sodium_version_string());
  catch (Exception e) { /* known not to throw */}
  return c_arr.idup;
}

pure @system
unittest
{
  import std.string : fromStringz;
  import std.algorithm.comparison : equal;
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.version_.d");
  assert(equal(fromStringz(sodium_version_string()), sodium_version_stringD()));
}

@safe
unittest
{
  import std.stdio : writeln;
  debug writeln("unittest block 2 from sodium.version_.d");
  writeln("SODIUM_VERSION_STRING        of binding: ", SODIUM_VERSION_STRING);
  writeln("SODIUM_VERSION_STRING        of binary:  ", sodium_version_stringD());

  writeln("SODIUM_LIBRARY_VERSION_MAJOR of binding: ", SODIUM_LIBRARY_VERSION_MAJOR);
  writeln("SODIUM_LIBRARY_VERSION_MAJOR of binary:  ", sodium_library_version_major());

  writeln("SODIUM_LIBRARY_VERSION_MINOR of binding: ", SODIUM_LIBRARY_VERSION_MINOR);
  writeln("SODIUM_LIBRARY_VERSION_MINOR of binary:  ", sodium_library_version_minor());
/*
  if SODIUM_VERSION_STRING of binding and binary don't match:
  I don't track in this binding if function signatures did change among different versions and which function was introduced in which version!
  The former is unlikely, so using the binary with this binding (omitting 'new' functions not supported by the binary and omitting a unittest build) should work.
  The latter, that functions get added from C source version to version and get tested in the binding's unittests is much more likely,
  which will probably result in a linking failure for a unittest build indicating the unresolved symbols:
  Thus the user has to manually comment out those lines of unitests to get a unittest build.
  In order to run the latest binary (my package distribution currently offers version 1.0.8) I did a manual build using checkinstall instead of 'make install',
  which integrates nicely as package in the package system (on Kubuntu).
  Based on matching SODIUM_VERSION_STRING of binding and binary the unittests are tested to compile and run successfully
*/
}
