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

// The output encoding state
static unsigned out_L; // lower bound
static unsigned out_R; // code range
static unsigned out_bits_outstanding; // follow bit count

static void bit_plus_follow( int b ) {
    OUTPUT_BIT(b);
    while(out_bits_outstanding > 0) {
        OUTPUT_BIT(!b);
        out_bits_outstanding--;
    }
}

void start_encode( ) {
    out_L = 0; // Set initial coding range to
    out_R = Half; // [0,Half)
    out_bits_outstanding = 0;
}

void finish_encode( ) {
    unsigned nbits, i, bits;
    nbits = 32;
    bits = out_L;
    for (i = 1; i <= nbits; i++)
        bit_plus_follow(((bits >> (nbits-i)) & 1));
}

void encode( unsigned low, unsigned high, unsigned total ) {
    unsigned temp, out_r;
    out_r = out_R/total; // Calc range:freq ratio
    temp = out_r*low; // Calc low increment
    out_L += temp; // Increase L
    if (high < total)
        out_R = out_r*(high-low); // Restrict R
    else
        out_R -= temp;
    while (out_R <= Quarter) {
        if (out_L >= Half) {
            bit_plus_follow(1);
            out_L -= Half;
        } else if (out_L+out_R <= Half) {
            bit_plus_follow(0);
        } else {
            out_bits_outstanding++;
            out_L -= Quarter;
        }
        out_L <<= 1; out_R <<= 1;
    }
}

