/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define randombytes_internal_random_H
*/

module deimos.sodium.randombytes_internal_random;

import deimos.sodium.randombytes : randombytes_implementation;


extern(C) extern __gshared randombytes_implementation randombytes_internal_implementation;

/* Backwards compatibility with libsodium < 1.0.18 */
alias randombytes_salsa20_implementation = randombytes_internal_implementation;
