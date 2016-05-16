# sodium


D language: A ("Deimos"-) binding to libsodium, current version 1.0.10, released on 5. Apr 2016 [https://github.com/jedisct1/libsodium]

The binding code is complete; every now and then I'll add some doxygen comments / function attributes, as I use, become acquainted with sodium's functions.

Finally, when testing on Windows is done too, D-versioning will "jump on the bandwagon" [== libsodium C-source release version].

# MS Windows users: Attention <br>
Trade security against convenience. If You vote for security, discard the executable .lib import library files included in subfolders of folder /lib <br>
README files tell where/how to get/generate them
Win32: Requires Digital Mars implib tool to generate import library (.lib, OMF format)
Win64: Requires Microsoft linker executable

# Example
( expected output: Unpredictable sequence of 8 bytes: [?, ?, ?, ?, ?, ?, ?, ?] )
- make shure, You have rdmd installed for this example and access right of app.d includes 'executable'
- change directory to example/source and run app.d

or
- setup a DUB project, dub.json: ... "dependencies": { "sodium": "~>0.0.5" }
