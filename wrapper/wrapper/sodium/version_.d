// Written in the D programming language.

/**
 * Functions related to binary build and binary/binding versioning and unittests.
 */

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

/* Wrapper(s)/substitute(s) for 'deimos' functions */

/// Returns: The sodium binary public version string as D string
pragma(inline, true)
string sodium_version_string() @nogc nothrow pure @trusted
{
    import std.string : fromStringz;
    static import deimos.sodium.version_;

    return fromStringz(deimos.sodium.version_.sodium_version_string());
}

/* unittest(s) : They cover all deimos/wrapper functions and their attributes, use all enums */

@nogc nothrow pure @safe unittest
{
    static import deimos.sodium.version_;

    assert(deimos.sodium.version_.sodium_version_string() == sodium_version_string().ptr,
           "sodium_version_string() implementation error");
    cast(void) deimos.sodium.version_.sodium_version_string();
    cast(void) sodium_version_string();
    cast(void) sodium_library_version_major();
    cast(void) sodium_library_version_minor();
    cast(void) sodium_library_minimal();
}

/*@nogc*/
nothrow pure @safe unittest
{
    import core.exception : AssertError;
    import std.stdio : writeln;

    try
        debug
        {
            writeln("unittest block 1 from sodium.version_.d");
            writeln("SODIUM_VERSION_STRING        of binding: ", SODIUM_VERSION_STRING);
            writeln("SODIUM_VERSION_STRING        of binary:  ", sodium_version_string());

            writeln("SODIUM_LIBRARY_VERSION_MAJOR of binding: ", SODIUM_LIBRARY_VERSION_MAJOR);
            writeln("SODIUM_LIBRARY_VERSION_MAJOR of binary:  ", sodium_library_version_major());

            writeln("SODIUM_LIBRARY_VERSION_MINOR of binding: ", SODIUM_LIBRARY_VERSION_MINOR);
            writeln("SODIUM_LIBRARY_VERSION_MINOR of binary:  ", sodium_library_version_minor());

            writeln("Whether binary was compiled in minimal mode (#define SODIUM_LIBRARY_MINIMAL): ",
                    sodium_library_minimal());
        }
    catch (Exception e)
    {
        throw new AssertError("unittest block 1 from sodium.version_.d", __FILE__, __LINE__);
    }

/*
  If SODIUM_VERSION_STRING of binding and binary don't match:
  This is a binding to the C source version stated in README.md.
  I don't track in this binding, if function signatures etc. did change among different C source versions and which function was introduced in which version!
  The former is unlikely, thus using the binary with this binding (omitting 'new' functions not supported by the binary in use and omitting a unittest build) should work.
  The latter, that functions get added from C source version to version and get tested in the wrapper's unittests is much more likely,
  which will probably result in a linking failure for a unittest build indicating the unresolved symbols:
  Thus the user has to either update the binary or manually comment out those lines of unittests to get a unittest build.
  In order to run the latest binary (my package distribution currently offers version 1.0.16 while 1.0.18 is released) I did a manual build using checkinstall
  instead of 'make install', which integrates nicely as package in the package system (Kubuntu).
  Based on matching SODIUM_VERSION_STRING of binding and binary the unittests are tested to compile and run successfully with Linux and Windows.
*/
}
