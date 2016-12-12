# sodium


D language: Deimos-like binding to libsodium, current C-source version 1.0.11, released on 31. Jul 2016 [https://github.com/jedisct1/libsodium]

Example, using rdmd:
cd example/source  &&  chmod 775 app.d  &&  ./app.d

Expected output (byte values within brackets differing of course):

Unpredictable sequence of 8 bytes: [52, 225, 21, 245, 74, 66, 192, 247]<br>
crypto_aead_aes256gcm_is_available<br>
ciphertext: [76, 18, 112, 219, 144, 230, 206, 219, 40, 255, 78, 43, 172, 49, 129, 175, 4, 235, 81, 224]

The files are going to receive unittests (showing more usage examples) and some wrappers/overloads for some functions to ease usage from D (if possible with attribute @strusted)<br>
Primarily the unittests are not meant to test correct behavior of C source code, but that (and how) functions are accessible from D as intended and an emphasis on the new 
wrapper functions, many of them callable from @safe code. The level of security set by function attributes is max @trusted. 
I think, the successfull run of unittests justifies that.<br>
Some files contain more information about unittest build, versioning issues, function attributes etc., notably version_.d, utils.d, core.d

Heap allocations:
"Cryptographic operations in Sodium (C binary) never allocate memory on the heap (malloc, calloc, etc) with the obvious exceptions of crypto_pwhash and sodium_malloc."<br>
The same holds, if usage of files is restricted to C_to_D_translated functions, i.e. extern(C) functions.<br>
The case is different, more complex with unitests and new wrappers/overloads:<br>
1. The unittests make permissive use of heap allocations by means of GC allocated memory, but don't handle real secrets, thus no security problem.<br>
2. Most new functions are "overloads" (just D friendly wrappers around the C_to_D_translated functions).<br>
  Some are as simple as taking a D slice and pass it's .ptr and .length to be safe or require a static array to ensure .length, thus don't themselves allocate heap memory and have attribute @nogc (and calling them doesn't postulate heap allocation either; the D slice parameter is welcoming arguments being static arrays as well as dyn. heap allocated arrays).<br>
  Many functions call enforce to ensure, that some requirement is fullfilled, thus may allocate, but no sensible data are involved.<br>
  The residual: They use heap allocation
3. Other functions perform procedures or part of procedures shown in the Sodium documentaion, like DH keyexchange and may make generous use of heap memory.