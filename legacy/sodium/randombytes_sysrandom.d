module sodium.randombytes_sysrandom;

import sodium.randombytes;

// is this always available, or only when __native_client__ is not defined ?
extern(C) extern __gshared randombytes_implementation  randombytes_sysrandom_implementation;
