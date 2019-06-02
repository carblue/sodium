// Written in the D programming language.

module wrapper.sodium.crypto_secretbox;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_secretbox : crypto_secretbox_KEYBYTES,
                                         crypto_secretbox_keybytes,
                                         crypto_secretbox_NONCEBYTES,
                                         crypto_secretbox_noncebytes,
                                         crypto_secretbox_MACBYTES,
                                         crypto_secretbox_macbytes,
                                         crypto_secretbox_PRIMITIVE,
/*                                       crypto_secretbox_primitive,
                                         crypto_secretbox_easy,
                                         crypto_secretbox_open_easy,
                                         crypto_secretbox_detached,
                                         crypto_secretbox_open_detached,  */
                                         crypto_secretbox_keygen;
/*                                       crypto_secretbox_ZEROBYTES,
                                         crypto_secretbox_zerobytes,
                                         crypto_secretbox_BOXZEROBYTES,
                                         crypto_secretbox_boxzerobytes,
                                         crypto_secretbox,
                                         crypto_secretbox_open;  */

import std.exception : assertThrown;
import nogc.exception: enforce;


string crypto_secretbox_primitive() pure nothrow @nogc @trusted
{
  import std.string : fromStringz;
  static import deimos.sodium.crypto_secretbox;
  return  fromStringz(deimos.sodium.crypto_secretbox.crypto_secretbox_primitive()); // strips terminating \0
}

// overloading some functions between module deimos.sodium.crypto_secretbox and this module

alias crypto_secretbox_easy          = deimos.sodium.crypto_secretbox.crypto_secretbox_easy;

bool crypto_secretbox_easy(scope ubyte[] c,
                           scope const ubyte[] m,
                           const ubyte[crypto_secretbox_NONCEBYTES] nonce,
                           const ubyte[crypto_secretbox_KEYBYTES] key) @nogc @trusted
{
  const  c_expect_len = m.length + crypto_secretbox_MACBYTES;
//  enforce(c.length == c_expect_len, "Expected c.length: ", c.length, " to be equal to m.length + crypto_secretbox_MACBYTES: ", c_expect_len);
  enforce(c.length == c_expect_len, "Expected c.length is not equal to m.length + crypto_secretbox_MACBYTES");
  return  crypto_secretbox_easy(c.ptr, m.ptr, m.length, nonce.ptr, key.ptr) == 0; // __attribute__ ((nonnull(1, 4, 5)));
}

alias crypto_secretbox_open_easy     = deimos.sodium.crypto_secretbox.crypto_secretbox_open_easy;

bool crypto_secretbox_open_easy(scope ubyte[] m,
                                scope const ubyte[] c,
                                const ubyte[crypto_secretbox_NONCEBYTES] nonce,
                                const ubyte[crypto_secretbox_KEYBYTES] key) @nogc @trusted
{
//  enforce(c.length >= crypto_secretbox_MACBYTES, "Expected c.length: ", c.length, " to be greater_equal to crypto_secretbox_MACBYTES: ", crypto_secretbox_MACBYTES);
  enforce(c.length >= crypto_secretbox_MACBYTES, "Expected c.length is not greater_equal to crypto_secretbox_MACBYTES");
  const  m_expect_len = c.length - crypto_secretbox_MACBYTES;
//  enforce(m.length == m_expect_len, "Expected m.length: ", m.length, " to be equal to c.length - crypto_secretbox_MACBYTES: ", m_expect_len);
  enforce(m.length == m_expect_len, "Expected m.length is not equal to c.length - crypto_secretbox_MACBYTES");
  return  crypto_secretbox_open_easy(m.ptr, c.ptr, c.length, nonce.ptr, key.ptr) == 0; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 4, 5)));
}

alias crypto_secretbox_detached      = deimos.sodium.crypto_secretbox.crypto_secretbox_detached;

bool crypto_secretbox_detached(scope ubyte[] c,
                               out ubyte[crypto_secretbox_MACBYTES] mac,
                               scope const ubyte[] m,
                               const ubyte[crypto_secretbox_NONCEBYTES] nonce, const ubyte[crypto_secretbox_KEYBYTES] key) @nogc @trusted
{
//  enforce(c.length == m.length, "Expected c.length: ", c.length, " to be equal to m.length: ", m.length);
  enforce(c.length == m.length, "Expected c.length is not equal to m.length");
  return  crypto_secretbox_detached(c.ptr, mac.ptr, m.ptr, m.length, nonce.ptr, key.ptr) == 0; // __attribute__ ((nonnull(1, 2, 5, 6)));
}

alias crypto_secretbox_open_detached = deimos.sodium.crypto_secretbox.crypto_secretbox_open_detached;

bool crypto_secretbox_open_detached(scope ubyte[] m,
                                    scope const ubyte[] c,
                                    const ubyte[crypto_secretbox_MACBYTES] mac,
                                    const ubyte[crypto_secretbox_NONCEBYTES] nonce,
                                    const ubyte[crypto_secretbox_KEYBYTES] key) @nogc @trusted
{
//  enforce(m.length == c.length, "Expected m.length: ", m.length, " to be equal to c.length: ", c.length);
  enforce(m.length == c.length, "Expected m.length is not equal to c.length");
  return  crypto_secretbox_open_detached(m.ptr, c.ptr, mac.ptr, c.length, nonce.ptr, key.ptr) == 0; // __attribute__ ((warn_unused_result)) __attribute__ ((nonnull(2, 3, 5, 6)));
}

/* No overloads for -- NaCl compatibility interface ; Requires padding -- */

@system
unittest {
  import std.stdio : writeln;
  import wrapper.sodium.randombytes : randombytes;
  import deimos.sodium.crypto_secretbox;

  writeln("unittest block 1 from sodium.crypto_secretbox.d");

  ubyte[crypto_secretbox_NONCEBYTES]  nonce = void;
  ubyte[crypto_secretbox_KEYBYTES]    key   = void;
  randombytes(nonce);
  randombytes(key);

  enum message_len = 4;
  ubyte[crypto_secretbox_ZEROBYTES + message_len]  message, ciphertext, decrypted;
  message[crypto_secretbox_ZEROBYTES..crypto_secretbox_ZEROBYTES+message_len] = [116, 101, 115, 116];
  assert(crypto_secretbox     (ciphertext.ptr, message.ptr,    message.length,    nonce.ptr, key.ptr) == 0);
  assert(crypto_secretbox_open(decrypted.ptr,  ciphertext.ptr, ciphertext.length, nonce.ptr, key.ptr) == 0);
  assert(decrypted == message);
//  writeln("decrypted: ", decrypted[crypto_secretbox_ZEROBYTES..crypto_secretbox_ZEROBYTES+message_len]); // decrypted: [116, 101, 115, 116]
}

@safe
unittest {
  import std.string : representation;
  import std.stdio : writeln;
  import wrapper.sodium.randombytes : randombytes;
  import wrapper.sodium.utils : sodium_increment;

  debug writeln("unittest block 2 from sodium.crypto_secretbox.d");

  assert(crypto_secretbox_keybytes()   == crypto_secretbox_KEYBYTES);
  assert(crypto_secretbox_noncebytes() == crypto_secretbox_NONCEBYTES);
  assert(crypto_secretbox_macbytes()   == crypto_secretbox_MACBYTES);
  assert(crypto_secretbox_primitive()  == crypto_secretbox_PRIMITIVE);

  auto message = representation("test");
  // avoid heap allocation, like in the example code
  enum MESSAGE_LEN = 4;
  enum CIPHERTEXT_LEN = (crypto_secretbox_MACBYTES + MESSAGE_LEN);

  ubyte[crypto_secretbox_NONCEBYTES]  nonce = void;
  ubyte[crypto_secretbox_KEYBYTES]    key   = void;
  ubyte[CIPHERTEXT_LEN]               ciphertext = void;

  randombytes(nonce);
  crypto_secretbox_keygen(key);
  assertThrown(crypto_secretbox_easy(ciphertext[0..$-1], message, nonce, key));
  assert(crypto_secretbox_easy(ciphertext, message, nonce, key));
  version(none) {
    import std.array : appender;
    import std.base64 : Base64;
    auto app = appender!string();
    app.put("Message (plaintext): test\n");
    app.put("Ciphertext (base64): ");
    const(char)[] encoded = Base64.encode(ciphertext);
    app.put(encoded~"\n");
    app.put("Nonce      (base64): ");
    encoded = Base64.encode(nonce);
    app.put(encoded~"\n");
    app.put("Key        (base64): ");
    encoded = Base64.encode(key);
    app.put(encoded~"\n");
    writeln(app.data);
/* taking this from a previous run:
Message (plaintext): test
Ciphertext (base64): tNV0M68PZea7+XKsfTeiJuOxVfU=
Nonce      (base64): 0gkPP63C0it0WeeO1LIQk4BDLpHFD58Z
Key        (base64): AtN67ZJklRbVVJ7R9QwVbKFpZivWXFHq9YlwVbM9n6s=
*/
//ubyte[] decoded = Base64.decode("FPucA9l+");
    ubyte[crypto_secretbox_KEYBYTES]    key_   = Base64.decode("AtN67ZJklRbVVJ7R9QwVbKFpZivWXFHq9YlwVbM9n6s=");
    ubyte[crypto_secretbox_NONCEBYTES]  nonce_ = Base64.decode("0gkPP63C0it0WeeO1LIQk4BDLpHFD58Z");
    ubyte[CIPHERTEXT_LEN]               ciphertext1 = Base64.decode("tNV0M68PZea7+XKsfTeiJuOxVfU=");
    ubyte[MESSAGE_LEN]                  decrypted_  = void;
    assert(crypto_secretbox_open_easy(decrypted_, ciphertext1, nonce_, key_), "message forged!");
    assert(decrypted_ == message);
  }
  ubyte[MESSAGE_LEN]  decrypted = void;
  assertThrown(crypto_secretbox_open_easy(decrypted, ciphertext[0..$-1-crypto_secretbox_MACBYTES], nonce, key));
  assertThrown(crypto_secretbox_open_easy(decrypted[0..$-1], ciphertext, nonce, key));
  assert(crypto_secretbox_open_easy(decrypted, ciphertext, nonce, key), "message forged!");
  assert(decrypted == message);

  ubyte[crypto_secretbox_MACBYTES]  mac = void;
  ubyte[MESSAGE_LEN]  ciphertext2;
  decrypted  = decrypted.init;
  sodium_increment(nonce);
  assertThrown(crypto_secretbox_detached(ciphertext2[0..$-1], mac, message, nonce, key));
  assert(crypto_secretbox_detached(ciphertext2, mac, message, nonce, key));

  assertThrown(crypto_secretbox_open_detached(decrypted[0..$-1], ciphertext2, mac, nonce, key));
  assert(crypto_secretbox_open_detached(decrypted, ciphertext2, mac, nonce, key), "message forged!");
  assert(decrypted == message);
}
