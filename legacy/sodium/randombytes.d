/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define randombytes_H
*/

module sodium.randombytes;


extern(C) :


struct randombytes_implementation {
  const(char)* function()                             implementation_name; /* required */
  uint         function()                             random;              /* required */
  void         function()                             stir;                /* optional */
  uint         function(const uint upper_bound)       uniform;             /* optional, a default implementation will be used if null */
  void         function(void* buf, const size_t size) buf;                 /* required */
  int          function()                             close;               /* optional */
}


nothrow @nogc :
/* my understanding of the pure attribute in D is, that the following functions are impure; all depend on hidden global mutable state */


void randombytes_buf(void* buf, const size_t size) @system;

uint randombytes_random() @trusted;

uint randombytes_uniform(const uint upper_bound) @trusted;

void randombytes_stir() @trusted;

int randombytes_close() @trusted;

int randombytes_set_implementation(randombytes_implementation* impl) @system;

const(char)* randombytes_implementation_name() @system;

/* -- NaCl compatibility interface -- */

void randombytes(ubyte* buf, const ulong buf_len) @system;
