module sodium.crypto_scalarmult;

import sodium.crypto_scalarmult_curve25519;

extern(C) pure @nogc
{
  enum crypto_scalarmult_BYTES = crypto_scalarmult_curve25519_BYTES;
  size_t crypto_scalarmult_bytes() @trusted;

  enum crypto_scalarmult_SCALARBYTES = crypto_scalarmult_curve25519_SCALARBYTES;
  size_t crypto_scalarmult_scalarbytes() @trusted;

//  immutable(char*) crypto_scalarmult_PRIMITIVE = "curve25519";
  enum crypto_scalarmult_PRIMITIVE = "curve25519";
  const(char)* crypto_scalarmult_primitive() @system;

  /**
   * Given a user's secret key (crypto_scalarmult_SCALARBYTES bytes), the crypto_scalarmult_base() function computes the user's
   * public key and puts it into publickey (crypto_scalarmult_BYTES bytes).
   * crypto_scalarmult_BYTES and crypto_scalarmult_SCALARBYTES are provided for consistency, but it is safe to assume that
   * crypto_scalarmult_BYTES == crypto_scalarmult_SCALARBYTES.
   */
  int crypto_scalarmult_base(ubyte* publickey, in ubyte* secretkey) @system;

  /**
   * This function can be used to compute a shared secret q given a user's secret key and another user's public key.
   * secretkey is crypto_scalarmult_SCALARBYTES bytes long, other_publickey and the output are crypto_scalarmult_BYTES bytes long.
   * q represents the X coordinate of a point on the curve.
   * As a result, the number of possible keys is limited to the group size (≈2^252), and the key distribution is not uniform.
   * For this reason, instead of directly using the output of the multiplication q as a shared key, it is recommended to use
   * h(q || pk1 || pk2), with pk1 and pk2 being the public keys. This can be achieved with the code snippet in the unittest.
   * Returns 0 on success, -1 on failure*/
  int crypto_scalarmult(ubyte* q, in ubyte* secretkey, in ubyte* other_publickey) nothrow @system;
}

import std.exception : enforce;
import sodium.crypto_generichash : crypto_generichash_state, crypto_generichash_BYTES,
  crypto_generichash_init, crypto_generichash_update, crypto_generichash_final,
  crypto_generichash_BYTES_MIN, crypto_generichash_BYTES_MAX ,crypto_generichash_multi;

/**
 * This function may be part of the keyexchange procedure:
 * It takes over from the arguments given, invokes crypto_scalarmult und results in the hashed our_sharedkey as proposed in the documentaion.
 * There is no heap allocation for secrets, yet enforce may require heap memory, thus inhibiting the attribute @nogc.
 * It may throw in error conditions.
 */
void sharedkey_hashed(ubyte[] our_sharedkey, in ubyte[crypto_scalarmult_SCALARBYTES] my_secretkey, in ubyte[crypto_scalarmult_BYTES] my_publickey,
  in bool my_pubkey_hashed_first, in ubyte[crypto_scalarmult_BYTES] other_publickey) pure @trusted
{
  /* I derive a shared key from my secret key and the other's public key */
  /* shared key = hash(q || client_publickey || server_publickey) */
  ubyte[crypto_scalarmult_BYTES]  our_scalarmult_q; // = new ubyte[crypto_scalarmult_BYTES];
  enforce( crypto_scalarmult(our_scalarmult_q.ptr, my_secretkey.ptr, other_publickey.ptr) == 0
    ,"sharedkey_hashed: Error result from calling crypto_scalarmult");
  /+ are there security concerns to pass our_scalarmult_q through RAM ?
  import sodium.utils : sodium_memzero;
  ubyte[][] MESSAGE_multi = [
    our_scalarmult_q,
    (my_pubkey_hashed_first? my_publickey.dup    : other_publickey.dup),
    (my_pubkey_hashed_first? other_publickey.dup : my_publickey.dup)
  ];
  scope(exit) sodium_memzero(MESSAGE_multi[0]);
  crypto_generichash_multi(our_sharedkey, MESSAGE_multi);
  +/
  enforce(our_sharedkey.length >= crypto_generichash_BYTES_MIN && our_sharedkey.length <= crypto_generichash_BYTES_MAX, "wrong length allocated for hash");
  crypto_generichash_state state;
  crypto_generichash_init  (&state, null, 0, our_sharedkey.length);
  crypto_generichash_update(&state, our_scalarmult_q.ptr, our_scalarmult_q.length);
  if (my_pubkey_hashed_first) {
    crypto_generichash_update(&state, my_publickey.ptr,    my_publickey.length);
    crypto_generichash_update(&state, other_publickey.ptr, other_publickey.length);
  }
  else {
    crypto_generichash_update(&state, other_publickey.ptr, other_publickey.length);
    crypto_generichash_update(&state, my_publickey.ptr,    my_publickey.length);
  }
  crypto_generichash_final (&state, our_sharedkey.ptr, our_sharedkey.length);
 }

pure @system
unittest
{
  import std.stdio : writeln;
  import sodium.randombytes : randombytes_buf;
  import std.algorithm.comparison : equal;
  import std.string : fromStringz; // @system

  debug  writeln("unittest block 1 from sodium.crypto_scalarmult.d");

  assert(crypto_scalarmult_bytes()       == crypto_scalarmult_BYTES);
  assert(crypto_scalarmult_scalarbytes() == crypto_scalarmult_SCALARBYTES);
  assert(equal(fromStringz(crypto_scalarmult_primitive()), crypto_scalarmult_PRIMITIVE));


  //test keyexchange procedure

  ubyte[crypto_scalarmult_SCALARBYTES]  client_secretkey, server_secretkey;
  ubyte[crypto_scalarmult_BYTES]        client_publickey, server_publickey;
/+ +/
  ubyte[crypto_scalarmult_BYTES]    scalarmult_q_by_client;
  ubyte[crypto_scalarmult_BYTES]    scalarmult_q_by_server;
  crypto_generichash_state h;
/+ +/
  ubyte[crypto_generichash_BYTES]   sharedkey_by_client, sharedkey_by_server;

  /* Create client's secret and public keys */
  randombytes_buf(client_secretkey);
  crypto_scalarmult_base(client_publickey.ptr, client_secretkey.ptr);

  /* Create server's secret and public keys */
  randombytes_buf(server_secretkey);
  crypto_scalarmult_base(server_publickey.ptr, server_secretkey.ptr);
/+ +/
  /* The client derives a shared key from its secret key and the server's public key */
  /* shared key = h(q || client_publickey || server_publickey) */
  if (crypto_scalarmult(scalarmult_q_by_client.ptr, client_secretkey.ptr, server_publickey.ptr) != 0) {
      /* Error */
  }
  crypto_generichash_init  (&h, null, 0U, /*crypto_generichash_BYTES*/ sharedkey_by_client.length);
  crypto_generichash_update(&h, scalarmult_q_by_client.ptr, scalarmult_q_by_client.length);
  crypto_generichash_update(&h, client_publickey.ptr,       client_publickey.length);
  crypto_generichash_update(&h, server_publickey.ptr,       server_publickey.length);
  crypto_generichash_final (&h, sharedkey_by_client.ptr,    sharedkey_by_client.length);

  /* The server derives a shared key from its secret key and the client's public key */
  /* shared key = h(q || client_publickey || server_publickey) */
  if (crypto_scalarmult(scalarmult_q_by_server.ptr, server_secretkey.ptr, client_publickey.ptr) != 0) {
    /* Error */
  }

  assert(scalarmult_q_by_client == scalarmult_q_by_server);

  crypto_generichash_init  (&h, null, 0U, /*crypto_generichash_BYTES*/ sharedkey_by_server.length);
  crypto_generichash_update(&h, scalarmult_q_by_server.ptr, scalarmult_q_by_server.length);
  crypto_generichash_update(&h, client_publickey.ptr,       client_publickey.length);
  crypto_generichash_update(&h, server_publickey.ptr,       server_publickey.length);
  crypto_generichash_final (&h, sharedkey_by_server.ptr,    sharedkey_by_server.length);

/* sharedkey_by_client and sharedkey_by_server are identical */
  assert(sharedkey_by_client == sharedkey_by_server);
  ubyte[crypto_generichash_BYTES] sharedkey_by_client_saved = sharedkey_by_client;
/+ +/

  sharedkey_by_client[] = ubyte.init;
  sharedkey_by_server[] = ubyte.init;
  // same as before with less user code
  sharedkey_hashed(sharedkey_by_client, client_secretkey, client_publickey, true,  server_publickey);
  sharedkey_hashed(sharedkey_by_server, server_secretkey, server_publickey, false, client_publickey);
  assert(sharedkey_by_client == sharedkey_by_server);
  assert(sharedkey_by_client == sharedkey_by_client_saved);
}
