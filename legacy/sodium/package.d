module sodium;

public :

import sodium.core; /* unittest, max @trusted */
import sodium.crypto_aead_aes256gcm;
import sodium.crypto_aead_chacha20poly1305;
import sodium.crypto_auth;
import sodium.crypto_auth_hmacsha256;
import sodium.crypto_auth_hmacsha512;
import sodium.crypto_auth_hmacsha512256;
import sodium.crypto_box; // imports sodium.crypto_box_curve25519xsalsa20poly1305
//import sodium.crypto_box_curve25519xsalsa20poly1305;
import sodium.crypto_core_hsalsa20;
import sodium.crypto_core_hchacha20;
import sodium.crypto_core_salsa20;
import sodium.crypto_core_salsa2012;
import sodium.crypto_core_salsa208;
import sodium.crypto_generichash; // imports sodium.crypto_generichash_blake2b
//import sodium.crypto_generichash_blake2b;
import sodium.crypto_hash; // imports sodium.crypto_hash_sha512
import sodium.crypto_hash_sha256;
//import sodium.crypto_hash_sha512;
import sodium.crypto_onetimeauth; // imports sodium.crypto_onetimeauth_poly1305
//import sodium.crypto_onetimeauth_poly1305;
import sodium.crypto_pwhash; // imports sodium.crypto_pwhash_argon2i
//import sodium.crypto_pwhash_argon2i;
import sodium.crypto_pwhash_scryptsalsa208sha256;
import sodium.crypto_scalarmult; // imports sodium.crypto_scalarmult_curve25519 /* unittest, max @trusted */
//import sodium.crypto_scalarmult_curve25519; /* unittest, max @trusted */
import sodium.crypto_secretbox; // imports sodium.crypto_secretbox_xsalsa20poly1305
//import sodium.crypto_secretbox_xsalsa20poly1305;
import sodium.crypto_shorthash;
import sodium.crypto_shorthash_siphash24;
import sodium.crypto_sign;
import sodium.crypto_sign_ed25519;
import sodium.crypto_stream; // imports sodium.crypto_stream_xsalsa20 /* unittest, max @trusted */
import sodium.crypto_stream_aes128ctr;
import sodium.crypto_stream_chacha20;
import sodium.crypto_stream_salsa20;
import sodium.crypto_stream_salsa2012;
import sodium.crypto_stream_salsa208;
//import sodium.crypto_stream_xsalsa20; /* unittest, max @trusted */
import sodium.crypto_verify_16; /* unittest, max @trusted */
import sodium.crypto_verify_32; /* unittest, max @trusted */
import sodium.crypto_verify_64; /* unittest, max @trusted */
import sodium.randombytes; /* unittest, max @trusted */
version(__native_client__)  import sodium.randombytes_nativeclient; /* unittest not required */
import sodium.randombytes_salsa20_random;  /* unittest not required */
import sodium.randombytes_sysrandom;  /* unittest not required */
import sodium.runtime;  /* unittest, max @trusted */
import sodium.utils;    /* unittest ??, max @trusted */
import sodium.version_; /* unittest, max @trusted */
