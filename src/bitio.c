// bitio.c

#include <stdio.h>
#include "bitio.h"

static unsigned int bytesInput = 0;
static unsigned int bytesOutput = 0;

static int      inputBuffer;             // 8 bit input buffer
static unsigned char inputBitMask = 0;   // position of next bit to access

static int      outputBuffer;            // 8 bit output buffer
static int      outputBitPos;            // #bits space left in output buffer


FILE *outputfile = NULL;
FILE *inputfile = NULL;

// initialize the bit output function
void startOutputtingBits( FILE *of ) {
    outputfile = of;
    outputBuffer = 0;
    outputBitPos = BYTE_SIZE;
}

// start the bit input function
void startInputtingBits(FILE *inf) {
    inputfile = inf;
    inputBitMask = 0;    // No valid bits yet in input buffer
}

// INPUT_BIT
int INPUT_BIT( ) {
    int result = 0;
    if (inputBitMask == 0) {
        inputBuffer = fgetc(inputfile);
        if (inputBuffer == EOF) {
            fprintf(stderr,
                "Bad input file - attempted to read past end of file.\n");
            exit(1);
        } else {
            bytesInput++;
        }
        inputBitMask = (1<<(BYTE_SIZE-1));
    }
    if (inputBuffer & inputBitMask) result = 1;
    inputBitMask >>= 1;
    return result;
}


int INPUT_BYTE() {
    int bitioTemp = fgetc(inputfile);
    bytesInput += (bitioTemp == EOF ) ? 0 : 1;
    return bitioTemp;
}


/*
 * OUTPUT_BIT(b)
 *
 * Outputs bit 'b' to output file.  (Builds up a buffer,
 * writing a byte at a time.)
 */
void OUTPUT_BIT( int b ) {
    outputBuffer <<= 1;
    if (b)
        outputBuffer |= 1;
        outputBitPos--;
    if (outputBitPos == 0) {
        fputc(outputBuffer, outputfile);
        bytesOutput++;
        outputBitPos = BYTE_SIZE;
        outputBuffer = 0;
    }
}


// complete outputting bits
void doneOutputtingBits(void) {
    if (outputBitPos != BYTE_SIZE) {
        fputc(outputBuffer << outputBitPos, outputfile);
        bytesOutput++;
    }
    outputBitPos = BYTE_SIZE;
    fclose(outputfile);
    outputfile = NULL;
}

//complete inputting bits
void doneInputtingBits(void) {
    inputBitMask = 0;          // "Wipe" buffer (in case more input follows)
    fclose(inputfile);
    inputfile = NULL;
}

// Number of bytes read with bitio functions.
int bytesRead(void) {
    return bytesInput;
}

// Number of bytes written with bitio functions.
int bytesWritten(void) {
    return bytesOutput;
}

/*
 * Return one bit back to the input stream.
 * Only guaranteed to be able to backup by 1 bit.
 */
void ungetBit(int bit) {
    inputBitMask <<= 1;
    
    if (inputBitMask == 0)
        inputBitMask = 1;
    
    // Only keep bits still to to be read
    inputBuffer = inputBuffer & (inputBitMask - 1);
    if (bit)
        inputBuffer |= inputBitMask;      // Replace bit
}

