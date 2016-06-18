# sodium


D language: Deimos-like binding to libsodium, current C-source version 1.0.10, released on 5. Apr 2016 [https://github.com/jedisct1/libsodium]

Example, using rdmd:
cd example/source && ./app.d

Expected output (numbers within brackets differing of course):

Unpredictable sequence of 8 bytes: [52, 225, 21, 245, 74, 66, 192, 247]
crypto_aead_aes256gcm_is_available
ciphertext: [76, 18, 112, 219, 144, 230, 206, 219, 40, 255, 78, 43, 172, 49, 129, 175, 4, 235, 81, 224]

