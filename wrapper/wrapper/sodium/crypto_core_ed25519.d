/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_core_ed25519_H
*/

module wrapper.sodium.crypto_core_ed25519;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_core_ed25519;
