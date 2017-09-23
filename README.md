**Build state**

[![Build Status](https://travis-ci.org/carblue/sodium.svg?branch=master)](https://travis-ci.org/carblue/sodium)
[![Build status](https://ci.appveyor.com/api/projects/status/2k14jpgh2grshq13/branch/master?svg=true)](https://ci.appveyor.com/project/carblue/sodium/branch/master)
[![Coverage Status](https://coveralls.io/repos/github/carblue/sodium/badge.svg?branch=master)](https://coveralls.io/github/carblue/sodium?branch=master)

# sodium

Twofold binding to libsodium, current C-source version 1.0.14, released on Sept. 22, 2017 [https://github.com/jedisct1/libsodium]

subPackage 'deimos':  The "import-only" C header's declarations.<br>
subPackage 'wrapper': 'deimos' + some 'D-friendly' stuff, predominantly overloaded functions and unittests.

The dependency name is either  sodium:deimos  or  sodium:wrapper

Some restructuring (subPackages)/changing importPath and sourcePath was done for version 0.1.0 (different from previous 0.08) in order to have the 'wrapper' subPackage sit aside subPackage 'deimos'.<br>
Thus code that already used versions<0.1.0 needs to replace 'import sodium...' by either 'import deimos.sodium...' or 'import wrapper.sodium...'.

'wrapper' aims at providing at least the same functionality as 'deimos' and provide @trusted @nogc (pure nothrow) 'D-friendly' alternatives, that are hard to use in a wrong way; work in progress:<br>
a) 'wrapper' is a superset of 'deimos' in that everything from 'deimos' is reachable, but deliberately not all at your fingertips.<br>
b) all new functions with 'deimos-functionality' have the same name as their 'deimos'-cousins and call them, building either overload sets to choose from, or for parameter-less functions, 'substituting' their cousins.<br>
c) all new functions calculating a variable-length output are restrictive referring to the size of the output-buffer offered, if the required size can be easily computed in advance, throwing in case of wrong-sized buffers.<br>
   This way, if a function succeeds, all output-buffer.length bytes are meaningful and no additional/deimos-like function out parameter carrying the meaningful length information is required.<br>
d) No need to explicitely call sodium_init() up-front.<br>
e) Usage of 'wrapper' isn't possible, if function randombytes_set_implementation shall be used (wrapper.sodium.core:shared static this() calls sodium_init()).

The unittests of subPackage 'wrapper' include a lot of function usage examples; the next is a simple application example based on sodium:deimos, using rdmd and file cmdfile, suitable as is for Linux:<br>

	cd example/source  &&  chmod 775 app.d  &&  ./app.d

Expected output (byte values within brackets differing of course):

Unpredictable sequence of 8 bytes: [52, 225, 21, 245, 74, 66, 192, 247]<br>
crypto_aead_aes256gcm_is_available<br>
ciphertext: [76, 18, 112, 219, 144, 230, 206, 219, 40, 255, 78, 43, 172, 49, 129, 175, 4, 235, 81, 224]


**Heap allocations**:
Quoting the Sodium-manual: "Cryptographic operations in Sodium (C binary) never allocate memory on the heap (malloc, calloc, etc) with the obvious exceptions of crypto_pwhash and sodium_malloc."<br>
The same holds, if usage is restricted to sodium:deimos  and also holds for many functions of sodium:wrapper.<br>

Windows:
While it get's built, I recommend to stay away from the -m32_mscoff (--arch=x86_mscoff) build currently:
1. DUB (1.2.1) doesn't handle that correctly.
2. unittest of wrapper.crypto_aead_aes256gcm.d fails for crypto_aead_aes256gcm_beforenm for some unknown reason (same compiler, code and .dll as for -m32, only import lib/format of .obj/linker differ)
