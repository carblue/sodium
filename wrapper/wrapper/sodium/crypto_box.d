// Written in the D programming language.

module wrapper.sodium.crypto_box;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_box : crypto_box_SEEDBYTES,
                                   crypto_box_seedbytes,
                                   crypto_box_PUBLICKEYBYTES,
                                   crypto_box_publickeybytes,
                                   crypto_box_SECRETKEYBYTES,
                                   crypto_box_secretkeybytes,
                                   crypto_box_NONCEBYTES,
                                   crypto_box_noncebytes,
                                   crypto_box_MACBYTES,
                                   crypto_box_macbytes,
                                   crypto_box_MESSAGEBYTES_MAX,
                                   crypto_box_messagebytes_max,
                                   crypto_box_PRIMITIVE,
/*                                 crypto_box_primitive,
                                   crypto_box_seed_keypair,
                                   crypto_box_keypair,
                                   crypto_box_easy,
                                   crypto_box_open_easy,
                                   crypto_box_detached,
                                   crypto_box_open_detached, */
                                   crypto_box_BEFORENMBYTES,
                                   crypto_box_beforenmbytes,
/*                                 crypto_box_beforenm,
                                   crypto_box_easy_afternm,
                                   crypto_box_open_easy_afternm,
                                   crypto_box_detached_afternm,
                                   crypto_box_open_detached_afternm, */
                                   crypto_box_SEALBYTES,
                                   crypto_box_sealbytes;
/*                                 crypto_box_seal,
                                   crypto_box_seal_open,
                                   crypto_box_ZEROBYTES,
                                   crypto_box_zerobytes,
                                   crypto_box_BOXZEROBYTES,
                                   crypto_box_boxzerobytes,
                                   crypto_box,
                                   crypto_box_open,
                                   crypto_box_afternm,
                                   crypto_box_open_afternm;  */


import std.exception : assertThrown;



string crypto_box_primitive() pure nothrow @nogc @trusted
{
  import std.string : fromStringz;
  static import deimos.sodium.crypto_box;
  const(char)[] c_arr;
  try
    c_arr = fromStringz(deimos.sodium.crypto_box.crypto_box_primitive()); // strips terminating \0
  catch (Exception t) { /* known not to throw */ }
  return c_arr;
}

// overloading some functions between module deimos.sodium.crypto_box and this module


alias crypto_box_seed_keypair   = deimos.sodium.crypto_box.crypto_box_seed_keypair;

/**
 * Using crypto_box_seed_keypair(), the key pair can be deterministically derived from a single key `seed`.
 */
pragma(inline, true)
bool crypto_box_seed_keypair(out ubyte[crypto_box_PUBLICKEYBYTES] pkey, out ubyte[crypto_box_SECRETKEYBYTES] skey,
                             const ubyte[crypto_box_SEEDBYTES] seed) pure @nogc @trusted
{
  return  crypto_box_seed_keypair(pkey.ptr, skey.ptr, seed.ptr) == 0;
}

alias crypto_box_keypair        = deimos.sodium.crypto_box.crypto_box_keypair;

/**
 * The crypto_box_keypair() function randomly generates a secret key and a corresponding public key.
 * The public key is put into `pkey` and the secret key into `skey`.
 */
pragma(inline, true)
bool crypto_box_keypair(out ubyte[crypto_box_PUBLICKEYBYTES] pkey, out ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  return  crypto_box_keypair(pkey.ptr, skey.ptr) == 0;
}

alias crypto_box_easy           = deimos.sodium.crypto_box.crypto_box_easy;

/**
 */
bool crypto_box_easy(scope ubyte[] c, scope const ubyte[] m, const ubyte[crypto_box_NONCEBYTES] n,
                     const ubyte[crypto_box_PUBLICKEYBYTES] pkey, const ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  const  c_expect_len = m.length + crypto_box_MACBYTES;
  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_box_MACBYTES: ", c_expect_len);
  return  crypto_box_easy(c.ptr, m.ptr, m.length, n.ptr, pkey.ptr, skey.ptr) == 0;
}

alias crypto_box_open_easy      = deimos.sodium.crypto_box.crypto_box_open_easy;

/**
 */
bool crypto_box_open_easy(scope ubyte[] m, scope const ubyte[] c, const ubyte[crypto_box_NONCEBYTES] n,
                          const ubyte[crypto_box_PUBLICKEYBYTES] pkey, const ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  enforce(c.length >= crypto_box_MACBYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_box_MACBYTES: ", crypto_box_MACBYTES);
  const  m_expect_len = c.length - crypto_box_MACBYTES;
  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_box_MACBYTES: ", m_expect_len);
  return  crypto_box_open_easy(m.ptr, c.ptr, c.length, n.ptr, pkey.ptr, skey.ptr) == 0;
}

alias crypto_box_detached       = deimos.sodium.crypto_box.crypto_box_detached;

/**
 */
bool crypto_box_detached(scope ubyte[] c, out ubyte[crypto_box_MACBYTES] mac, scope const ubyte[] m, const ubyte[crypto_box_NONCEBYTES] n,
                         const ubyte[crypto_box_PUBLICKEYBYTES] pkey, const ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  return  crypto_box_detached(c.ptr, mac.ptr, m.ptr, m.length, n.ptr, pkey.ptr, skey.ptr) == 0;
}

alias crypto_box_open_detached  = deimos.sodium.crypto_box.crypto_box_open_detached;

/**
 */
pragma(inline, true)
bool crypto_box_open_detached(scope ubyte[] m, scope const ubyte[] c, const ubyte[crypto_box_MACBYTES] mac, const ubyte[crypto_box_NONCEBYTES] n,
                              const ubyte[crypto_box_PUBLICKEYBYTES] pkey, const ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  enforce(m.length >= c.length, "Error in crypto_box_open_detached: m.length < c.length");
  return  crypto_box_open_detached(m.ptr, c.ptr, mac.ptr, c.length, n.ptr, pkey.ptr, skey.ptr) == 0;
}


/* -- Precomputation interface -- */

alias crypto_box_beforenm  = deimos.sodium.crypto_box.crypto_box_beforenm;

pragma(inline, true)
bool  crypto_box_beforenm(out ubyte[crypto_box_BEFORENMBYTES] k,
                          const ubyte[crypto_box_PUBLICKEYBYTES] pk,
                          const ubyte[crypto_box_SECRETKEYBYTES] sk) pure nothrow @nogc @trusted // __attribute__ ((warn_unused_result));
{
  return  crypto_box_beforenm(k.ptr, pk.ptr, sk.ptr) == 0;
}

alias crypto_box_easy_afternm  = deimos.sodium.crypto_box.crypto_box_easy_afternm;

pragma(inline, true)
bool  crypto_box_easy_afternm(scope ubyte[] c,
                              scope const ubyte[] m,
                              const ubyte[crypto_box_NONCEBYTES] n,
                              const ubyte[crypto_box_BEFORENMBYTES] k) @nogc @trusted
{
  const  c_expect_len = m.length + crypto_box_MACBYTES;
  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_box_MACBYTES: ", c_expect_len);
  return  crypto_box_easy_afternm(c.ptr, m.ptr, m.length, n.ptr, k.ptr) == 0;
}

alias crypto_box_open_easy_afternm  = deimos.sodium.crypto_box.crypto_box_open_easy_afternm;

pragma(inline, true)
bool  crypto_box_open_easy_afternm(scope ubyte[] m,
                                   scope const ubyte[] c,
                                   const ubyte[crypto_box_NONCEBYTES] n,
                                   const ubyte[crypto_box_BEFORENMBYTES] k) @nogc @trusted // __attribute__ ((warn_unused_result));
{
  enforce(c.length >= crypto_box_MACBYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_box_MACBYTES: ", crypto_box_MACBYTES);
  const  m_expect_len = c.length - crypto_box_MACBYTES;
  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_box_MACBYTES: ", m_expect_len);
  return  crypto_box_open_easy_afternm(m.ptr, c.ptr, c.length, n.ptr, k.ptr) == 0;
}

alias crypto_box_detached_afternm  = deimos.sodium.crypto_box.crypto_box_detached_afternm;

pragma(inline, true)
bool  crypto_box_detached_afternm(scope ubyte[] c,
                                  out ubyte[crypto_box_MACBYTES] mac,
                                  scope const  ubyte[] m,
                                  const ubyte[crypto_box_NONCEBYTES] n,
                                  const ubyte[crypto_box_BEFORENMBYTES] k) @nogc @trusted
{
  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  return  crypto_box_detached_afternm(c.ptr, mac.ptr, m.ptr, m.length, n.ptr, k.ptr) == 0;
}

alias crypto_box_open_detached_afternm  = deimos.sodium.crypto_box.crypto_box_open_detached_afternm;

pragma(inline, true)
bool  crypto_box_open_detached_afternm(scope ubyte[] m,
                                       scope const ubyte[] c,
                                       const ubyte[crypto_box_MACBYTES] mac,
                                       const ubyte[crypto_box_NONCEBYTES] n,
                                       const ubyte[crypto_box_BEFORENMBYTES] k) @nogc @trusted // __attribute__ ((warn_unused_result));
{
  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  return  crypto_box_open_detached_afternm(m.ptr, c.ptr, mac.ptr, c.length, n.ptr, k.ptr) == 0;
}


/* -- Ephemeral SK interface -- */

alias crypto_box_seal           = deimos.sodium.crypto_box.crypto_box_seal;

/**
 * The crypto_box_seal() function encrypts a message `m` for a recipient whose public key is `pkey`.
 * It puts the ciphertext whose length is crypto_box_SEALBYTES + m.length into `c`.
 * The function creates a new key pair for each message, and attaches the public key to the ciphertext.
 * The secret key is overwritten and is not accessible after this function returns.
 */
bool crypto_box_seal(scope ubyte[] c, scope const ubyte[] m, const ubyte[crypto_box_PUBLICKEYBYTES] pkey) @nogc @trusted
{
  const  c_expect_len = m.length + crypto_box_SEALBYTES;
  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_box_SEALBYTES: ", c_expect_len);
  return  crypto_box_seal(c.ptr, m.ptr, m.length, pkey.ptr) == 0;
}

alias crypto_box_seal_open      = deimos.sodium.crypto_box.crypto_box_seal_open;

/**
 */
bool crypto_box_seal_open(scope ubyte[] m, scope const ubyte[] c,
                          const ubyte[crypto_box_PUBLICKEYBYTES] pkey, const ubyte[crypto_box_SECRETKEYBYTES] skey) @nogc @trusted
{
  enforce(c.length >= crypto_box_SEALBYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_box_SEALBYTES: ", crypto_box_SEALBYTES);
  const  m_expect_len = c.length - crypto_box_SEALBYTES;
  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_box_SEALBYTES: ", m_expect_len);
  return  crypto_box_seal_open(m.ptr, c.ptr, c.length, pkey.ptr, skey.ptr) == 0;
}

/* No overloads for -- NaCl compatibility interface ; Requires padding -- */


@safe
unittest {
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_box.d");
}

@safe
unittest {
  import std.string : representation;
  import wrapper.sodium.randombytes : randombytes;
  import wrapper.sodium.utils : sodium_increment;

  assert(crypto_box_seedbytes()        == crypto_box_SEEDBYTES);
  assert(crypto_box_publickeybytes()   == crypto_box_PUBLICKEYBYTES);
  assert(crypto_box_secretkeybytes()   == crypto_box_SECRETKEYBYTES);
  assert(crypto_box_noncebytes()       == crypto_box_NONCEBYTES);
  assert(crypto_box_macbytes()         == crypto_box_MACBYTES);
  assert(crypto_box_messagebytes_max() == crypto_box_MESSAGEBYTES_MAX);
  assert(crypto_box_primitive()        == crypto_box_PRIMITIVE);
  assert(crypto_box_beforenmbytes()    == crypto_box_BEFORENMBYTES);
  assert(crypto_box_sealbytes()        == crypto_box_SEALBYTES);

  enum MESSAGE_LEN = 4;
  ubyte[MESSAGE_LEN] message  = [116, 101, 115, 116]; //representation("test");
  // avoid heap allocation, like in the example code
  enum CIPHERTEXT_LEN = (crypto_box_MACBYTES + MESSAGE_LEN);
  ubyte[crypto_box_SEEDBYTES]  seed = void;
  randombytes(seed);

  ubyte[crypto_box_PUBLICKEYBYTES]  alice_publickey = void;
  ubyte[crypto_box_SECRETKEYBYTES]  alice_secretkey = void;
  assert(crypto_box_seed_keypair(alice_publickey, alice_secretkey, seed));
  // check crypto_scalarmult_base (compute alice_publickey from alice_secretkey)
  {
    import wrapper.sodium.crypto_scalarmult;
    assert(crypto_scalarmult_BYTES       == crypto_box_PUBLICKEYBYTES);
    assert(crypto_scalarmult_SCALARBYTES == crypto_box_SECRETKEYBYTES);
    ubyte[crypto_box_PUBLICKEYBYTES]  alice_publickey_computed;
    assert(crypto_scalarmult_base(alice_publickey_computed, alice_secretkey));
    assert(alice_publickey_computed == alice_publickey);
  }

  ubyte[crypto_box_PUBLICKEYBYTES]  bob_publickey = void;
  ubyte[crypto_box_SECRETKEYBYTES]  bob_secretkey = void;
  crypto_box_keypair(bob_publickey, bob_secretkey);

  ubyte[crypto_box_NONCEBYTES] nonce = void;
  ubyte[CIPHERTEXT_LEN] ciphertext1  = void;
  randombytes(nonce);
  // Alice encrypts message for Bob
  assertThrown(crypto_box_easy(ciphertext1[0..$-1], message, nonce, bob_publickey, alice_secretkey));
  assert(crypto_box_easy(ciphertext1, message, nonce, bob_publickey, alice_secretkey));
//  { /* error */ }

  ubyte[MESSAGE_LEN] decrypted = void;
  // Bob decrypts ciphertext from Alice
  assertThrown(crypto_box_open_easy(decrypted[0..$-1], ciphertext1, nonce, alice_publickey, bob_secretkey));
  assert(crypto_box_open_easy(decrypted, ciphertext1, nonce, alice_publickey, bob_secretkey));
  assert(decrypted == message);
//
  ubyte[MESSAGE_LEN]  ciphertext2;
  ubyte[crypto_box_MACBYTES]  mac = void;
  decrypted  = ubyte.init;
  sodium_increment(nonce);
  assertThrown(crypto_box_detached(ciphertext2[0..$-1], mac, message, nonce, bob_publickey, alice_secretkey));
  assert(crypto_box_detached(ciphertext2, mac, message, nonce, bob_publickey, alice_secretkey));

  assertThrown(crypto_box_open_detached(decrypted[0..$-1], ciphertext2, mac, nonce, alice_publickey, bob_secretkey));
  assert(crypto_box_open_detached(decrypted, ciphertext2, mac, nonce, alice_publickey, bob_secretkey));
  assert(decrypted == message);
//
  ubyte[crypto_box_BEFORENMBYTES] k;
  assert(crypto_box_beforenm(k, bob_publickey, alice_secretkey));
  ciphertext1 = ubyte.init;
  decrypted   = ubyte.init;
  sodium_increment(nonce);
  assert(crypto_box_easy_afternm(ciphertext1, message, nonce, k));
  assert(crypto_box_open_easy_afternm(decrypted, ciphertext1, nonce, k));
  assert(decrypted == message);

  ciphertext2 = ubyte.init;
  decrypted   = ubyte.init;
  mac         = ubyte.init;
  sodium_increment(nonce);
  assert(crypto_box_detached_afternm(ciphertext2, mac, message, nonce, k));
  assert(crypto_box_open_detached_afternm(decrypted, ciphertext2, mac, nonce, k));
  assert(decrypted == message);
//
  enum CIPHERTEXTSEALED_LEN = (crypto_box_SEALBYTES + MESSAGE_LEN);
  ubyte[CIPHERTEXTSEALED_LEN] ciphertext_sealed = void;
  decrypted  = ubyte.init;

  assertThrown(crypto_box_seal(ciphertext_sealed[0..$-1], message, bob_publickey));
  assert(crypto_box_seal(ciphertext_sealed, message, bob_publickey));

  assertThrown(crypto_box_seal_open(decrypted[0..$-1], ciphertext_sealed, bob_publickey, bob_secretkey));
  assert(crypto_box_seal_open(decrypted, ciphertext_sealed, bob_publickey, bob_secretkey));
  assert(decrypted == message);

}
