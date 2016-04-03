# sodium


D language: A ("Deimos"-) binding to libsodium, current version 1.0.9, released on 2 Apr 2016 [https://github.com/jedisct1/libsodium]

The binding code is complete; every now and then I'll add some doxygen comments, as I use, become acquainted with sodium's functions.

Finally, when testing on Windows is done too, D-versioning will "jump on the bandwagon" [== libsodium C-source release version].


# Example
( expected output: Unpredictable sequence of 8 bytes: [?, ?, ?, ?, ?, ?, ?, ?] )
- make shure, You have rdmd installed for this example and access right of app.d includes 'executable'
- change directory to example/source and run app.d

or
- setup a DUB project, dub.json: ... "dependencies": { "sodium": "~>0.0.5" }
