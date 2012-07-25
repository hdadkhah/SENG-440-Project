/* Simplified version of the algorithm in the paper:
   A. Moffat, R. Neal, I.H. Witten, "Arithmetic Coding Revisited"
   Proc. IEEE Data Compression Conference, Snowbird, Utah,
   March 1995.
*/

// We use 32 bit unsigned long integers for all calculations

#include <stdio.h>
#include "arith.h"
#include "bitio.h"

// HALF and QUARTER are defined in arith.h

// The input decoding state
static unsigned in_R; // code range
static unsigned in_D; // = V-L (V offset)
static unsigned in_r; // normalized range

void start_decode( ) {
    int i;
    in_D = 0; // Initial offset in range is 0
    in_R = Half; // Range = Half
    for ( i = 0; i < 32; i++ ) // Fill D
        in_D = (in_D << 1) | INPUT_BIT();
    if (in_D >= Half) {
        fprintf(stderr,"Corrupt input file (start_decode())\n");
        exit(1);
    }
}

void finish_decode( ) {
    /* No action */
}

unsigned decode_target( unsigned total ) {
    unsigned long target;
    in_r = in_R/total;
    target = in_D/in_r;
    return (target >= total ? total-1 : target);
}

/* Calls to decode() and decode_target() must be paired:
   1. decode_target returns a frequency which can be mapped
      to the decoded symbol,
   2. decode is then called with the low/high values
      associated with that decoded symbol.
*/
void decode( unsigned low, unsigned high, unsigned total ) {
    unsigned temp;
    // in_r already set by decode_target
    temp = in_r*low;
    in_D -= temp;
    if (high < total)
        in_R = in_r*(high-low);
    else
        in_R -= temp;
    // renormalize
    while (in_R <= Quarter) {
        in_R <<= 1;
        in_D = (in_D << 1) | INPUT_BIT();
    }
}
