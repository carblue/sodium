#!/usr/bin/rdmd @cmdfile
import std.stdio;
import sodium;
pragma(lib, "sodium");

int main()
{
        // Manual sodium, chapter "Usage":
	if (sodium_init == -1) {
		return 1;
	}
	//sodium_init; // An error, if warnings are enabled! The compiler warns about unused function return value and bails out

	// Manual sodium, chapter "Generating random data":
	ubyte[8] buf;
	randombytes_buf(buf.ptr, buf.sizeof);
	writeln("Unpredictable sequence of 8 bytes: ", buf);
	return 0;
}
