/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_version_H
*/

module deimos.sodium.version_;

/* Deviating from the C header, in D the following is typed 'string' opposed to const(char)* */
/// The sodium API public version string (typed string in the binding, deviation from const(char)* in C header)
enum SODIUM_VERSION_STRING = "1.0.18";

enum SODIUM_LIBRARY_VERSION_MAJOR = 10; /// The sodium API internal version major
enum SODIUM_LIBRARY_VERSION_MINOR = 3;  /// The sodium API internal version minor

/* Deviating from the C header, in D the following strongly pure (and nothrow) functions express
   __attribute__ ((warn_unused_result)) as well (if compiler warnings are enabled); remove either
   pure or nothrow from next line to match the C header in this regard. */

extern(C) @nogc nothrow pure @trusted :


/// Returns: The sodium binary public version string
const(char)* sodium_version_string();

/// Returns: The sodium binary internal version major
int          sodium_library_version_major();

/// Returns: The sodium binary internal version minor
int          sodium_library_version_minor();

/**
 * Low-level functions that are not required by high-level APIs are also not present in libsodium binary
 * when compiled in minimal mode (./configure --enable-minimal; translates to #define SODIUM_LIBRARY_MINIMAL).
 * D version identifier SODIUM_LIBRARY_MINIMAL has the exact same meaning as in C headers.
 * Returns: 1, if the binary was build in minimal mode, i.e. #define SODIUM_LIBRARY_MINIMAL was used when compiling,
 *          0  otherwise.
 */
int          sodium_library_minimal();
