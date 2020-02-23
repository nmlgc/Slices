# Assembly slices for various compiler run-time libraries

Or actually, just a single one, from [the one decompilation project where
slicing out every statically linked C++ run-time translation unit from
disassembly dumps of multiple executables seemed like a great idea in the
beginning][1].

In hindsight, it was a giant waste of time. Any such bit-perfect decompilation
project eventually must use the original compiler anyway, which will just link
in its own libc as needed. Removing all that libc code in a single step and
using the original compiler immediately is the only reasonable thing to do.

So, this repo only serves as a cautionary tale, in case someone else wonders
about doing a similar bit-perfect decompilation project involving a statically
linked libc. Just get the original compiler with the original static libraries
in the correct version. If you can't find it, patch the closest version you
*can* find. Don't actually `include` anything from here!

Check the per-directory `README.md` for more information on the individual
library and compiler versions.

[1]: https://github.com/nmlgc/ReC98
