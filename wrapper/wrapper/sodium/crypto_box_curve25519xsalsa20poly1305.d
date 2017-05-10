/*
// Written in the D programming language.

module wrapper.sodium.crypto_box_curve25519xsalsa20poly1305;

import wrapper.sodium.core; // assure sodium got initialized

public
import deimos.sodium.crypto_box_curve25519xsalsa20poly1305;
*/
// Written in the D programming language.

module wrapper.sodium.crypto_box_curve25519xsalsa20poly1305;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_box_curve25519xsalsa20poly1305: crypto_box_curve25519xsalsa20poly1305_SEEDBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_seedbytes,
                                                             crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_publickeybytes,
                                                             crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_secretkeybytes,
                                                             crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_beforenmbytes,
                                                             crypto_box_curve25519xsalsa20poly1305_NONCEBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_noncebytes,
                                                             crypto_box_curve25519xsalsa20poly1305_MACBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_macbytes,
                                                             crypto_box_curve25519xsalsa20poly1305_BOXZEROBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_boxzerobytes,
                                                             crypto_box_curve25519xsalsa20poly1305_ZEROBYTES,
                                                             crypto_box_curve25519xsalsa20poly1305_zerobytes,
                                                             crypto_box_curve25519xsalsa20poly1305,
                                                             crypto_box_curve25519xsalsa20poly1305_open;
/*                                                           crypto_box_curve25519xsalsa20poly1305_seed_keypair,
                                                             crypto_box_curve25519xsalsa20poly1305_keypair,
                                                             crypto_box_curve25519xsalsa20poly1305_beforenm,
                                                             crypto_box_curve25519xsalsa20poly1305_afternm,
                                                             crypto_box_curve25519xsalsa20poly1305_open_afternm; */

import std.exception : assertThrown;


// overloading some functions between module deimos.sodium.crypto_box_curve25519xsalsa20poly1305 and this module

/* No overloads for -- NaCl compatibility interface ; Requires padding -- */

/+
alias crypto_box_curve25519xsalsa20poly1305   = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305;

//pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305(scope ubyte[] c,
                                            in ubyte[] m,
                                            in ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES] n,
                                            in ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES] pk,
                                            in ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES] sk) pure @trusted // __attribute__ ((warn_unused_result));
{
  enforce(c.length >= m.length + crypto_box_curve25519xsalsa20poly1305_MACBYTES, "Error invoking crypto_box_curve25519xsalsa20poly1305: out buffer too small");
  return  crypto_box_curve25519xsalsa20poly1305(c.ptr, m.ptr, m.length, n.ptr, pk.ptr, sk.ptr) == 0;
}

alias crypto_box_curve25519xsalsa20poly1305_open   = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_open;

//pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_open(scope ubyte[] m,
                                                 in ubyte[] c,
                                                 in ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES] n,
                                                 in ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES] pk,
                                                 in ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES] sk) pure @trusted // __attribute__ ((warn_unused_result));
{
  enforce(c.length >= crypto_box_curve25519xsalsa20poly1305_MACBYTES, "Error invoking crypto_box_curve25519xsalsa20poly1305_open: in buffer too small");
  enforce(m.length >= c.length - crypto_box_curve25519xsalsa20poly1305_MACBYTES, "Error invoking crypto_box_curve25519xsalsa20poly1305_open: out buffer too small");
  return  crypto_box_curve25519xsalsa20poly1305_open(m.ptr, c.ptr, c.length, n.ptr, pk.ptr, sk.ptr) == 0;
}
+/
alias crypto_box_curve25519xsalsa20poly1305_seed_keypair = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_seed_keypair;

pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_seed_keypair(out   ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES] pk,
                                                         out   ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES] sk,
                                                         const ubyte[crypto_box_curve25519xsalsa20poly1305_SEEDBYTES] seed) pure @nogc @trusted
{
  return  crypto_box_curve25519xsalsa20poly1305_seed_keypair(pk.ptr, sk.ptr, seed.ptr) == 0;
}

alias crypto_box_curve25519xsalsa20poly1305_keypair      = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_keypair;

pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_keypair(out ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES] pk,
                                                    out ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES] sk) nothrow @nogc @trusted
{
  return  crypto_box_curve25519xsalsa20poly1305_keypair(pk.ptr, sk.ptr) == 0;
}

/* -- Precomputation interface -- */

alias crypto_box_curve25519xsalsa20poly1305_beforenm = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_beforenm;

pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_beforenm(out   ubyte[crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES] k,
                                                     const ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES] pk,
                                                     const ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES] sk) pure nothrow @nogc @trusted // __attribute__ ((warn_unused_result));
{
  return  crypto_box_curve25519xsalsa20poly1305_beforenm(k.ptr, pk.ptr, sk.ptr) == 0;
}

alias crypto_box_curve25519xsalsa20poly1305_afternm = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_afternm;

pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_afternm(scope ubyte[] c,
                                                    scope const ubyte[] m,
                                                    const ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES] n,
                                                    const ubyte[crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES] k) @nogc @trusted
{
  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  return  crypto_box_curve25519xsalsa20poly1305_afternm(c.ptr, m.ptr, m.length, n.ptr, k.ptr) == 0;
}

alias crypto_box_curve25519xsalsa20poly1305_open_afternm = deimos.sodium.crypto_box_curve25519xsalsa20poly1305.crypto_box_curve25519xsalsa20poly1305_open_afternm;

pragma(inline, true)
bool  crypto_box_curve25519xsalsa20poly1305_open_afternm(scope ubyte[] m,
                                                         scope const ubyte[] c,
                                                         const ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES] n,
                                                         const ubyte[crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES] k) @nogc @trusted
{
  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  return  crypto_box_curve25519xsalsa20poly1305_open_afternm(m.ptr, c.ptr, c.length, n.ptr, k.ptr) == 0;
}


@system
unittest
{
//  import std.string : fromStringz;
//  import std.algorithm.comparison : equal;
  import std.string : representation;
  import std.stdio : writeln;
  import wrapper.sodium.randombytes;
  debug writeln("unittest block 1 from sodium.crypto_box_curve25519xsalsa20poly1305.d");

  ubyte[crypto_box_curve25519xsalsa20poly1305_SEEDBYTES] seed = void;
  randombytes_buf(seed.ptr, seed.length);
  ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES]  alice_publickey = void;
  ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES]  alice_secretkey = void;
  crypto_box_curve25519xsalsa20poly1305_seed_keypair(alice_publickey.ptr, alice_secretkey.ptr, seed.ptr);

  ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES]  bob_publickey = void;
  ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES]  bob_secretkey = void;
  crypto_box_curve25519xsalsa20poly1305_keypair(bob_publickey.ptr, bob_secretkey.ptr);
/*
  auto message = representation("12345678901234567890123456789012test");
  enum message_len = 4;
  ubyte[crypto_box_curve25519xsalsa20poly1305_ZEROBYTES + message_len]  decrypted;

  ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES]  nonce = void;
  randombytes_buf(nonce.ptr, nonce.length);
//  enum ciphertext_len = (crypto_box_curve25519xsalsa20poly1305_MACBYTES + message_len);
  ubyte[crypto_box_curve25519xsalsa20poly1305_MACBYTES + message_len]  ciphertext = void;

// Alice sends a message to Bob
  assert(crypto_box_curve25519xsalsa20poly1305(ciphertext.ptr, message.ptr, message.length, nonce.ptr, bob_publickey.ptr, alice_secretkey.ptr) == 0);
//writeln("ciphertext: ", ciphertext);
  crypto_box_curve25519xsalsa20poly1305_open(decrypted.ptr, ciphertext.ptr, 20, nonce.ptr, alice_publickey.ptr, bob_secretkey.ptr);
//writeln("decrypted:  ", decrypted);
*/
  ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES]  nonce = void;
  randombytes_buf(nonce.ptr, nonce.length);
  auto message = representation("12345678901234567890123456789012test");
  enum message_len = 4;
  ubyte[crypto_box_curve25519xsalsa20poly1305_ZEROBYTES+message_len]  ciphertext;
  ubyte[crypto_box_curve25519xsalsa20poly1305_ZEROBYTES+message_len]  decrypted;
  ubyte[crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES] shared_k = void;
  assert(crypto_box_curve25519xsalsa20poly1305_beforenm(shared_k.ptr, bob_publickey.ptr, alice_secretkey.ptr) == 0);
  assert(crypto_box_curve25519xsalsa20poly1305_afternm(ciphertext.ptr, message.ptr, message.length, nonce.ptr, shared_k.ptr) == 0);
//FIXME: wrong usage of crypto_box_curve25519xsalsa20poly1305_open_afternm
         crypto_box_curve25519xsalsa20poly1305_open_afternm(decrypted.ptr, ciphertext.ptr, ciphertext.length, nonce.ptr, shared_k.ptr);
}

@safe
unittest
{
  import std.string : representation;
  import std.stdio : writeln;
  import wrapper.sodium.randombytes;
  debug writeln("unittest block 2 from sodium.crypto_box_curve25519xsalsa20poly1305.d");

  ubyte[crypto_box_curve25519xsalsa20poly1305_SEEDBYTES] seed = void;
  randombytes(seed);

  ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES]  alice_publickey = void;
  ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES]  alice_secretkey = void;
  assert(crypto_box_curve25519xsalsa20poly1305_seed_keypair(alice_publickey, alice_secretkey, seed));

  ubyte[crypto_box_curve25519xsalsa20poly1305_PUBLICKEYBYTES]  bob_publickey = void;
  ubyte[crypto_box_curve25519xsalsa20poly1305_SECRETKEYBYTES]  bob_secretkey = void;
  assert(crypto_box_curve25519xsalsa20poly1305_keypair(bob_publickey, bob_secretkey));

  ubyte[crypto_box_curve25519xsalsa20poly1305_NONCEBYTES]  nonce = void;
  randombytes(nonce);
  auto message = representation("12345678901234567890123456789012test");
  enum message_len = 4;
  ubyte[crypto_box_curve25519xsalsa20poly1305_ZEROBYTES+message_len]  ciphertext;
  ubyte[crypto_box_curve25519xsalsa20poly1305_ZEROBYTES+message_len]  decrypted;
  ubyte[crypto_box_curve25519xsalsa20poly1305_BEFORENMBYTES] shared_k = void;
  assert(crypto_box_curve25519xsalsa20poly1305_beforenm(shared_k, bob_publickey, alice_secretkey));
  assert(crypto_box_curve25519xsalsa20poly1305_afternm(ciphertext, message, nonce, shared_k));
//FIXME: wrong usage of crypto_box_curve25519xsalsa20poly1305_open_afternm
         crypto_box_curve25519xsalsa20poly1305_open_afternm(decrypted, ciphertext, nonce, shared_k);
}
