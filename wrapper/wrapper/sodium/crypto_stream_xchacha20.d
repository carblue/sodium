// Written in the D programming language.

module wrapper.sodium.crypto_stream_xchacha20;

version(SODIUM_LIBRARY_MINIMAL) {}
else {

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_stream_xchacha20;

}
