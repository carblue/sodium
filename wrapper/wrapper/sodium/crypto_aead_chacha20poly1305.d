// Written in the D programming language.

module wrapper.sodium.crypto_aead_chacha20poly1305;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_aead_chacha20poly1305 : crypto_aead_chacha20poly1305_ietf_KEYBYTES,
                                                     crypto_aead_chacha20poly1305_ietf_keybytes,
                                                     crypto_aead_chacha20poly1305_ietf_NSECBYTES,
                                                     crypto_aead_chacha20poly1305_ietf_nsecbytes,
                                                     crypto_aead_chacha20poly1305_ietf_NPUBBYTES,
                                                     crypto_aead_chacha20poly1305_ietf_npubbytes,
                                                     crypto_aead_chacha20poly1305_ietf_ABYTES,
                                                     crypto_aead_chacha20poly1305_ietf_abytes,
                                                     crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX,
                                                     crypto_aead_chacha20poly1305_ietf_messagebytes_max,
/*                                                   crypto_aead_chacha20poly1305_ietf_encrypt,
                                                     crypto_aead_chacha20poly1305_ietf_decrypt,
                                                     crypto_aead_chacha20poly1305_ietf_encrypt_detached,
                                                     crypto_aead_chacha20poly1305_ietf_decrypt_detached, */
                                                     crypto_aead_chacha20poly1305_ietf_keygen,
                                                     crypto_aead_chacha20poly1305_KEYBYTES,
                                                     crypto_aead_chacha20poly1305_keybytes,
                                                     crypto_aead_chacha20poly1305_NSECBYTES,
                                                     crypto_aead_chacha20poly1305_nsecbytes,
                                                     crypto_aead_chacha20poly1305_NPUBBYTES,
                                                     crypto_aead_chacha20poly1305_npubbytes,
                                                     crypto_aead_chacha20poly1305_ABYTES,
                                                     crypto_aead_chacha20poly1305_abytes,
                                                     crypto_aead_chacha20poly1305_MESSAGEBYTES_MAX,
                                                     crypto_aead_chacha20poly1305_messagebytes_max,
/*                                                   crypto_aead_chacha20poly1305_encrypt,
                                                     crypto_aead_chacha20poly1305_decrypt,
                                                     crypto_aead_chacha20poly1305_encrypt_detached,
                                                     crypto_aead_chacha20poly1305_decrypt_detached, */
                                                     crypto_aead_chacha20poly1305_keygen;


import std.exception : assertThrown, assertNotThrown;
import nogc.exception: enforce;

// overloading some functions between module deimos.sodium.crypto_aead_chacha20poly1305 and this module

alias crypto_aead_chacha20poly1305_ietf_encrypt = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_ietf_encrypt;

/**
 * The function crypto_aead_chacha20poly1305_ietf_encrypt()
 * encrypts a message `m` using a secret key `k` (crypto_aead_chacha20poly1305_ietf_KEYBYTES bytes)
 * and a public nonce `npub` (crypto_aead_chacha20poly1305_ietf_NPUBBYTES bytes).
 * The encrypted message, as well as a tag authenticating both the confidential message m and ad.length bytes of non-confidential data `ad`,
 * are put into `c`.
 * ad can also be an empty array if no additional data are required.
 * At most m.length + crypto_aead_chacha20poly1305_ietf_ABYTES bytes are put into `c`.
 * The function always returns true.
 * The public nonce npub should never ever be reused with the same key. The recommended way to generate it is to use
 * randombytes_buf() for the first message, and then to increment it for each subsequent message using the same key.
 */
bool crypto_aead_chacha20poly1305_ietf_encrypt(scope ubyte[] c,
                                               const scope ubyte[] m,
                                               const scope ubyte[] ad,
                                               const ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES] npub,
                                               const ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_chacha20poly1305_ietf_encrypt: m is null"); // TODO check if m.ptr==null would be okay
  enforce(m.length <=  ulong.max - crypto_aead_chacha20poly1305_ietf_ABYTES);
  const  c_expect_len = m.length + crypto_aead_chacha20poly1305_ietf_ABYTES;
//  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_aead_chacha20poly1305_ietf_ABYTES: ", c_expect_len);
  enforce(c.length == c_expect_len, "Expected c.length is not equal to m.length + crypto_aead_chacha20poly1305_ietf_ABYTES");
  ulong clen_p;
  bool result = crypto_aead_chacha20poly1305_ietf_encrypt(c.ptr, &clen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  if (result)
    assert(clen_p ==  c_expect_len); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_ietf_decrypt = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_ietf_decrypt;

/**
 * The function crypto_aead_chacha20poly1305_ietf_decrypt()
  verifies that the ciphertext `c` (as produced by crypto_aead_chacha20poly1305_ietf_encrypt()),
 * includes a valid tag using a secret key `k`, a public nonce `npub`, and additional data `ad`. c.length is the ciphertext length
 * in bytes with the authenticator, so it has to be at least crypto_aead_chacha20poly1305_ietf_ABYTES.
 *
 * ad can be an empty array if no additional data are required.
 * The function returns false if the verification fails.
 * If the verification succeeds, the function returns true, puts the decrypted message into `m` and stores its actual number of bytes into `mlen_p`.
 * At most c.length - crypto_aead_chacha20poly1305_ietf_ABYTES bytes will be put into m.
 */
bool crypto_aead_chacha20poly1305_ietf_decrypt(scope ubyte[] m,
                                               const scope ubyte[] c,
                                               const scope ubyte[] ad,
                                               const ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES] npub,
                                               const ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(c.length >= crypto_aead_chacha20poly1305_ietf_ABYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_aead_chacha20poly1305_ietf_ABYTES: ", crypto_aead_chacha20poly1305_ietf_ABYTES);
  enforce(c.length >= crypto_aead_chacha20poly1305_ietf_ABYTES, "Expected c.length is not greater_equal to crypto_aead_chacha20poly1305_ietf_ABYTES");
  const  m_expect_len = c.length - crypto_aead_chacha20poly1305_ietf_ABYTES;
//  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_aead_chacha20poly1305_ietf_ABYTES: ", m_expect_len);
  enforce(m.length == m_expect_len, "Expected m.length is not equal to c.length - crypto_aead_chacha20poly1305_ietf_ABYTES");
  ulong mlen_p;
  bool result = crypto_aead_chacha20poly1305_ietf_decrypt(m.ptr, &mlen_p, null, c.ptr, c.length, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
  if (result)
    assert(mlen_p ==  m_expect_len); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_ietf_encrypt_detached = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_ietf_encrypt_detached;

bool  crypto_aead_chacha20poly1305_ietf_encrypt_detached(scope ubyte[] c,
                                                         out ubyte[crypto_aead_chacha20poly1305_ietf_ABYTES] mac,
                                                         const scope ubyte[] m,
                                                         const scope ubyte[] ad,
                                                         const ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES] npub,
                                                         const ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_chacha20poly1305_ietf_encrypt_detached: m is null"); // TODO check if m.ptr==null would be okay
//  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  enforce(c.length == m.length, "Expected c.length is not equal to m.length");
  ulong maclen_p;
  bool result = crypto_aead_chacha20poly1305_ietf_encrypt_detached(c.ptr, mac.ptr, &maclen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  assert(maclen_p == crypto_aead_chacha20poly1305_ietf_ABYTES); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_ietf_decrypt_detached = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_ietf_decrypt_detached;

bool  crypto_aead_chacha20poly1305_ietf_decrypt_detached(scope ubyte[] m,
                                                         const scope ubyte[] c,
                                                         const ubyte[crypto_aead_chacha20poly1305_ietf_ABYTES] mac,
                                                         const scope ubyte[] ad,
                                                         const ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES] npub,
                                                         const ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(c.length, "Error invoking crypto_aead_chacha20poly1305_ietf_decrypt_detached: c is null"); // TODO check if c.ptr==null would be okay
//  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  enforce(m.length == c.length, "Expected m.length is not equal to c.length");
  return  crypto_aead_chacha20poly1305_ietf_decrypt_detached(m.ptr, null, c.ptr, c.length, mac.ptr, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
}

/* -- Original ChaCha20-Poly1305 construction with a 64-bit nonce and a 64-bit internal counter -- */

alias crypto_aead_chacha20poly1305_encrypt = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_encrypt;

bool  crypto_aead_chacha20poly1305_encrypt(scope ubyte[] c,
                                           const scope ubyte[] m,
                                           const scope ubyte[] ad,
                                           const ubyte[crypto_aead_chacha20poly1305_NPUBBYTES] npub,
                                           const ubyte[crypto_aead_chacha20poly1305_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_chacha20poly1305_encrypt: m is null"); // TODO check if m.ptr==null would be okay
  const  c_expect_len = m.length + crypto_aead_chacha20poly1305_ABYTES;
//  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_aead_chacha20poly1305_ABYTES: ", c_expect_len);
  enforce(c.length == c_expect_len, "Expected c.length is not equal to m.length + crypto_aead_chacha20poly1305_ABYTES");
  ulong clen_p;
  bool result = crypto_aead_chacha20poly1305_encrypt(c.ptr, &clen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  if (result)
    assert(clen_p ==  c_expect_len); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_decrypt = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_decrypt;

bool  crypto_aead_chacha20poly1305_decrypt(scope ubyte[] m,
                                           const scope ubyte[] c,
                                           const scope ubyte[] ad,
                                           const ubyte[crypto_aead_chacha20poly1305_NPUBBYTES] npub,
                                           const ubyte[crypto_aead_chacha20poly1305_KEYBYTES] k) @nogc @trusted
{
//  enforce(c.length >= crypto_aead_chacha20poly1305_ABYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_aead_chacha20poly1305_ABYTES: ", crypto_aead_chacha20poly1305_ABYTES);
  enforce(c.length >= crypto_aead_chacha20poly1305_ABYTES, "Expected c.length is not greater_equal to crypto_aead_chacha20poly1305_ABYTES");
  const  m_expect_len = c.length - crypto_aead_chacha20poly1305_ABYTES;
//  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_aead_chacha20poly1305_ABYTES: ", m_expect_len);
  enforce(m.length == m_expect_len, "Expected m.length is not equal to c.length - crypto_aead_chacha20poly1305_ABYTES");
  ulong mlen_p;
  bool result = crypto_aead_chacha20poly1305_decrypt(m.ptr, &mlen_p, null, c.ptr, c.length, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
  if (result)
    assert(mlen_p ==  m_expect_len); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_encrypt_detached = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_encrypt_detached;

bool  crypto_aead_chacha20poly1305_encrypt_detached(scope ubyte[] c,
                                                    out ubyte[crypto_aead_chacha20poly1305_ABYTES] mac,
                                                    const scope ubyte[] m,
                                                    const scope ubyte[] ad,
                                                    const ubyte[crypto_aead_chacha20poly1305_NPUBBYTES] npub,
                                                    const ubyte[crypto_aead_chacha20poly1305_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_chacha20poly1305_encrypt_detached: m is null"); // TODO check if m.ptr==null would be okay
//  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  enforce(c.length == m.length, "Expected c.length is not equal to m.length");
  ulong maclen_p;
  bool result = crypto_aead_chacha20poly1305_encrypt_detached(c.ptr, mac.ptr, &maclen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  assert(maclen_p == crypto_aead_chacha20poly1305_ABYTES); // okay to be removed in release code
  return  result;
}

alias crypto_aead_chacha20poly1305_decrypt_detached = deimos.sodium.crypto_aead_chacha20poly1305.crypto_aead_chacha20poly1305_decrypt_detached;

bool  crypto_aead_chacha20poly1305_decrypt_detached(scope ubyte[] m,
                                                    const scope ubyte[] c,
                                                    const ubyte[crypto_aead_chacha20poly1305_ABYTES] mac,
                                                    const scope ubyte[] ad,
                                                    const ubyte[crypto_aead_chacha20poly1305_NPUBBYTES] npub,
                                                    const ubyte[crypto_aead_chacha20poly1305_KEYBYTES] k) @nogc @trusted
{
//  enforce(c.length, "Error invoking crypto_aead_chacha20poly1305_decrypt_detached: c is null"); // TODO check if c.ptr==null would be okay
//  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  enforce(m.length == c.length, "Expected m.length is not equal to c.length");
  return  crypto_aead_chacha20poly1305_decrypt_detached(m.ptr, null, c.ptr, c.length, mac.ptr, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
}


version(unittest)
{
  import wrapper.sodium.randombytes : randombytes;
  // share a key and nonce in the following unittests
  ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES]  nonce = void;
  ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES]   key   = void;

  ubyte[crypto_aead_chacha20poly1305_NPUBBYTES]  nonce2 = void;
  ubyte[crypto_aead_chacha20poly1305_KEYBYTES]   key2   = void;

  static this() {
    randombytes(nonce);
    randombytes(key);
    randombytes(nonce2);
    randombytes(key2);
  }
}


@system
unittest
{
  import std.string : representation;
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_aead_chacha20poly1305.d");

  auto message         = representation("test");
  enum message_len = 4;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[message_len + crypto_aead_chacha20poly1305_ietf_ABYTES]  ciphertext;
  ulong   ciphertext_len;

  crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext.ptr, &ciphertext_len, message.ptr, message.length,
    additional_data.ptr, additional_data.length, null, nonce.ptr, key.ptr);

  ubyte[message_len] decrypted;
  ulong decrypted_len;
  assert(ciphertext_len==ciphertext.length);
  assert(crypto_aead_chacha20poly1305_ietf_decrypt(decrypted.ptr, &decrypted_len, null, ciphertext.ptr, ciphertext_len,
      additional_data.ptr, additional_data.length, nonce.ptr, key.ptr) == 0);
  assert(decrypted == message); //writeln("Decrypted message (aead_chacha20poly1305): ", cast(string)decrypted);
  assert(decrypted_len == decrypted.length);

  // test null for &ciphertext_len / decrypted_len
  crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext.ptr, null, message.ptr, message.length,
    additional_data.ptr, additional_data.length, null, nonce.ptr, key.ptr);
  crypto_aead_chacha20poly1305_ietf_decrypt(decrypted.ptr, null, null, ciphertext.ptr, ciphertext_len,
    additional_data.ptr, additional_data.length, nonce.ptr, key.ptr);

  ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES] k;
  crypto_aead_chacha20poly1305_ietf_keygen(k);
  ubyte[crypto_aead_chacha20poly1305_KEYBYTES] k2;
  crypto_aead_chacha20poly1305_keygen(k2);

}

@safe
unittest
{
  import std.string : representation;
  import std.stdio : writeln, writefln;
  import wrapper.sodium.utils : sodium_increment;
  debug writeln("unittest block 2 from sodium.crypto_aead_chacha20poly1305.d");

  assert(crypto_aead_chacha20poly1305_ietf_keybytes()         == crypto_aead_chacha20poly1305_ietf_KEYBYTES);
  assert(crypto_aead_chacha20poly1305_ietf_nsecbytes()        == crypto_aead_chacha20poly1305_ietf_NSECBYTES);
  assert(crypto_aead_chacha20poly1305_ietf_npubbytes()        == crypto_aead_chacha20poly1305_ietf_NPUBBYTES);
  assert(crypto_aead_chacha20poly1305_ietf_abytes()           == crypto_aead_chacha20poly1305_ietf_ABYTES);
////  assert(crypto_aead_chacha20poly1305_ietf_messagebytes_max() == crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX); // see travis Build #74
  debug writeln("crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX:   ", crypto_aead_chacha20poly1305_ietf_MESSAGEBYTES_MAX);
  debug writeln("crypto_aead_chacha20poly1305_ietf_messagebytes_max(): ", crypto_aead_chacha20poly1305_ietf_messagebytes_max());

  auto message         = representation("test");
  enum message_len = 4;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[message_len + crypto_aead_chacha20poly1305_ietf_ABYTES]  ciphertext1;
  sodium_increment(nonce);

  assertThrown   (crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext1[0..$-1],              message, additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext1[0..$-message.length], null,    additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext1,                      message, null,            nonce, key));

  assert(crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext1, message, additional_data, nonce, key));

  ubyte[message_len] decrypted;
  assertThrown   (crypto_aead_chacha20poly1305_ietf_decrypt(decrypted,         ciphertext1[0..crypto_aead_chacha20poly1305_ietf_ABYTES-1], additional_data, nonce, key));
  assertThrown   (crypto_aead_chacha20poly1305_ietf_decrypt(decrypted[0..$-1], ciphertext1,                                                additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_decrypt(decrypted,         ciphertext1,                                                null,            nonce, key));

  assert(crypto_aead_chacha20poly1305_ietf_decrypt(decrypted, ciphertext1, additional_data, nonce, key));
  assert(decrypted == message);
//
  ubyte[message_len] ciphertext2;
  ubyte[crypto_aead_chacha20poly1305_ietf_ABYTES] mac;
  sodium_increment(nonce);

  assertThrown   (crypto_aead_chacha20poly1305_ietf_encrypt_detached(ciphertext2[0..$-1],              mac, message, additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_encrypt_detached(ciphertext2[0..$-message.length], mac, null,    additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_encrypt_detached(ciphertext2,                      mac, message, null,            nonce, key));

  assert(crypto_aead_chacha20poly1305_ietf_encrypt_detached(ciphertext2, mac, message, additional_data, nonce, key));

  assertThrown   (crypto_aead_chacha20poly1305_ietf_decrypt_detached(decrypted[0..$-1],              ciphertext2, mac, additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_decrypt_detached(decrypted[0..$-message.length], null,       mac, additional_data, nonce, key));
  assertNotThrown(crypto_aead_chacha20poly1305_ietf_decrypt_detached(decrypted,                      ciphertext2, mac, null,            nonce, key));

  assert(crypto_aead_chacha20poly1305_ietf_decrypt_detached(decrypted, ciphertext2, mac, additional_data, nonce, key));
  assert(decrypted == message);

}

@safe
unittest
{
  import std.string : representation;
  import std.stdio : writeln, writefln;
  import wrapper.sodium.utils : sodium_increment;
  debug writeln("unittest block 3 from sodium.crypto_aead_chacha20poly1305.d");

  assert(crypto_aead_chacha20poly1305_keybytes()         == crypto_aead_chacha20poly1305_KEYBYTES);
  assert(crypto_aead_chacha20poly1305_nsecbytes()        == crypto_aead_chacha20poly1305_NSECBYTES);
  assert(crypto_aead_chacha20poly1305_npubbytes()        == crypto_aead_chacha20poly1305_NPUBBYTES);
  assert(crypto_aead_chacha20poly1305_abytes()           == crypto_aead_chacha20poly1305_ABYTES);
  assert(crypto_aead_chacha20poly1305_messagebytes_max() == crypto_aead_chacha20poly1305_MESSAGEBYTES_MAX);

  auto message         = representation("test");
  enum message_len = 4;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[message_len + crypto_aead_chacha20poly1305_ABYTES] ciphertext1;
  sodium_increment(nonce2);

  assertThrown   (crypto_aead_chacha20poly1305_encrypt(ciphertext1[0..$-1],              message, additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_encrypt(ciphertext1[0..$-message.length], null,    additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_encrypt(ciphertext1,                      message, null,            nonce2, key2));

  assert(crypto_aead_chacha20poly1305_encrypt(ciphertext1, message, additional_data, nonce2, key2));

  ubyte[message_len] decrypted;
  assertThrown   (crypto_aead_chacha20poly1305_decrypt(decrypted,         ciphertext1[0..crypto_aead_chacha20poly1305_ABYTES-1], additional_data, nonce2, key2));
  assertThrown   (crypto_aead_chacha20poly1305_decrypt(decrypted[0..$-1], ciphertext1,                                           additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_decrypt(decrypted,         ciphertext1,                                           null,            nonce2, key2));

  assert(crypto_aead_chacha20poly1305_decrypt(decrypted, ciphertext1, additional_data, nonce2, key2));
  assert(decrypted == message);
//
  ubyte[message_len]  ciphertext2;
  ubyte[crypto_aead_chacha20poly1305_ABYTES] mac;
  sodium_increment(nonce2);

  assertThrown   (crypto_aead_chacha20poly1305_encrypt_detached(ciphertext2[0..$-1],              mac, message, additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_encrypt_detached(ciphertext2[0..$-message.length], mac, null,    additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_encrypt_detached(ciphertext2,                      mac, message, null,            nonce2, key2));

  assert(crypto_aead_chacha20poly1305_encrypt_detached(ciphertext2, mac, message, additional_data, nonce2, key2));

  assertThrown   (crypto_aead_chacha20poly1305_decrypt_detached(decrypted[0..$-1],              ciphertext2, mac, additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_decrypt_detached(decrypted[0..$-message.length], null,       mac, additional_data, nonce2, key2));
  assertNotThrown(crypto_aead_chacha20poly1305_decrypt_detached(decrypted,                      ciphertext2, mac, null,            nonce2, key2));

  assert(crypto_aead_chacha20poly1305_decrypt_detached(decrypted, ciphertext2, mac, additional_data, nonce2, key2));
  assert(decrypted == message);
}



@nogc @safe
unittest
{
  // usage is not cryptographically safe here; it's purpose is to test @nogc @safe
  import std.string : representation;
  ubyte[crypto_aead_chacha20poly1305_ietf_NPUBBYTES]  n1 = nonce;
  ubyte[crypto_aead_chacha20poly1305_ietf_KEYBYTES]   k1;
  crypto_aead_chacha20poly1305_ietf_keygen(k1);
  ubyte[4] message  = [116, 101, 115, 116]; //representation("test");
  ubyte[4] decrypted;
  enum  m_len  = 4UL;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[m_len+crypto_aead_chacha20poly1305_ietf_ABYTES] ciphertext1;
  ubyte[m_len]                                          ciphertext2;
  ubyte[      crypto_aead_chacha20poly1305_ietf_ABYTES] mac1;

  assert(crypto_aead_chacha20poly1305_ietf_encrypt(ciphertext1,   message, additional_data, n1, k1));
  assert(crypto_aead_chacha20poly1305_ietf_decrypt(decrypted, ciphertext1, additional_data, n1, k1));
  assert(decrypted == message);
  decrypted = decrypted.init;
  assert(crypto_aead_chacha20poly1305_ietf_encrypt_detached(ciphertext2, mac1,   message, additional_data, n1, k1));
  assert(crypto_aead_chacha20poly1305_ietf_decrypt_detached(decrypted, ciphertext2, mac1, additional_data, n1, k1));
  assert(decrypted == message);
  ubyte[crypto_aead_chacha20poly1305_NPUBBYTES]  n2 = nonce[0..crypto_aead_chacha20poly1305_NPUBBYTES];
  ubyte[crypto_aead_chacha20poly1305_KEYBYTES]   k2;
  crypto_aead_chacha20poly1305_keygen(k2);
  ubyte[m_len+crypto_aead_chacha20poly1305_ABYTES] ciphertext3;
  ubyte[m_len]                                     ciphertext4;
  ubyte[      crypto_aead_chacha20poly1305_ABYTES] mac2;
  decrypted = decrypted.init;
  assert(crypto_aead_chacha20poly1305_encrypt(ciphertext3,   message, additional_data, n2, k2));
  assert(crypto_aead_chacha20poly1305_decrypt(decrypted, ciphertext3, additional_data, n2, k2));
  assert(decrypted == message);
  decrypted = decrypted.init;
  assert(crypto_aead_chacha20poly1305_encrypt_detached(ciphertext4, mac2,   message, additional_data, n2, k2));
  assert(crypto_aead_chacha20poly1305_decrypt_detached(decrypted, ciphertext4, mac2, additional_data, n2, k2));
  assert(decrypted == message);
}
