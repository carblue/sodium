#!/usr/bin/rdmd @cmdfile
import core.stdc.stdlib : EXIT_SUCCESS, EXIT_FAILURE;
import std.stdio : writefln, writeln;
import sodium;
pragma(lib, "sodium");

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

/* * /
	// Secret-key authentication example, page 31
	auto MESSAGE = cast(immutable(ubyte)[4]) "test";

	ubyte[crypto_auth_KEYBYTES] key;
	ubyte[crypto_auth_BYTES]    mac;

	randombytes_buf(key.ptr, key.sizeof);
	crypto_auth(mac.ptr, MESSAGE.ptr, MESSAGE.sizeof, key.ptr);

	if (crypto_auth_verify(mac.ptr, MESSAGE.ptr, MESSAGE.sizeof, key.ptr) != 0)
		writeln("The massage has been forged!");
/ * */
	return EXIT_SUCCESS;
}
