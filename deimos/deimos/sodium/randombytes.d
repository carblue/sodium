/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define randombytes_H
*/

module deimos.sodium.randombytes;

import deimos.sodium.export_;


extern(C) @nogc nothrow :


struct randombytes_implementation {
  const(char)* function()                             implementation_name; /* required */
  uint         function()                             random;              /* required */
  void         function()                             stir;                /* optional */
  uint         function(const uint upper_bound)       uniform;             /* optional, a default implementation will be used if null */
  void         function(void* buf, const size_t size) buf;                 /* required */
  int          function()                             close;               /* optional */
}

enum randombytes_BYTES_MAX = SODIUM_MIN(SODIUM_SIZE_MAX, 0xffffffffU);

/* my understanding of the pure attribute in D is, that the following functions (except randombytes_seedbytes and randombytes_buf_deterministic)
   are impure: they depend on hidden global mutable state */


enum ubyte randombytes_SEEDBYTES = 32U;

size_t randombytes_seedbytes() pure @trusted;

void randombytes_buf(void* buf, const size_t size); // __attribute__ ((nonnull));

void randombytes_buf_deterministic(void* buf, const size_t size,
                                   ref const(ubyte)[randombytes_SEEDBYTES] seed) pure; // __attribute__ ((nonnull));

uint randombytes_random() @trusted;

uint randombytes_uniform(const uint upper_bound) @trusted;

void randombytes_stir() @trusted;

int randombytes_close() @trusted;

int randombytes_set_implementation(randombytes_implementation* impl); // __attribute__ ((nonnull));

const(char)* randombytes_implementation_name();

/* -- NaCl compatibility interface -- */

void randombytes(ubyte* buf, const ulong buf_len); // __attribute__ ((nonnull));
