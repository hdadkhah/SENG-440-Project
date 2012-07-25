README
======

The files in this folder implement the Arithmetic Coding equivalent
of adaptive Huffman coding.

The files bitio.h & bitio.c provide functions for input and output
of single bits from or to a binary file.

The files arith.h, encoder.c & decoder.c provide functions for
Arithmetic Coding and Decoding.  The bit I/O functions are used.

The files achuffman.h & achuffman.c implement a data model which
counts symbol frequencies and use it to compress and decompress
a file using Arithmetic Coding.

The file main.c checks command-line arguments, opens files and
invokes either the compress or decompress function in the
achuffman.c file.
