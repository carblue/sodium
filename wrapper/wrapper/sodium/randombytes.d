// Written in the D programming language.

/* WARNING: randombytes_set_implementation isn't straightaway accessible from 'wrapper' and shouldn't be used through 'deimos' either, except You know the inner working of sodium_init ! */

/**
 * Functions related to randomness.
 */

module wrapper.sodium.randombytes;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.randombytes :
//                                  randombytes_implementation,
                                    randombytes_BYTES_MAX,
                                    randombytes_SEEDBYTES,
                                    randombytes_seedbytes,
//                                  randombytes_buf,
//                                  randombytes_buf_deterministic,
                                    randombytes_random,
                                    randombytes_uniform,
                                    randombytes_stir,
                                    randombytes_close;
/*                                  randombytes_set_implementation,
                                    randombytes_implementation_name,
                                    randombytes; */

import std.string : fromStringz; // @system


// overloading some functions between module deimos.sodium.randombytes and this module


/** The randombytes_buf() function fills `size` bytes starting at buf with an unpredictable sequence of bytes. */
alias randombytes_buf  = deimos.sodium.randombytes.randombytes_buf;

/** The randombytes_buf() function fills the array `buf` with an unpredictable sequence of bytes. */
pragma(inline, true)
void randombytes_buf(scope ubyte[] buf) @nogc nothrow @trusted
{
//  enforce(buf !is null, "buf is null"); // not necessary
    randombytes_buf(buf.ptr, buf.length); // __attribute__ ((nonnull));
}

alias randombytes_buf_deterministic  = deimos.sodium.randombytes.randombytes_buf_deterministic;

pragma(inline, true)
void randombytes_buf_deterministic(ubyte[] buf, const ubyte[randombytes_SEEDBYTES] seed) @nogc nothrow pure @trusted
{
//  enforce(buf !is null, "buf is null"); // not necessary
    randombytes_buf_deterministic(buf.ptr, buf.length, seed); // __attribute__ ((nonnull));
}

/*
 We can't trust in general to receive a valid address from randombytes_implementation_name() to be evaluated as a null-terminated C string, except
 randombytes_set_implementation wasn't used or used to reset to a sodium-supplied implementaion or used and a valid implementation_name function supplied.
 Now randombytes_set_implementation isn't straightaway accessible !
*/
string randombytes_implementation_name() @nogc nothrow @trusted
{
    import std.exception : assumeUnique;
    static import deimos.sodium.randombytes;
    const(char)[] c_arr;
    try
        c_arr = fromStringz(deimos.sodium.randombytes.randombytes_implementation_name());
    catch (Exception t) { /* known not to throw */}
    return assumeUnique(c_arr);
}

alias randombytes     = deimos.sodium.randombytes.randombytes;

/** The randombytes() function fills the array `buf` with an unpredictable sequence of bytes. */
pragma(inline, true)
void randombytes(scope ubyte[] buf) @nogc nothrow @trusted
{
//  enforce(buf !is null, "buf is null"); // not necessary
    randombytes(buf.ptr, buf.length); // __attribute__ ((nonnull));
}

// InputRange interface

/// InputRange interface to random ubytes (based on calls to randombytes_random())
auto randombytes_range() @nogc nothrow @trusted
{
    /**
     * An InputRange representing an infinite, randomly generated sequence of ubytes
     */
    static struct RandomBytes_Range {
        enum  chunk_size                = 4;
        uint  randombytes_random_result = void;
        ubyte randombytes_random_index  = 0;
        bool  refresh_required          = true; // be lazy and don't refresh in popFront()

        enum empty = false;
        @property ubyte front() {
            if (refresh_required) {
                randombytes_random_result = randombytes_random();
                refresh_required = false;
            }
            return *(cast(ubyte*)&randombytes_random_result + randombytes_random_index);
        }

        void popFront() {
            randombytes_random_index = ++randombytes_random_index % chunk_size;
            if (!randombytes_random_index)
                refresh_required = true;
        }

        int opApply(int delegate(ubyte) operations) {
            int result = 0;
            for ( ; !empty ; popFront) {
                result = operations(front);
                if (result)
                    break;
            }
            return result;
        }
/+ instead use enumerate
  int opApply(int delegate(size_t, ubyte) operations) {
    int result = 0;
    size_t counter;
    for ( ; !empty ; popFront) {
      result = operations(counter, front);
      ++counter;
      if (result)
        break;
    }
    return result;
  }
+/
    } // struct RandomBytes_Range

    return RandomBytes_Range();
}


version(QRNG_ONLINE) {
    /*
      Probably no public interest, thus wrapper/sodium/QRNG.d is not provided

      This is an interface to QRNG Service, https://qrng.physik.hu-berlin.de/,
         specifically an interface to "online/live API" opposed to "file based random data" QRNG Service.
      There is the project https://code.dlang.org/packages/quantum-random as well, which deals with QRNG.
      QRNG: quantum random number generator, based on the quantum randomness of photon arrival times
      Server Status: offline since 6/4/2019 06:40
      Server Stats: 1,427,783,703,486,414 random Bytes (1.27 PB) delivered since November 2010.

      See also Random number servers: https://en.wikipedia.org/wiki/List_of_random_number_generators
    */
    import wrapper.sodium.QRNG;
    alias QRNG_randombytes_range = wrapper.sodium.QRNG.QRNG_randombytes_range;
}

@system
unittest
{
    import std.stdio : writeln, writefln;
    import std.algorithm.searching : any, all;
    import std.algorithm.comparison : equal;
    import std.range : array, take, enumerate, iota;
    debug  writeln("unittest block 1 from sodium.randombytes.d");

    ubyte[] buf = new ubyte[8];
    assert(!any(buf)); // none of buf evaluate to true

//randombytes_buf
    randombytes_buf(buf.ptr, buf.length);
    assert( any(buf));
    writefln("Unpredictable sequence of %s bytes: %s", buf.length, buf);

//randombytes_implementation_name
    {
        static import deimos.sodium.randombytes;
        writeln("deimos.sodium.randombytes.randombytes_implementation_name():  ", fromStringz(deimos.sodium.randombytes.randombytes_implementation_name()));
    }
//randombytes
    buf[] = ubyte.init;
    assert(!any(buf)); // none of buf evaluate to true
    randombytes(buf.ptr, buf.length);
    assert( any(buf));
    writefln("Unpredictable sequence of %s bytes: %s", buf.length, buf);

    foreach (i,element; randombytes_range().take(8).enumerate(1))
    { /* writefln("%s: %02X", i, element); */ }
//  writeln;

    int cnt;
    foreach (element; randombytes_range()) {
        if (++cnt > 8)
            break;
//    writefln("%s: %02X", cnt, element);
    }

    ubyte[] populated_from_infinite_range = array(randombytes_range().take(8));
//  writefln("0x %(%02X %)", populated_from_infinite_range);

//randombytes_buf_deterministic
    immutable ubyte[randombytes_SEEDBYTES] seed = array(iota(ubyte(0), randombytes_SEEDBYTES))[];
    randombytes_buf_deterministic(buf.ptr, buf.length, seed);

debug(TRAVIS_TEST)
{
    /*
      This block runs successfully but is disabled in regular builds as it does dubious actions; only for a test run by travis/code coverage):
      The documentation says about function randombytes_set_implementation:
      "This function should only be called once, before sodium_init()."
      As we are calling after sodium_init() and twice:
      Thus for testing during development, debug(TRAVIS_TEST) may be 'activated' temporarily.
     */
    extern(C) const(char)* dummy_implementation_name()
    {
        static const(char)[] str = "dummy" ~ '\0';
        return str.ptr;
    }

    extern(C) uint dummy_random()
    {
        return 1234567890;
    }

    extern(C) void dummy_buf(void* buf, const size_t size)
    {
        import core.stdc.string : memcpy;
        size_t len_remaining = size;
        ubyte[] buffer_ubyte = new ubyte[size];
        while (len_remaining) {
            buffer_ubyte[size-len_remaining] = len_remaining % 0xff;
            --len_remaining;
        }
        memcpy(buf, buffer_ubyte.ptr, buffer_ubyte.length);
    }

    static import deimos.sodium.randombytes;
    extern(C) __gshared deimos.sodium.randombytes.randombytes_implementation  randombytes_dummy_implementation;
    randombytes_dummy_implementation.implementation_name = &dummy_implementation_name;
    randombytes_dummy_implementation.random              = &dummy_random;
    randombytes_dummy_implementation.buf                 = &dummy_buf;
    {
        deimos.sodium.randombytes.randombytes_set_implementation(&randombytes_dummy_implementation);// __attribute__ ((nonnull));
        scope(exit) { // reestablish the default
            import wrapper.sodium.randombytes_sysrandom;
            deimos.sodium.randombytes.randombytes_set_implementation(&randombytes_sysrandom_implementation);
        }
        // test our non-random number generator being set and working as expected
        ubyte[] buffer = new ubyte[8];
        assert(!any(buffer)); // none of buf evaluate to true
//randombytes_buf
        randombytes_buf(buffer.ptr, buffer.length);
        assert(equal(buffer, [8, 7, 6, 5, 4, 3, 2, 1]));
        writefln("  predictable sequence of %s bytes: %s", buffer.length, buffer);

//randombytes_random
        uint   predictable = randombytes_random();
        assert(predictable == 1234567890);
        writeln("  predictable uint: ", predictable);

//randombytes_implementation_name
        string impl_name = randombytes_implementation_name();
        assert(impl_name == "dummy");
        writeln("wrapper.sodium.randombytes.randombytes_implementation_name(): ", impl_name);
    }
} // debug(TRAVIS_TEST)
}

@safe
unittest
{
    import std.stdio : writeln, writefln;
    import std.algorithm.searching : any, all;
    import std.range : iota, array, take, takeExactly;

    writeln("unittest block 2 from sodium.randombytes.d");

    assert(randombytes_SEEDBYTES == randombytes_seedbytes());

//randombytes_random
    debug  writeln("Unpredictable uint: ", randombytes_random());

//randombytes_uniform
    debug  writeln("Unpredictable uint between 0 and 48: ", randombytes_uniform(49));
/*
  uint[] six_outof_49;
  do {
     uint r = randombytes_uniform(49) +1;
     if (!canFind(six_outof_49, r))
       six_outof_49 ~= r;
  } while (six_outof_49.length<6);
  sort(six_outof_49);
  writeln(six_outof_49);
*/

//randombytes_close
    randombytes_close();
//randombytes_stir
    randombytes_stir();

//randombytes_implementation_name
    string impl_name = randombytes_implementation_name();
    writeln("wrapper.sodium.randombytes.randombytes_implementation_name(): ", impl_name);
    assert(impl_name == "sysrandom");

//randombytes
    ubyte[] buf = new ubyte[8];
    assert(!any(buf)); // none of buf evaluate to true

    randombytes(buf);
    assert( any(buf));
    randombytes(null); // whether randombytes accepts null though it's attributed __attribute__ ((nonnull));
    randombytes_buf(buf);

//randombytes_buf_deterministic
    immutable ubyte[randombytes_SEEDBYTES] seed = array(iota(ubyte(0), randombytes_SEEDBYTES))[];
    randombytes_buf_deterministic(buf, seed);
}

@nogc @safe
unittest {
    ubyte[4] a;
    ubyte[randombytes_SEEDBYTES] seed;
    randombytes(a);
    randombytes_buf_deterministic(a, seed);
}
