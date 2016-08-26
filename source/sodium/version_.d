// D import file generated from 'version_.d' renamed to 'version_.d' (method [only for original == header file] results in very compact code and obviates to overhaul comments now)

module sodium.version_;

immutable(char*) SODIUM_VERSION_STRING = "1.0.11";
enum SODIUM_LIBRARY_VERSION_MAJOR = 9;
enum SODIUM_LIBRARY_VERSION_MINOR = 3;

extern (C) 
{
	const(char)* sodium_version_string();
	int sodium_library_version_major();
	int sodium_library_version_minor();
}
