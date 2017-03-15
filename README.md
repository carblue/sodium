**Build state**

[![Build Status](https://travis-ci.org/carblue/sodium.svg?branch=master)](https://travis-ci.org/carblue/sodium)

# sodium


D language: Deimos-like binding to libsodium, current C-source version 1.0.12, released on Mar 12, 2017 [https://github.com/jedisct1/libsodium]

Some restructuring (subPackages)/changing importPath and sourcePath was done for version 0.1.0 (different from previous 0.08) in order to soon have a wrapper subPackage sit aside
subPackage deimos.<br>
Thus code that already used versions<0.1.0 needs to replace 'import sodium...' by 'import deimos.sodium...'.

Example, using rdmd:<br>
	cd example/source  &&  chmod 775 app.d  &&  ./app.d

Expected output (byte values within brackets differing of course):

Unpredictable sequence of 8 bytes: [52, 225, 21, 245, 74, 66, 192, 247]<br>
crypto_aead_aes256gcm_is_available<br>
ciphertext: [76, 18, 112, 219, 144, 230, 206, 219, 40, 255, 78, 43, 172, 49, 129, 175, 4, 235, 81, 224]
