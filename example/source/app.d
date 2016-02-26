#!/usr/bin/rdmd -I../../source/
import std.stdio : writeln;
import sodium;
//import sodium.core : sodium_init;
//import sodium.randombytes : randombytes_buf;

pragma(lib, "sodium");

int main()
{
        // Manual sodium, chapter "Usage":
	if (sodium_init == -1) {
		return 1;
	}

	// Manual sodium, chapter "Generating random data":
	ubyte[8] buf;
	randombytes_buf(buf.ptr, buf.sizeof);
	writeln("Unpredictable sequence of 8 bytes: ", buf);
	return 0;
}
