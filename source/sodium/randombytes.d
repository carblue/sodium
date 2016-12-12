module sodium.randombytes;

extern(C) {

struct randombytes_implementation
{
	const(char)* function()                          implementation_name; /* required */
	uint         function()                          random;              /* required */
	void         function()                          stir;                /* optional */
	uint         function(in uint upper_bound)       uniform;             /* optional, a default implementation will be used if NULL */
	void         function(void* buf, in size_t size) buf;                 /* required */
	int          function()                          close;               /* optional */
}
	
pure @nogc :

/** The randombytes_buf() function fills size bytes starting at buf with an unpredictable sequence of bytes. */
void randombytes_buf(void* buf, in size_t size) nothrow @system;
	
/** The randombytes_random() function returns an unpredictable value between uint.min and uint.max (included). */
uint randombytes_random() @trusted;

/**The randombytes_uniform() function returns an unpredictable value between 0 and upper_bound (excluded).
 * Unlike randombytes_random() % upper_bound, it does its best to guarantee a uniform distribution of the possible output values.
 */
uint randombytes_uniform(in uint upper_bound) @trusted;

/** The randombytes_stir() function reseeds the pseudo-random number generator, if it supports this operation.
 * Calling this function is not required with the default generator, even after a fork() call,
 * unless the descriptor for /dev/urandom was closed using randombytes_close().
 * If a non-default implementation is being used (see randombytes_set_implementation()),
 * randombytes_stir() must be called by the child after a fork() call.
 */
void randombytes_stir() nothrow @trusted;

/** randombytes_close() deallocates the global resources used by the pseudo-random number generator.
 * More specifically, when the /dev/urandom device is used, it closes the descriptor.
 * Explicitly calling this function is almost never required.
 */
int randombytes_close() @trusted;

int randombytes_set_implementation(randombytes_implementation* impl) @system;

const(char)* randombytes_implementation_name() @system;

/* -- NaCl compatibility interface -- */
void randombytes(ubyte* buf, in ulong buf_len) nothrow @system;


} // extern(C)


/*  END OF TRANSLATED HEADER */



/* overloaded functions */

import std.exception : enforce, assumeWontThrow, assumeUnique;

/** The randombytes_buf() function fills the ubyte array buf with an unpredictable sequence of bytes. */
void randombytes_buf(ubyte[] buf) pure nothrow @nogc @trusted
{
  randombytes_buf(buf.ptr, buf.length);
}

/**
 Intention is to overload C function      randombytes_implementation_name,
 but missing parameters force a new name: randombytes_implementation_nameD (didn't want to introduce an arbitrary unused parameter)
 We can't trust in general to receive a valid address from randombytes_implementation_name() to be evaluated as a null-terminated C string, except
 randombytes_set_implementation wasn't used or used to reset to a sodium-supplied implementaion or used and a valid implementation_name function supplied.
*/
string randombytes_implementation_nameD() pure nothrow @nogc @system
{
  import std.string : fromStringz; // @system
  const(char)[] c_arr;
  try
    c_arr = fromStringz(randombytes_implementation_name());
  catch (Exception e) { /* Known not to throw */}
  return c_arr;
}

void randombytes(ubyte[] buf) pure nothrow @nogc @trusted
{
//  enforce(buf !is null, "buf is null"); // not necessary
  return  randombytes(buf.ptr, buf.length);
}


@system
unittest
{
  import std.stdio : writeln, writefln, printf;
  import std.algorithm.searching : any, all;
  import std.algorithm.comparison : equal;
  debug  writeln("unittest block 1 from sodium.randombytes.d");

  ubyte[] buf = new ubyte[8];
  assert(!any(buf)); // none of buf evaluate to true

//randombytes_buf
	randombytes_buf(buf.ptr, buf.length);
  assert( any(buf));
	writefln("Unpredictable sequence of %s bytes: %s", buf.length, buf);

//randombytes_implementation_name
  printf("randombytes_implementation from function randombytes_implementation_name():  %s\n", randombytes_implementation_name());

//randombytes
  buf[] = ubyte.init;
  assert(!any(buf)); // none of buf evaluate to true
  randombytes(buf.ptr, buf.length);
  assert( any(buf));
	writefln("Unpredictable sequence of %s bytes: %s", buf.length, buf);

version(none)
{
/*
  This block runs successfully but is disabled for security reason:
  The documentation says about function randombytes_set_implementation:
  "This function should only be called once, before sodium_init()."
  As we are calling after sodium_init():
  Thus for testing during development, version(none) may be changed to version(all) temporarily, but not for a build like dmd ... -unittest -release
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

  extern(C) void dummy_buf(void* buf, in size_t size)
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

  extern(C) __gshared randombytes_implementation  randombytes_dummy_implementation;
  randombytes_dummy_implementation.implementation_name = &dummy_implementation_name;
  randombytes_dummy_implementation.random              = &dummy_random;
  randombytes_dummy_implementation.buf                 = &dummy_buf;
  {
    randombytes_set_implementation(&randombytes_dummy_implementation);
    scope(exit) { // reestablish the default
      version (__native_client__) {
        import sodium.randombytes_nativeclient;
        randombytes_set_implementation(&randombytes_nativeclient_implementation);
      }
      else {
        import sodium.randombytes_sysrandom;
        randombytes_set_implementation(&randombytes_sysrandom_implementation);
      }
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
    string impl_name = randombytes_implementation_nameD();
    assert(impl_name == "dummy");
    writeln("  randombytes_implementation from function randombytes_implementation_nameD(): ", impl_name);
  }
}
}

@safe
unittest
{
  import std.stdio : writeln;
  import std.algorithm.searching : any, all;
  debug {
    writeln("unittest block 2 from sodium.randombytes.d");
  }

  ubyte[] buf = new ubyte[8];
  assert(!any(buf)); // none of buf evaluate to true

//randombytes_buf
	(() @trusted => randombytes_buf(buf.ptr, buf.length))();
  assert( any(buf));
//  writefln("Unpredictable sequence of %s bytes: %s", buf.length, buf);

//randombytes_random
  writeln("Unpredictable uint: ", randombytes_random());

//randombytes_uniform
  writeln("Unpredictable uint between 0 and 48: ", randombytes_uniform(49));
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
  string impl_name = (() @trusted => randombytes_implementation_nameD())();
  writeln("randombytes_implementation from function randombytes_implementation_nameD(): ", impl_name);
  version (__native_client__) {}
  else 
    assert(impl_name == "sysrandom");

//randombytes
  randombytes(buf);
  assert( any(buf));
  randombytes(null);
}
