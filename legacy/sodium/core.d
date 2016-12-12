/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_core_H
*/

//deprecated("Use dependency sodium (that's the default for sodium:deimos) instead and import deimos.sodium.core")
module sodium.core;

version(DigitalMars) { pragma(lib, "sodium"); } // no effect when using DUB (separate compile, link invocations); but effective with RDMD as well as DMD iff omitting the -c switch


extern(C) int sodium_init() nothrow @nogc @trusted; // __attribute__ ((warn_unused_result))
