// Written in the D programming language.

module wrapper.sodium.crypto_secretbox_xsalsa20poly1305;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_secretbox_xsalsa20poly1305 : crypto_secretbox_xsalsa20poly1305_KEYBYTES,
                                                          crypto_secretbox_xsalsa20poly1305_keybytes,
                                                          crypto_secretbox_xsalsa20poly1305_NONCEBYTES,
                                                          crypto_secretbox_xsalsa20poly1305_noncebytes,
                                                          crypto_secretbox_xsalsa20poly1305_MACBYTES,
                                                          crypto_secretbox_xsalsa20poly1305_macbytes,
/*                                                        crypto_secretbox_xsalsa20poly1305_BOXZEROBYTES,
                                                          crypto_secretbox_xsalsa20poly1305_boxzerobytes,
                                                          crypto_secretbox_xsalsa20poly1305_ZEROBYTES,
                                                          crypto_secretbox_xsalsa20poly1305_zerobytes,
                                                          crypto_secretbox_xsalsa20poly1305,
                                                          crypto_secretbox_xsalsa20poly1305_open,    */
                                                          crypto_secretbox_xsalsa20poly1305_keygen;
