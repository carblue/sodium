// Written in the D programming language.

/**
 * Initialization and 'abort process' related functions and unittests.
 */

module wrapper.sodium.core;

public
import  deimos.sodium.core;

shared static this() @safe
{
    static import std.exception;

    std.exception.enforce(sodium_init() == 0, "Initialization of Sodium failed");
}

@nogc nothrow @safe
unittest
{
    assert(sodium_init() == 1, "error with 2. call to sodium_init()");
}

version (Posix)
@safe
unittest
{
    import std.stdio : writeln; // writeln is not @nogc and not nothrow
    import std.process : executeShell; // executeShell is not @nogc and not nothrow
    writeln("unittest block 1 from sodium.core.d");
    auto cat = executeShell("cat /proc/sys/kernel/random/entropy_avail");
    writeln("entropy_avail: ", (cat.status == 0 ? cat.output : "-1")); // -1 means: executeShell's command failed
}

/+
private extern (C) void my_misuse_handler() nothrow @safe
{
    import std.stdio : writeln;
    try
        writeln("called my_misuse_handler()");
    catch (Exception e) { /* */ }
}

@system unittest
{
    import core.exception : AssertError;
    import std.stdio : writeln;
    assert(sodium_set_misuse_handler(&my_misuse_handler) == 0, "failing to set misuse_handler");
    sodium_misuse(); // OKAY, this works: Program exited with code -6
    writeln("### executing code that is NOT expected to be executed ! ###");
    throw new AssertError("unittest block 2 from sodium.core.d", __FILE__, __LINE__);
}
+/
