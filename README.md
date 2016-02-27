# sodium


D language: A ("Deimos"-) binding to libsodium, current version 1.0.8, released on 25 Dec 2015 [https://github.com/jedisct1/libsodium]

The binding code is complete (in master and will be from v.0.0.5); every now and then I'll add some doxygen comments, as I use, become acquainted with functions.

For the time being, take the dependency as of http://code.dlang.org/packages/sodium/~master
If the linker should complain about undefined reference(s) concerning libsodium, it's time to check whether the installed version of libsodium provides the function(s) in question.
I'm thinking about expanding this binding to a 'version identifier controlled' "Deimos" (statically/dynamically linked at compile time, as it is now) OR "Derelict" (dynamically loaded) libsodium binding.
IMHO https://github.com/DerelictOrg/DerelictUtil has this nice feature: Handling of cases where the C-library binary has another (older) version than the API, this binding refers to (1.0.8).
https://derelictorg.github.io/dynstat.html : There are no undefined reference(s) concerning libsodium then, of course, and a developper can/needs to fine-tune/react upon case of missing symbol(s). 

Finally, when testing on Windows is done too, D-versioning will "jump on the bandwagon" [== libsodium C-source release version].



Example  ( expected output: Unpredictable sequence of 8 bytes: [?, ?, ?, ?, ?, ?, ?, ?] )
- make shure, You have rdmd installed for this example and access right of app.d includes 'executable'
- change directory to example/source
- Linux (in a shell): $ ./app.d
- Windows  (cmd.exe): $ app.d

or
- setup a DUB project, dub.json: ... "dependencies": { "sodium": "~master" }
