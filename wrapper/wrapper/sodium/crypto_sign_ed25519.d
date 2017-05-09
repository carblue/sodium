module wrapper.sodium.crypto_sign_ed25519;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_sign_ed25519: crypto_sign_ed25519ph_state,
                                           crypto_sign_ed25519ph_statebytes,
                                           crypto_sign_ed25519_BYTES,
                                           crypto_sign_ed25519_bytes,
                                           crypto_sign_ed25519_SEEDBYTES,
                                           crypto_sign_ed25519_seedbytes,
                                           crypto_sign_ed25519_PUBLICKEYBYTES,
                                           crypto_sign_ed25519_publickeybytes,
                                           crypto_sign_ed25519_SECRETKEYBYTES,
                                           crypto_sign_ed25519_secretkeybytes;
/*                                         crypto_sign_ed25519,
                                           crypto_sign_ed25519_open,
                                           crypto_sign_ed25519_detached,
                                           crypto_sign_ed25519_verify_detached,
                                           crypto_sign_ed25519_keypair,
                                           crypto_sign_ed25519_seed_keypair,
                                           crypto_sign_ed25519_pk_to_curve25519,
                                           crypto_sign_ed25519_sk_to_curve25519,
                                           crypto_sign_ed25519_sk_to_seed,
                                           crypto_sign_ed25519_sk_to_pk,
                                           crypto_sign_ed25519ph_init,
                                           crypto_sign_ed25519ph_update,
                                           crypto_sign_ed25519ph_final_create,
                                           crypto_sign_ed25519ph_final_verify; */

import deimos.sodium.crypto_scalarmult_curve25519 : crypto_scalarmult_curve25519_BYTES;

import std.exception : enforce, assumeWontThrow;


// overloading functions between module deimos.sodium.crypto_sign_ed25519 and this module

alias crypto_sign_ed25519 = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519;

bool  crypto_sign_ed25519(ubyte[] sm,
                          in ubyte[] m,
                          in ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) pure /*@nogc*/ @trusted
{
//  enforce(m.length, "Error invoking crypto_sign_ed25519: m is null"); // TODO check if m.ptr==null would be okay
  enforce(sm.length >= m.length + crypto_sign_ed25519_BYTES, "Error invoking crypto_sign_ed25519: out buffer too small");
  ulong  smlen_p;
  bool  result = crypto_sign_ed25519(sm.ptr, &smlen_p, m.ptr, m.length, sk.ptr) == 0;
  if (result && smlen_p)
    assert(smlen_p ==  m.length + crypto_sign_ed25519_BYTES); // okay to be removed in release code
  return  result;
}

alias crypto_sign_ed25519_open = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_open;

bool  crypto_sign_ed25519_open(ubyte[] m,
                               in ubyte[] sm,
                               in ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk) pure /*@nogc*/ @trusted //  __attribute__ ((warn_unused_result))
{
  enforce(sm.length >= crypto_sign_ed25519_BYTES, "Error invoking crypto_sign_ed25519_open: in buffer too small"); // TODO check if m.ptr==null would be okay
  enforce(m.length >= sm.length - crypto_sign_ed25519_BYTES, "Error invoking crypto_sign_ed25519_open: out buffer too small");
  ulong mlen_p;
  bool  result = crypto_sign_ed25519_open(m.ptr, &mlen_p, sm.ptr, sm.length, pk.ptr) == 0;
  if (result)
    assert(mlen_p ==  sm.length - crypto_sign_ed25519_BYTES); // okay to be removed in release code
  return  result;
}

alias crypto_sign_ed25519_detached = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_detached;

bool  crypto_sign_ed25519_detached(out ubyte[crypto_sign_ed25519_BYTES] sig,
                                   in ubyte[] m,
                                   in ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) pure @nogc @trusted
{
  ulong siglen_p;
  bool result = crypto_sign_ed25519_detached(sig.ptr, &siglen_p, m.ptr, m.length, sk.ptr) == 0;
  if (siglen_p && result)
    assert(siglen_p == crypto_sign_ed25519_BYTES);
  return  result;
}

alias crypto_sign_ed25519_verify_detached = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_verify_detached;

pragma(inline, true)
bool  crypto_sign_ed25519_verify_detached(in ubyte[crypto_sign_ed25519_BYTES] sig,
                                          in ubyte[] m,
                                          in ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk) pure nothrow @nogc @trusted //  __attribute__ ((warn_unused_result))
{
  return  crypto_sign_ed25519_verify_detached(sig.ptr, m.ptr, m.length, pk.ptr) == 0;
}


alias crypto_sign_ed25519_keypair = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_keypair;

pragma(inline, true)
bool  crypto_sign_ed25519_keypair(out ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk, out ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) nothrow @nogc @trusted
{
  return  crypto_sign_ed25519_keypair(pk.ptr, sk.ptr) == 0;
}


alias crypto_sign_ed25519_seed_keypair = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_seed_keypair;

pragma(inline, true)
bool  crypto_sign_ed25519_seed_keypair(out ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk,
                                       out ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk,
                                       in  ubyte[crypto_sign_ed25519_SEEDBYTES] seed) pure @nogc @trusted
{
  return  crypto_sign_ed25519_seed_keypair(pk.ptr, sk.ptr, seed.ptr) == 0;
}

alias crypto_sign_ed25519_pk_to_curve25519 = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_pk_to_curve25519;

pragma(inline, true)
bool  crypto_sign_ed25519_pk_to_curve25519(out ubyte[crypto_scalarmult_curve25519_BYTES] curve25519_pk,
                                           in  ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] ed25519_pk) pure nothrow @nogc @trusted //  __attribute__ ((warn_unused_result))
{
  return  crypto_sign_ed25519_pk_to_curve25519(curve25519_pk.ptr, ed25519_pk.ptr) == 0;
}

alias crypto_sign_ed25519_sk_to_curve25519 = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_sk_to_curve25519;

pragma(inline, true)
bool  crypto_sign_ed25519_sk_to_curve25519(out ubyte[crypto_scalarmult_curve25519_BYTES] curve25519_sk,
                                           in  ubyte[crypto_sign_ed25519_SECRETKEYBYTES] ed25519_sk) pure @nogc @trusted
{
  return  crypto_sign_ed25519_sk_to_curve25519(curve25519_sk.ptr, ed25519_sk.ptr) == 0;
}

alias crypto_sign_ed25519_sk_to_seed = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_sk_to_seed;

pragma(inline, true)
bool  crypto_sign_ed25519_sk_to_seed(out ubyte[crypto_sign_ed25519_SEEDBYTES] seed,
                                     in  ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) pure @nogc @trusted
{
  return  crypto_sign_ed25519_sk_to_seed(seed.ptr, sk.ptr) == 0;
}

alias crypto_sign_ed25519_sk_to_pk = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519_sk_to_pk;

pragma(inline, true)
bool  crypto_sign_ed25519_sk_to_pk(out ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk,
                                   in  ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) pure @nogc @trusted
{
  return  crypto_sign_ed25519_sk_to_pk(pk.ptr, sk.ptr) == 0;
}

alias crypto_sign_ed25519ph_init = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519ph_init;

pragma(inline, true)
bool  crypto_sign_ed25519ph_init(ref crypto_sign_ed25519ph_state state) pure @nogc @trusted
{
  return  crypto_sign_ed25519ph_init(&state) == 0;
}

alias crypto_sign_ed25519ph_update = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519ph_update;

pragma(inline, true)
bool  crypto_sign_ed25519ph_update(ref crypto_sign_ed25519ph_state state,
                                   in ubyte[] m) pure @nogc @trusted
{
  return  crypto_sign_ed25519ph_update(&state, m.ptr, m.length) == 0;
}

alias crypto_sign_ed25519ph_final_create = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519ph_final_create;

pragma(inline, true)
bool  crypto_sign_ed25519ph_final_create(ref crypto_sign_ed25519ph_state state,
                                         out ubyte[crypto_sign_ed25519_BYTES] sig,
                                         in  ubyte[crypto_sign_ed25519_SECRETKEYBYTES] sk) pure @nogc @trusted
{
  return  crypto_sign_ed25519ph_final_create(&state, sig.ptr, null, sk.ptr) == 0;
}

alias crypto_sign_ed25519ph_final_verify = deimos.sodium.crypto_sign_ed25519.crypto_sign_ed25519ph_final_verify;

pragma(inline, true)
bool  crypto_sign_ed25519ph_final_verify(ref crypto_sign_ed25519ph_state state,
                                         out ubyte[crypto_sign_ed25519_BYTES] sig,
                                         in  ubyte[crypto_sign_ed25519_PUBLICKEYBYTES] pk) pure nothrow @nogc @trusted
{
  return  crypto_sign_ed25519ph_final_verify(&state, sig.ptr, pk.ptr) == 0;
}


@system
unittest
{
  import std.stdio : writeln;
  import std.string : representation; // fromStringz
  import std.algorithm.comparison : equal;
//  import std.exception : assertThrown, assertNotThrown;
  debug  writeln("unittest block 1 from sodium.crypto_sign_ed25519.d");

  auto  message = representation("test");
  enum  message_len = 4;
  ubyte[crypto_sign_ed25519_PUBLICKEYBYTES]  pk = void;
  ubyte[crypto_sign_ed25519_SECRETKEYBYTES]  sk = void;
  ubyte[crypto_sign_ed25519_SEEDBYTES] seed;
  assert(crypto_sign_ed25519_seed_keypair(pk.ptr, sk.ptr, seed.ptr) == 0);
  assert(crypto_sign_ed25519_keypair(pk.ptr, sk.ptr) == 0); // considered impure

  ubyte[crypto_sign_ed25519_BYTES	+	message_len]  signed_message;
  ulong  signed_message_len;
  crypto_sign_ed25519(signed_message.ptr, &signed_message_len, message.ptr, message.length, sk.ptr);
  assert(signed_message_len == signed_message.length);

  ubyte[message_len]  unsigned_message;
  ulong               unsigned_message_len;
  assert(crypto_sign_ed25519_open(unsigned_message.ptr, &unsigned_message_len,
    signed_message.ptr,	signed_message_len, pk.ptr) == 0);
  assert(equal(message[], unsigned_message[]));

  ubyte[crypto_sign_ed25519_BYTES]  sig;
  assert(crypto_sign_ed25519_detached(sig.ptr, null,  message.ptr, message_len, sk.ptr) == 0);
  assert(crypto_sign_ed25519_verify_detached(sig.ptr, message.ptr, message_len, pk.ptr) == 0);

  ubyte[crypto_scalarmult_curve25519_BYTES]  curve25519_pk = void;
  ubyte[crypto_scalarmult_curve25519_BYTES]  curve25519_sk = void;
  crypto_sign_ed25519_pk_to_curve25519(curve25519_pk.ptr, pk.ptr);
  crypto_sign_ed25519_sk_to_curve25519(curve25519_sk.ptr, sk.ptr);

  auto  message_part1 = representation("Arbitrary data to hash");
  auto  message_part2 = representation("is longer than expected");
  crypto_sign_ed25519ph_state  state, state_copy;

/*	signature	creation	*/
  crypto_sign_ed25519ph_init  (&state);
  crypto_sign_ed25519ph_update(&state, message_part1.ptr, message_part1.length);
  crypto_sign_ed25519ph_update(&state, message_part2.ptr, message_part2.length);
  state_copy = state;
  crypto_sign_ed25519ph_final_create(&state, sig.ptr, null, sk.ptr);
  /*	signature	verification	*/
//  crypto_sign_ed25519ph_init  (&state);
//  crypto_sign_ed25519ph_update(&state, message_part1.ptr, message_part1.length);
//  crypto_sign_ed25519ph_update(&state, message_part2.ptr, message_part2.length);
  assert(crypto_sign_ed25519ph_final_verify(&state_copy, sig.ptr, pk.ptr) == 0);
}


@safe
unittest
{
  import std.stdio : writeln;
  import std.string : representation; // fromStringz
  import std.algorithm.comparison : equal;
  import std.exception : assertThrown, assertNotThrown;
  import wrapper.sodium.randombytes;
//  import std.range : iota, array;
//  import std.stdio : writeln, writefln;
//  import std.algorithm.comparison : equal;
//  import wrapper.sodium.randombytes : randombytes;
  debug  writeln("unittest block 2 from sodium.crypto_sign_ed25519.d");

  assert(crypto_sign_ed25519ph_statebytes()   == crypto_sign_ed25519ph_state.sizeof);
  assert(crypto_sign_ed25519_bytes()          == crypto_sign_ed25519_BYTES);
  assert(crypto_sign_ed25519_seedbytes()      == crypto_sign_ed25519_SEEDBYTES);
  assert(crypto_sign_ed25519_publickeybytes() == crypto_sign_ed25519_PUBLICKEYBYTES);
  assert(crypto_sign_ed25519_secretkeybytes() == crypto_sign_ed25519_SECRETKEYBYTES);

  ubyte[crypto_sign_ed25519_PUBLICKEYBYTES]  pk   = void;
  ubyte[crypto_sign_ed25519_SECRETKEYBYTES]  sk   = void;
  ubyte[crypto_sign_ed25519_SEEDBYTES]       seed = void;
  randombytes(seed);

  assert(crypto_sign_ed25519_keypair(pk, sk));
  assert(crypto_sign_ed25519_seed_keypair(pk, sk, seed));

  auto     message = representation("test");
  enum     message_len = 4;
  ubyte[crypto_sign_ed25519_BYTES + message_len]  signed_message;
  assertNotThrown(crypto_sign_ed25519(signed_message[0..$-message_len], null,    sk));
  assert         (crypto_sign_ed25519(signed_message, message, sk));

  ubyte[message_len]  unsigned_message;
  assertNotThrown(crypto_sign_ed25519_open(unsigned_message, signed_message, pk));
  assert(crypto_sign_ed25519_open(unsigned_message, signed_message, pk));
  assert(equal(message[], unsigned_message[]));

  ubyte[crypto_sign_ed25519_BYTES]  sig;

  assert(crypto_sign_ed25519_detached(sig, message, sk));
  assert(crypto_sign_ed25519_verify_detached(sig, message,  pk));

  ubyte[crypto_scalarmult_curve25519_BYTES]  curve25519_pk = void;
  ubyte[crypto_scalarmult_curve25519_BYTES]  curve25519_sk = void;
  crypto_sign_ed25519_pk_to_curve25519(curve25519_pk, pk);
  crypto_sign_ed25519_sk_to_curve25519(curve25519_sk, sk);

  ubyte[crypto_sign_ed25519_PUBLICKEYBYTES]  pk2   = void;
  ubyte[crypto_sign_ed25519_SEEDBYTES]       seed2 = void;

  assert(crypto_sign_ed25519_sk_to_pk(pk2, sk));
  assert(equal(pk[], pk2[]));
  assert(crypto_sign_ed25519_sk_to_seed(seed2, sk));
  assert(equal(seed[], seed2[]));

  auto  message_part1 = representation("Arbitrary data to hash");
  auto  message_part2 = representation("is longer than expected");
  crypto_sign_ed25519ph_state  state, state_copy;

  /*	signature	creation	*/
  assert(crypto_sign_ed25519ph_init  (state));
  assert(crypto_sign_ed25519ph_update(state, message_part1));
  assert(crypto_sign_ed25519ph_update(state, message_part2));
  state_copy = state;
  assert(crypto_sign_ed25519ph_final_create(state, sig, sk));

  /*	signature	verification	*/
//  crypto_sign_ed25519ph_init  (state_copy);
//  crypto_sign_ed25519ph_update(state_copy, message_part1);
//  crypto_sign_ed25519ph_update(state_copy, message_part2);
  crypto_sign_ed25519ph_final_verify(state_copy, sig, pk);

}
