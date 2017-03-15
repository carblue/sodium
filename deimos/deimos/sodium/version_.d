/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_version_H
*/

module deimos.sodium.version_;

enum SODIUM_VERSION_STRING = "1.0.12";

enum SODIUM_LIBRARY_VERSION_MAJOR = 9;
enum SODIUM_LIBRARY_VERSION_MINOR = 4;


extern(C) pure /*nothrow*/ @nogc :


const(char)* sodium_version_string() @system;

int          sodium_library_version_major() @trusted;

int          sodium_library_version_minor() @trusted;

int          sodium_library_minimal() @trusted;
