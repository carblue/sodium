/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define randombytes_sysrandom_H
*/

module sodium.randombytes_sysrandom;

import sodium.randombytes : randombytes_implementation;


extern(C) extern __gshared randombytes_implementation randombytes_sysrandom_implementation;
