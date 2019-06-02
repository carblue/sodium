// Written in the D programming language.

module wrapper.sodium.crypto_auth_hmacsha512;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_auth_hmacsha512 : crypto_auth_hmacsha512_BYTES,
                                               crypto_auth_hmacsha512_bytes,
                                               crypto_auth_hmacsha512_KEYBYTES,
                                               crypto_auth_hmacsha512_keybytes,
/*                                             crypto_auth_hmacsha512,
                                               crypto_auth_hmacsha512_verify,  */
                                               crypto_auth_hmacsha512_state,
                                               crypto_auth_hmacsha512_statebytes,
/*                                             crypto_auth_hmacsha512_init,
                                               crypto_auth_hmacsha512_update,
                                               crypto_auth_hmacsha512_final,   */
                                               crypto_auth_hmacsha512_keygen;


// overloading some functions between module deimos.sodium.crypto_auth_hmacsha512 and this module

alias  crypto_auth_hmacsha512        = deimos.sodium.crypto_auth_hmacsha512.crypto_auth_hmacsha512;
alias  crypto_auth_hmacsha512_verify = deimos.sodium.crypto_auth_hmacsha512.crypto_auth_hmacsha512_verify;
alias  crypto_auth_hmacsha512_init   = deimos.sodium.crypto_auth_hmacsha512.crypto_auth_hmacsha512_init;
alias  crypto_auth_hmacsha512_update = deimos.sodium.crypto_auth_hmacsha512.crypto_auth_hmacsha512_update;
alias  crypto_auth_hmacsha512_final  = deimos.sodium.crypto_auth_hmacsha512.crypto_auth_hmacsha512_final;


pragma(inline, true)  @nogc pure @trusted
{
/**
 * The crypto_auth_hmacsha512() function authenticates a message `message` using the secret	key skey,
 * and puts the	authenticator	into mac.
 * Returns 0? on success.
 */
bool crypto_auth_hmacsha512(out ubyte[crypto_auth_hmacsha512_BYTES] mac,
                           scope const ubyte[] message,
                           const ubyte[crypto_auth_hmacsha512_KEYBYTES] skey)
{
  return  crypto_auth_hmacsha512(mac.ptr, message.ptr, message.length, skey.ptr) == 0;
}

/**
 * The crypto_auth_hmacsha512_verify() function	verifies in constant time that h is a correct
 * authenticator for the message in whose length is inlen under a secret key k.
 * It returns -1  if the verification fails, and 0 on success.
 */
bool crypto_auth_hmacsha512_verify(const ubyte[crypto_auth_hmacsha512_BYTES] mac,
                                   scope const ubyte[] message,
                                   const ubyte[crypto_auth_hmacsha512_KEYBYTES] skey) nothrow
{
  return  crypto_auth_hmacsha512_verify(mac.ptr, message.ptr, message.length, skey.ptr) == 0;
}

/**
 * This alternative API supports a key of arbitrary length
 */
bool crypto_auth_hmacsha512_init(out crypto_auth_hmacsha512_state state,
                                 scope const ubyte[] skey)
{
  return  crypto_auth_hmacsha512_init(&state, skey.ptr, skey.length) == 0;
}

bool crypto_auth_hmacsha512_update(ref crypto_auth_hmacsha512_state state,
                                   scope const ubyte[] in_)
{
  return  crypto_auth_hmacsha512_update(&state, in_.ptr, in_.length) == 0;
}

bool crypto_auth_hmacsha512_final(ref crypto_auth_hmacsha512_state state,
                                  out ubyte[crypto_auth_hmacsha512_BYTES] out_)
{
  return  crypto_auth_hmacsha512_final(&state, out_.ptr) == 0;
}
} //pragma(inline, true)  pure @nogc @trusted


@safe
unittest
{
  import std.stdio : writeln;
  import std.string : representation;
  import wrapper.sodium.randombytes : randombytes;

  debug writeln("unittest block 1 from sodium.crypto_auth_hmacsha512.d");

  assert(crypto_auth_hmacsha512_bytes()      == crypto_auth_hmacsha512_BYTES);
  assert(crypto_auth_hmacsha512_keybytes()   == crypto_auth_hmacsha512_KEYBYTES);
  assert(crypto_auth_hmacsha512_statebytes() == crypto_auth_hmacsha512_state.sizeof);   // 416
//  writeln("crypto_auth_hmacsha512_statebytes(): ", crypto_auth_hmacsha512_statebytes());   // 416
//  writeln("crypto_auth_hmacsha512_state.sizeof: ", crypto_auth_hmacsha512_state.sizeof);   // 416 = 2*crypto_hash_sha512_state.sizeof

  auto                                   message  = representation("test some more text");
  auto                                   message2 = representation(" some more text");
  ubyte[crypto_auth_hmacsha512_KEYBYTES] skey;
  ubyte[crypto_auth_hmacsha512_BYTES]    mac;

  randombytes(skey);
  assert(crypto_auth_hmacsha512(mac, message, skey));
  assert(crypto_auth_hmacsha512_verify(mac, message, skey));
  ubyte[crypto_auth_hmacsha512_BYTES]    mac_saved = mac;

  message  = representation("test");
  crypto_auth_hmacsha512_state state;
  assert(crypto_auth_hmacsha512_init  (state, skey));
  assert(crypto_auth_hmacsha512_update(state, message));
  assert(crypto_auth_hmacsha512_update(state, message2));
  assert(crypto_auth_hmacsha512_final (state, mac));
  message  = representation("test some more text");
  assert(crypto_auth_hmacsha512_verify(mac, message, skey));
  assert(mac == mac_saved);
  ubyte[crypto_auth_hmacsha512_KEYBYTES] k;
  crypto_auth_hmacsha512_keygen(k);
}