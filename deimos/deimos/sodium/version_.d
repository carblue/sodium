/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_version_H
*/

/**
 * Functions related to binary build and binary/binding versioning.
 */

module deimos.sodium.version_;

/// The sodium binding API public version string (typed string in the binding, deviation from const(char)* in C header)
enum string SODIUM_VERSION_STRING = "1.0.18";

enum int SODIUM_LIBRARY_VERSION_MAJOR = 10; /// The sodium binding API internal version major
enum int SODIUM_LIBRARY_VERSION_MINOR = 3; /// The sodium binding API internal version minor

extern (C) @nogc nothrow pure @trusted:

/// Returns: The sodium binary public version string as C string
const(char)* sodium_version_string();

/// Returns: The sodium binary internal version major
int sodium_library_version_major();

/// Returns: The sodium binary internal version minor
int sodium_library_version_minor();

/**
 * Function informing about binary build type 'minimal mode'.
 *
 * Low-level functions that are not required by high-level APIs are also not present in libsodium binary
 * when compiled in minimal mode (./configure --enable-minimal; translates to #define SODIUM_LIBRARY_MINIMAL).
 * D version identifier SODIUM_LIBRARY_MINIMAL has the exact same meaning as in C headers.
 * Adapt deimos/dub.json and wrapper/dub.json by "versions": ["SODIUM_LIBRARY_MINIMAL"], if this function returns 1.
 * Returns: 1, if the binary was build in minimal mode, i.e. #define SODIUM_LIBRARY_MINIMAL was used when compiling,
 *          0  otherwise.
 * See_Also: https://download.libsodium.org/doc/advanced
 */
int sodium_library_minimal();
