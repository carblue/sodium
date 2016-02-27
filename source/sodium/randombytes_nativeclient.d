// D import file generated from 'randombytes_nativeclient.d' renamed to 'randombytes_nativeclient.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.randombytes_nativeclient;

version (__native_client__)
{
	import sodium.randombytes;
	extern (C) extern randombytes_implementation randombytes_nativeclient_implementation;
}
