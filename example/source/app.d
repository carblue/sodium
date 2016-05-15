#!/usr/bin/rdmd @cmdfile
import core.stdc.stdlib : EXIT_SUCCESS, EXIT_FAILURE;
import std.stdio : writefln, writeln;
import sodium;
version(DigitalMars) { pragma(lib, "sodium"); }

int main()
{
	// Manual sodium, chapter "Usage":
	//synchronized { // if sodium_init could be executed by multiple threads simultaneously
	if (sodium_init == -1) {
		return EXIT_FAILURE;
	}
	//}
	//sodium_init; // An error, if warnings are enabled! The compiler (DMD since 2.066.0) warns about unused/discarded function return value and bails out

	// Manual sodium, chapter "Generating random data":
	ubyte[8] buf;
	if (buf.sizeof <= 256) // limit, that linux guarantees by default, using getrandom(); figure can be higher with added True Random Number Generator
		randombytes_buf(buf.ptr, buf.sizeof);
	writefln("Unpredictable sequence of %s bytes: %s", buf.sizeof, buf);

/* */
	// Secret-key authentication example
	auto MESSAGE = cast(immutable(ubyte)[4]) "test";

	if (crypto_aead_aes256gcm_is_available) {
		writeln("crypto_aead_aes256gcm_is_available");
		auto ADDITIONAL_DATA = cast(immutable(ubyte)[6]) "123456";
		ubyte[crypto_aead_aes256gcm_NPUBBYTES] nonce;
		ubyte[crypto_aead_aes256gcm_KEYBYTES]  key;
		ubyte[MESSAGE.sizeof + crypto_aead_aes256gcm_ABYTES] ciphertext;
		ulong ciphertext_len;

		randombytes_buf(key.ptr, key.sizeof);
		randombytes_buf(nonce.ptr, nonce.sizeof);

		crypto_aead_aes256gcm_encrypt(ciphertext.ptr, &ciphertext_len,
                                  MESSAGE.ptr, MESSAGE.sizeof,
                                  ADDITIONAL_DATA.ptr, ADDITIONAL_DATA.sizeof,
                                  null, nonce.ptr, key.ptr);

		writeln("ciphertext: ", ciphertext);
		ubyte[MESSAGE.sizeof] decrypted;
		ulong decrypted_len;
		if (ciphertext_len < crypto_aead_aes256gcm_ABYTES ||
			crypto_aead_aes256gcm_decrypt(decrypted.ptr, &decrypted_len,
                                    null,
                                    ciphertext.ptr, ciphertext_len,
                                    ADDITIONAL_DATA.ptr,
                                    ADDITIONAL_DATA.sizeof,
                                    nonce.ptr, key.ptr) != 0) {
			writeln("The message has been forged!");
		}
	}
	else {
		writeln("NOT crypto_aead_aes256gcm_is_available");
		ubyte[crypto_auth_KEYBYTES] key;
		ubyte[crypto_auth_BYTES]    mac;

		randombytes_buf(key.ptr, key.sizeof);
		crypto_auth(mac.ptr, MESSAGE.ptr, MESSAGE.sizeof, key.ptr);

		if (crypto_auth_verify(mac.ptr, MESSAGE.ptr, MESSAGE.sizeof, key.ptr) != 0)
			writeln("The message has been forged!");
	}
/* */
	return EXIT_SUCCESS;
}
