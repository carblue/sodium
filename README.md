**Build state**

[![Build Status](https://travis-ci.org/carblue/sodium.svg?branch=master)](https://travis-ci.org/carblue/sodium)
[![Build status](https://ci.appveyor.com/api/projects/status/2k14jpgh2grshq13/branch/master?svg=true)](https://ci.appveyor.com/project/carblue/sodium/branch/master)
[![Coverage Status](https://coveralls.io/repos/github/carblue/sodium/badge.svg?branch=master)](https://coveralls.io/github/carblue/sodium?branch=master)

# sodium

Twofold binding to [libsodium](https://libsodium.org "https://libsodium.org"), a modern, portable, easy to use crypto library; support of current libsodium version v1.0.18, released  May 31, 2019.

subPackage `deimos`:  The "import-only" C header's declarations.<br>
subPackage `wrapper`: The content of `deimos` + some 'D-friendly' stuff, predominantly overloaded functions and unittests.

The dependency name is either `sodium:deimos` or `sodium:wrapper` (for dub build|test simply: `:deimos` or `:wrapper`)

IMPORTANT NOTICE<br>
If not linking against v1.0.18 binary libsodium.so/.dll/.dylib, it's required to specify that in deimos/dub.json and wrapper/dub.json:<br>
In the past while I maintained this binding, it was kind of independent from binary libsodium versions: The last binding release supporting headers of libsodium 1.016 could be used with a binary versioned e.g. 1.014 or 1.018, because in C headers (so far) only functions where added, and the compiler/linker would complain, if (new) functions not available from the (older) binary/import library should be called. This also holds for Windows, if You don't trick the compiler with a non-associated pair of import .lib/binary .dll.<br>
Now for the first time (since v1.0.17 and again in 1.0.18) a constant changed it's value  as well as a struct size change occured and the easy times are gone.<br>
This is solved by conditional compilation, which is guided by the following version identifiers: bin_v1_0_18, bin_v1_0_17 and bin_v1_0_16 (bin_v1_0_16 subsumes any libsodium binary version lower than v1.0.16 as well). The dub.json s set bin_v1_0_18 as default, stating the binary version expected to link against.

A version mismatch of binding-adaption and libsodium binary can do any harm as undefined behavior can do, like memory corruption or worse, a SIGSEGV in the best case.

(The versioning of this binding doesn't matter here, but to make things more intuitive, it'll change to reflect the latest (libsodium C source) header version covered, the next/this will be something like 1.0.18-alpha.1).<br>


`wrapper` is based on [DIP1008](https://github.com/dlang/DIPs/blob/master/DIPs/DIP1008.md "https://github.com/dlang/DIPs/blob/master/DIPs/DIP1008.md")/compiler switch -dip1008; this rules out the gdc compiler currently (I didn't find any info about that). dmd/ldc support it since 2.078.3.<br>
DIP1008 is the enabling feature used for @nogc exceptions, implemented via dependency package [nogc](https://code.dlang.org/packages/nogc "https://code.dlang.org/packages/nogc").<br>
`wrapper` also supports usage of -dip1000 (includes -dip25). dub build|test :wrapper --config=travis uses that but it's not set as default for any other configuration.<br>
END_NOTICE

`wrapper` aims at providing at least the same functionality as `deimos` and provide @trusted @nogc (possibly also pure nothrow) 'D-friendly' alternatives, that are hard to use in a wrong way; [WIP]:<br>
a) 'wrapper' is a superset of 'deimos' in that everything from 'deimos' is reachable, but deliberately not all at your fingertips.<br>
b) all new functions with 'deimos-functionality' have the same name as their 'deimos'-cousins and call them, building either overload sets to choose from, or for parameter-less functions, 'substituting' their cousins.<br>
c) all new functions calculating a variable-length output are restrictive referring to the size of the output-buffer offered, if the required size can be easily known/computed in advance, throwing (a NoGcException) in case of wrong-sized buffers.<br>
   This way, if a function succeeds, all output-buffer.length bytes are meaningful and no additional/'deimos'-like function out parameter carrying the meaningful length information is required.<br>
d) Exceptions thrown while checking valid function arguments are NOT allocated by GC, enabling @nobc attribue usage.<br>
e) No need to explicitely call sodium_init() up-front (wrapper.sodium.core:shared static this() calls it).<br>
f) A few functions with int return type expressing true or false have bool return type in 'wrapper'.
g) Usage of 'wrapper' isn't possible, if function `randombytes_set_implementation` shall be used.

The unittests of subPackage 'wrapper' include a lot of function usage examples; the next is a simple application example, using rdmd and file cmdfile,
suitable as is for Linux with libsodium.so available (otherwise example/source/cmdfile and/or first line of app.d might need adaption):<br>

`$ cd example/source  &&  chmod +x app.d  &&  ./app.d`

Expected output (byte values within brackets differing of course):<br>

```
Unpredictable sequence of 8 bytes: [52, 225, 21, 245, 74, 66, 192, 247]
crypto_aead_aes256gcm_is_available
ciphertext: [76, 18, 112, 219, 144, 230, 206, 219, 40, 255, 78, 43, 172, 49, 129, 175, 4, 235, 81, 224]
```


**Heap allocations**:
Quoting the Sodium-manual: "Cryptographic operations in Sodium (C binary) never allocate memory on the heap (malloc, calloc, etc.) with the obvious exceptions of crypto_pwhash and sodium_malloc."<br>
The same holds, if usage is restricted to sodium:deimos  and also holds for many (@nogc) functions of sodium:wrapper.<br>
