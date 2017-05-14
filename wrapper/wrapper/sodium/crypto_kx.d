// Written in the D programming language.

module wrapper.sodium.crypto_kx;

import wrapper.sodium.core; // assure sodium got initialized

public
import  deimos.sodium.crypto_kx : crypto_kx_PUBLICKEYBYTES,
                                  crypto_kx_publickeybytes,
                                  crypto_kx_SECRETKEYBYTES,
                                  crypto_kx_secretkeybytes,
                                  crypto_kx_SEEDBYTES,
                                  crypto_kx_seedbytes,
                                  crypto_kx_SESSIONKEYBYTES,
                                  crypto_kx_sessionkeybytes,
                                  crypto_kx_PRIMITIVE,
//                                crypto_kx_primitive,
                                  crypto_kx_seed_keypair,
                                  crypto_kx_keypair,
                                  crypto_kx_client_session_keys,
                                  crypto_kx_server_session_keys;


string crypto_kx_primitive() pure nothrow @nogc @trusted
{
  import std.string : fromStringz;
  static import deimos.sodium.crypto_kx;
  const(char)[] c_arr;
  try
    c_arr = fromStringz(deimos.sodium.crypto_kx.crypto_kx_primitive()); // strips terminating \0
  catch (Exception e) { /* known not to throw */ }
  return c_arr;
}


@safe
unittest {
  import std.stdio : writeln;
  debug writeln("unittest block 1 from sodium.crypto_kx.d");
}

@nogc @safe
unittest {
  import wrapper.sodium.crypto_secretbox;
  import wrapper.sodium.randombytes;
  assert(crypto_kx_publickeybytes()  == crypto_kx_PUBLICKEYBYTES);
  assert(crypto_kx_secretkeybytes()  == crypto_kx_SECRETKEYBYTES);
  assert(crypto_kx_seedbytes()       == crypto_kx_SEEDBYTES);
  assert(crypto_kx_sessionkeybytes() == crypto_kx_SESSIONKEYBYTES);
  assert(crypto_kx_primitive()       == crypto_kx_PRIMITIVE);

  ubyte[crypto_kx_PUBLICKEYBYTES]  client_pk;
  ubyte[crypto_kx_SECRETKEYBYTES]  client_sk;

  ubyte[crypto_kx_SESSIONKEYBYTES]  client_rx, client_tx;

  /*Generate the client's key pair */
  crypto_kx_keypair(client_pk, client_sk);
  /* Prerequisite after this point: the server's public key must be known by the client */

    ubyte[crypto_kx_PUBLICKEYBYTES]   server_pk;
    ubyte[crypto_kx_SECRETKEYBYTES]   server_sk;

    ubyte[crypto_kx_SESSIONKEYBYTES]  server_rx, server_tx;
    /* Generate the server's key pair */
    crypto_kx_keypair(server_pk, server_sk);

  /* Compute two shared keys using the server's public key and the client's secret key.
     client_rx will be used by the client to receive data from the server,
     client_tx will by used by the client to send data to the server.      */
  assert(crypto_kx_client_session_keys(client_rx, client_tx, client_pk, client_sk, server_pk) == 0);

    /* Prerequisite after this point: the client's public key must be known by the server */
    /* Compute two shared keys using the client's public key and the server's secret key.
       server_rx will be used by the server to receive data from the client,
       server_tx will by used by the server to send data to the client. */
    assert(crypto_kx_server_session_keys(server_rx, server_tx, server_pk, server_sk, client_pk) == 0);

  enum message_len = 4;
  ubyte[message_len]  message  = [116, 101, 115, 116]; //representation("test");
  ubyte[message_len]  decrypted;
  ubyte[message_len+crypto_secretbox_MACBYTES]  ciphertext;
  ubyte[crypto_secretbox_NONCEBYTES] nonce;
  randombytes(nonce);
  // client sends to server
  assert(crypto_secretbox_easy(ciphertext, message, nonce, client_tx));
    // server verifies and decrypts
    assert(crypto_secretbox_open_easy(decrypted, ciphertext, nonce, server_rx));
    assert(decrypted == message);

  message  = [110, 101, 120, 116]; //representation("next");
  // server sends to client
    assert(crypto_secretbox_easy(ciphertext, message, nonce, server_tx));
    // client verifies and decrypts
  assert(crypto_secretbox_open_easy(decrypted, ciphertext, nonce, client_rx));
  assert(decrypted == message);
  assert(client_tx == server_rx);
  assert(server_tx == client_rx);
}
