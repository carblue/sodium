// Written in the D programming language.

module wrapper.sodium.crypto_aead_xchacha20poly1305;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_aead_xchacha20poly1305 : crypto_aead_xchacha20poly1305_ietf_KEYBYTES,
                                                      crypto_aead_xchacha20poly1305_ietf_keybytes,
                                                      crypto_aead_xchacha20poly1305_ietf_NSECBYTES,
                                                      crypto_aead_xchacha20poly1305_ietf_nsecbytes,
                                                      crypto_aead_xchacha20poly1305_ietf_NPUBBYTES,
                                                      crypto_aead_xchacha20poly1305_ietf_npubbytes,
                                                      crypto_aead_xchacha20poly1305_ietf_ABYTES,
                                                      crypto_aead_xchacha20poly1305_ietf_abytes,
/*                                                    crypto_aead_xchacha20poly1305_ietf_encrypt,
                                                      crypto_aead_xchacha20poly1305_ietf_decrypt,
                                                      crypto_aead_xchacha20poly1305_ietf_encrypt_detached,
                                                      crypto_aead_xchacha20poly1305_ietf_decrypt_detached, */
                                                      crypto_aead_xchacha20poly1305_ietf_keygen;
;


import std.exception : assertThrown, assertNotThrown;

// overloading some functions between module deimos.sodium.crypto_aead_xchacha20poly1305 and this module

alias crypto_aead_xchacha20poly1305_ietf_encrypt = deimos.sodium.crypto_aead_xchacha20poly1305.crypto_aead_xchacha20poly1305_ietf_encrypt;

/**
 * The function crypto_aead_xchacha20poly1305_ietf_encrypt()
 * encrypts a message `m` using a secret key `k` (crypto_aead_xchacha20poly1305_ietf_KEYBYTES bytes)
 * and a public nonce `npub` (crypto_aead_xchacha20poly1305_ietf_NPUBBYTES bytes).
 * The encrypted message, as well as a tag authenticating both the confidential message m and ad.length bytes of non-confidential data `ad`,
 * are put into `c`.
 * ad can also be an empty array if no additional data are required.
 * At most m.length + crypto_aead_xchacha20poly1305_ietf_ABYTES bytes are put into `c`, and the actual number of bytes is stored into `clen_p`.
 * The function always returns true.
 * The public nonce npub should never ever be reused with the same key. The recommended way to generate it is to use
 * randombytes_buf() for the first message, and then to increment it for each subsequent message using the same key.
 */
bool crypto_aead_xchacha20poly1305_ietf_encrypt(scope ubyte[] c,
                                                scope const ubyte[] m,
                                                scope const ubyte[] ad,
                                                const ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES] npub,
                                                const ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_xchacha20poly1305_ietf_encrypt: m is null"); // TODO check if m.ptr==null would be okay
  enforce(c.length == m.length + crypto_aead_xchacha20poly1305_ietf_ABYTES, "Error invoking crypto_aead_xchacha20poly1305_ietf_encrypt: out buffer too small");
  ulong clen_p;
  bool result = crypto_aead_xchacha20poly1305_ietf_encrypt(c.ptr, &clen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  if (result)
    assert(clen_p ==  m.length + crypto_aead_xchacha20poly1305_ietf_ABYTES); // okay to be removed in release code
  return  result;
}

alias crypto_aead_xchacha20poly1305_ietf_decrypt = deimos.sodium.crypto_aead_xchacha20poly1305.crypto_aead_xchacha20poly1305_ietf_decrypt;

/**
 * The function crypto_aead_xchacha20poly1305_ietf_decrypt()
  verifies that the ciphertext `c` (as produced by crypto_aead_xchacha20poly1305_ietf_encrypt()),
 * includes a valid tag using a secret key `k`, a public nonce `npub`, and additional data `ad`. c.length is the ciphertext length
 * in bytes with the authenticator, so it has to be at least crypto_aead_xchacha20poly1305_ietf_ABYTES.
 *
 * ad can be an empty array if no additional data are required.
 * The function returns false if the verification fails.
 * If the verification succeeds, the function returns true, puts the decrypted message into `m` and stores its actual number of bytes into `mlen_p`.
 * At most c.length - crypto_aead_xchacha20poly1305_ietf_ABYTES bytes will be put into m.
 */
bool crypto_aead_xchacha20poly1305_ietf_decrypt(scope ubyte[] m,
                                                scope const ubyte[] c,
                                                scope const ubyte[] ad,
                                                const ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES] npub,
                                                const ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
  enforce(c.length >= crypto_aead_xchacha20poly1305_ietf_ABYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_aead_xchacha20poly1305_ietf_ABYTES: ", crypto_aead_xchacha20poly1305_ietf_ABYTES);
  const  m_expect_len = c.length - crypto_aead_xchacha20poly1305_ietf_ABYTES;
  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_aead_xchacha20poly1305_ietf_ABYTES: ", m_expect_len);
  ulong mlen_p;
  bool result = crypto_aead_xchacha20poly1305_ietf_decrypt(m.ptr, &mlen_p, null, c.ptr, c.length, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
  if (result)
    assert(mlen_p  ==  m_expect_len); // okay to be removed in release code
  return  result;
}

alias crypto_aead_xchacha20poly1305_ietf_encrypt_detached = deimos.sodium.crypto_aead_xchacha20poly1305.crypto_aead_xchacha20poly1305_ietf_encrypt_detached;

bool  crypto_aead_xchacha20poly1305_ietf_encrypt_detached(scope ubyte[] c,
                                                          out ubyte[crypto_aead_xchacha20poly1305_ietf_ABYTES] mac,
                                                          scope const ubyte[] m,
                                                          scope const ubyte[] ad,
                                                          const ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES] npub,
                                                          const ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(m.length, "Error invoking crypto_aead_xchacha20poly1305_ietf_encrypt_detached: m is null"); // TODO check if m.ptr==null would be okay
  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  ulong maclen_p;
  bool result = crypto_aead_xchacha20poly1305_ietf_encrypt_detached(c.ptr, mac.ptr, &maclen_p, m.ptr, m.length, ad.ptr, ad.length, null, npub.ptr, k.ptr) == 0;
  assert(maclen_p == crypto_aead_xchacha20poly1305_ietf_ABYTES);
  return  result;
}

alias crypto_aead_xchacha20poly1305_ietf_decrypt_detached = deimos.sodium.crypto_aead_xchacha20poly1305.crypto_aead_xchacha20poly1305_ietf_decrypt_detached;

bool crypto_aead_xchacha20poly1305_ietf_decrypt_detached(scope ubyte[] m,
                                                         scope const ubyte[] c,
                                                         const ubyte[crypto_aead_xchacha20poly1305_ietf_ABYTES] mac,
                                                         scope const ubyte[] ad,
                                                         const ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES] npub,
                                                         const ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k) @nogc @trusted
{
//  enforce(c.length, "Error invoking crypto_aead_xchacha20poly1305_ietf_decrypt_detached: c is null"); // TODO check if c.ptr==null would be okay
  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  return  crypto_aead_xchacha20poly1305_ietf_decrypt_detached(m.ptr, null, c.ptr, c.length, mac.ptr, ad.ptr, ad.length, npub.ptr, k.ptr) == 0;
}



version(unittest)
{
  import wrapper.sodium.randombytes : randombytes;
  // share a key and nonce in the following unittests
  ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES]  nonce = void;
  ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES]   key   = void;

  static this() {
    randombytes(nonce);
    randombytes(key);
  }
}


@system
unittest
{
  import std.string : representation;
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_aead_xchacha20poly1305.d");

  auto message         = representation("test");
  enum message_len = 4UL;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[message_len + crypto_aead_xchacha20poly1305_ietf_ABYTES]  ciphertext;
  ulong  ciphertext_len;

  crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext.ptr, &ciphertext_len, message.ptr, message.length,
    additional_data.ptr, additional_data.length, null, nonce.ptr, key.ptr);

  ubyte[message_len]  decrypted;
  ulong decrypted_len;
  assert(ciphertext_len == ciphertext.length);
  assert(crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted.ptr, &decrypted_len, null, ciphertext.ptr, ciphertext_len,
      additional_data.ptr, additional_data.length, nonce.ptr, key.ptr) == 0);
  assert(decrypted == message); //writeln("Decrypted message (aead_chacha20poly1305): ", cast(string)decrypted);
  assert(decrypted_len == decrypted.length);

  // test null for &ciphertext_len / decrypted_len
  crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext.ptr, null, message.ptr, message.length,
    additional_data.ptr, additional_data.length, null, nonce.ptr, key.ptr);
  crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted.ptr, null, null, ciphertext.ptr, ciphertext_len,
    additional_data.ptr, additional_data.length, nonce.ptr, key.ptr);

  ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES] k;
  crypto_aead_xchacha20poly1305_ietf_keygen(k);
}

@safe
unittest
{
  import std.string : representation;
  import std.stdio : writeln, writefln;
  import wrapper.sodium.utils : sodium_increment;
  debug writeln("unittest block 2 from sodium.crypto_aead_xchacha20poly1305.d");

  assert(crypto_aead_xchacha20poly1305_ietf_keybytes()   == crypto_aead_xchacha20poly1305_ietf_KEYBYTES);
  assert(crypto_aead_xchacha20poly1305_ietf_nsecbytes()  == crypto_aead_xchacha20poly1305_ietf_NSECBYTES);
  assert(crypto_aead_xchacha20poly1305_ietf_npubbytes()  == crypto_aead_xchacha20poly1305_ietf_NPUBBYTES);
  assert(crypto_aead_xchacha20poly1305_ietf_abytes()     == crypto_aead_xchacha20poly1305_ietf_ABYTES);


  auto message         = representation("test");
  enum message_len = 4UL;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[message_len + crypto_aead_xchacha20poly1305_ietf_ABYTES]  ciphertext1;
  sodium_increment(nonce);

  assertThrown   (crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext1[0..$-1],              message, additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext1[0..$-message.length], null,    additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext1,                      message, null,            nonce, key));

  assert(crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext1, message, additional_data, nonce, key));

  ubyte[message_len]  decrypted;
  assertThrown   (crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted,         ciphertext1[0..crypto_aead_xchacha20poly1305_ietf_ABYTES-1], additional_data, nonce, key));
  assertThrown   (crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted[0..$-1], ciphertext1,                                                 additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted,         ciphertext1,                                                 null,            nonce, key));

  assert(crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted, ciphertext1, additional_data, nonce, key));
  assert(decrypted == message);
//
  ubyte[message_len] ciphertext2;
  ubyte[crypto_aead_xchacha20poly1305_ietf_ABYTES] mac;
  sodium_increment(nonce);

  assertThrown   (crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ciphertext2[0..$-1],              mac, message, additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ciphertext2[0..$-message.length], mac, null,    additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ciphertext2,                      mac, message, null,            nonce, key));

  assert(crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ciphertext2, mac, message, additional_data, nonce, key));

  assertThrown   (crypto_aead_xchacha20poly1305_ietf_decrypt_detached(decrypted[0..$-1],              ciphertext2, mac, additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_decrypt_detached(decrypted[0..$-message.length], null,       mac, additional_data, nonce, key));
  assertNotThrown(crypto_aead_xchacha20poly1305_ietf_decrypt_detached(decrypted,                      ciphertext2, mac, null,            nonce, key));

  assert(crypto_aead_xchacha20poly1305_ietf_decrypt_detached(decrypted, ciphertext2, mac, additional_data, nonce, key));
  assert(decrypted == message);
}


@nogc @safe
unittest
{
  // usage is not cryptographically safe here; it's purpose is to test @nogc @safe
  import std.string : representation;
  ubyte[crypto_aead_xchacha20poly1305_ietf_NPUBBYTES]  n = nonce;
  ubyte[crypto_aead_xchacha20poly1305_ietf_KEYBYTES]   k;
  crypto_aead_xchacha20poly1305_ietf_keygen(k);
  ubyte[4] message  = [116, 101, 115, 116]; //representation("test");
  ubyte[4] decrypted;
  enum  m_len  = 4UL;
  auto additional_data = representation("A typical use case for additional data is to store protocol-specific metadata " ~
    "about the message, such as its length and encoding. (non-confidential, non-encrypted data");
  ubyte[m_len+crypto_aead_xchacha20poly1305_ietf_ABYTES] ciphertext1;
  ubyte[m_len]                                           ciphertext2;
  ubyte[      crypto_aead_xchacha20poly1305_ietf_ABYTES] mac;

  assert(crypto_aead_xchacha20poly1305_ietf_encrypt(ciphertext1,   message, additional_data, n, k));
  assert(crypto_aead_xchacha20poly1305_ietf_decrypt(decrypted, ciphertext1, additional_data, n, k));
  assert(decrypted == message);
  decrypted = decrypted.init;
  assert(crypto_aead_xchacha20poly1305_ietf_encrypt_detached(ciphertext2, mac,   message, additional_data, n, k));
  assert(crypto_aead_xchacha20poly1305_ietf_decrypt_detached(decrypted, ciphertext2, mac, additional_data, n, k));
  assert(decrypted == message);
}
