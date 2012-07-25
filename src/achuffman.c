/*
 * achuffman.c
 *
 * Uses the symbol counting model of Adaptive Huffman Coding as
 * a means to generate probabilities for Arithmetic Coding
 *
 * This implementation is inefficient because of the way that
 * cumulative symbol counts are maintained and updated.
 * There are better ways of doing this!
 *
 * Author: Nigel Horspool, May 2012 
 *
*/

#include <stdio.h>
#include <stdlib.h>
#include "arith.h"
#include "achuffman.h"

// Table of cumulative symbol counts
// The entry in position k = sum of counts for symbols 0 to k-1
// Note: 256 is used as an EOF code
static unsigned cumFreq[258];

static void initModel( ) {
    int i;
    for ( i = 0; i <= 257; i++ )
        cumFreq[i] = i;
}

static void updateModel( int ch ) {
    while(++ch <= 257)
        cumFreq[ch]++; // Very inefficient!!
}

// compresses the file and returns number of bytes read
int compress( FILE *f ) {
    int ch;
    int byteCount = 0;
    initModel();
    start_encode();
    for( ch = fgetc(f); ch != EOF; ch = fgetc(f) ) {
        byteCount++;
        encode(cumFreq[ch], cumFreq[ch+1], cumFreq[257]);
        updateModel(ch);
    }
    encode(cumFreq[256],cumFreq[257],cumFreq[257]); // EOF
    finish_encode();
    return byteCount;
}

static int freqToSymbol( unsigned freq ) {
    int i;
    for( i = 0; i < 256; i++ ) {
        if (cumFreq[i+1] > freq) break;
    }
    return i;
}

// decompresses the file and returns number of bytes written
int decompress( FILE *f ) {
    int byteCount = 0;
    initModel();
    start_decode();
    for( ; ; ) {
        int freq = decode_target(cumFreq[257]);
        int ch = freqToSymbol(freq);
        if (ch == 256) break; // 256 is our EOF Code
        byteCount++;
        fputc(ch, f);
        decode(cumFreq[ch], cumFreq[ch+1], cumFreq[257]);
        updateModel(ch);
    }
    finish_decode();
    return byteCount;
}
