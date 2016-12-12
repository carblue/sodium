/*
Written in the D programming language.
For git maintenance (ensure at least one congruent line with originating C header):
#define sodium_H
*/

module sodium;

public :

import sodium.core;
import sodium.crypto_aead_aes256gcm;
import sodium.crypto_aead_chacha20poly1305;
import sodium.crypto_auth;
import sodium.crypto_auth_hmacsha256;
import sodium.crypto_auth_hmacsha512;
import sodium.crypto_auth_hmacsha512256;
import sodium.crypto_box;
import sodium.crypto_box_curve25519xsalsa20poly1305;
import sodium.crypto_core_hsalsa20;
import sodium.crypto_core_hchacha20;
import sodium.crypto_core_salsa20;
import sodium.crypto_core_salsa2012;
import sodium.crypto_core_salsa208;
import sodium.crypto_generichash;
import sodium.crypto_generichash_blake2b;
import sodium.crypto_hash;
import sodium.crypto_hash_sha256;
import sodium.crypto_hash_sha512;
import sodium.crypto_onetimeauth;
import sodium.crypto_onetimeauth_poly1305;
import sodium.crypto_pwhash;
import sodium.crypto_pwhash_argon2i;
import sodium.crypto_pwhash_scryptsalsa208sha256;
import sodium.crypto_scalarmult;
import sodium.crypto_scalarmult_curve25519;
import sodium.crypto_secretbox;
import sodium.crypto_secretbox_xsalsa20poly1305;
import sodium.crypto_shorthash;
import sodium.crypto_shorthash_siphash24;
import sodium.crypto_sign;
import sodium.crypto_sign_ed25519;
import sodium.crypto_stream;
import sodium.crypto_stream_aes128ctr;
import sodium.crypto_stream_chacha20;
import sodium.crypto_stream_salsa20;
import sodium.crypto_stream_salsa2012;
import sodium.crypto_stream_salsa208;
import sodium.crypto_stream_xsalsa20;
import sodium.crypto_verify_16;
import sodium.crypto_verify_32;
import sodium.crypto_verify_64;
import sodium.randombytes;
version (__native_client__)  import sodium.randombytes_nativeclient;
import sodium.randombytes_salsa20_random;
import sodium.randombytes_sysrandom;
import sodium.runtime;
import sodium.utils;
import sodium.version_;
