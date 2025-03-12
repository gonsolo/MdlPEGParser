# MdlPEGParser

A PEG Parser for a NVIDIA MDL (Material Definition Language) material.

NVIDIAs MDL SDK uses a LL(1) parser with conflict resolution allowing LL(k)
grammars. MDLPEGParser is a Parsing Expression Grammar (PEG) parser for a
subset of MDL (effectivly only the gun_metal.mdl material) which is slightly
more elegant as it doesn't need any hacks for e.g. named arguments (that need
a lookahead of 2). Python [switched](https://peps.python.org/pep-0617) to a
PEG parser in 3.9.

Also included is a tiny LLVM JIT code generator which at the moment just takes
the second float value in the material (the first one is the MDL version) which
happens to be the base_color in the gun_metal material, and writes it to a pbm
image.

© 2025 Andreas Wendleder
