/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_version_H
*/

module deimos.sodium.version_;

enum SODIUM_VERSION_STRING = "1.0.14";

enum SODIUM_LIBRARY_VERSION_MAJOR = 9;
enum SODIUM_LIBRARY_VERSION_MINOR = 6;


/* Deviating from C header, in D the following functions express __attribute__ ((warn_unused_result)) as well (if compiler switch -w is thrown) */
extern(C) pure nothrow @nogc @trusted :


const(char)* sodium_version_string();

int          sodium_library_version_major();

int          sodium_library_version_minor();

int          sodium_library_minimal();
