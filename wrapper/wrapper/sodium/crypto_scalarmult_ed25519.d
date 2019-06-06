/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define crypto_scalarmult_ed25519_H
*/

module wrapper.sodium.crypto_scalarmult_ed25519;

version(SODIUM_LIBRARY_MINIMAL) {}
else {

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_scalarmult_ed25519;

}
