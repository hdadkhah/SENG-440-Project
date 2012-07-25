// main.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "bitio.h"
#include "arith.h"
#include "achuffman.h"

#define COMPRESSED_FILE_SUFFIX  ".ach"


static void usage() {
    fprintf(stderr, "Usage:\n");
    fprintf(stderr, "        ahc [-x] filename\n");
    fprintf(stderr, "    where filename has suffix '%s' if to be decompressed\n",
        COMPRESSED_FILE_SUFFIX);
    fprintf(stderr, "    if -x is provided, the input file is deleted");
    exit(1);
}


int main(int argc, char *argv[]) {      
    int i;                       // loop counter
    char *filename = NULL;
    char *s, *suffix, *newfilename;
    int compressing;     // 0 => decompressing, non-zero => compressing
    int removeFlag = 0;  // delete input file afterwards?
    int compressedSize, uncompressedSize;
    FILE *inputFile;
    FILE *outputFile;

    for(i = 1; i < argc; i++ ) {
        s = argv[i];
        if (s[0] == '-') {
            if (s[1] == 'x')
                removeFlag = 1;
            else
                usage();  // unknown flag
        } else { 
            if (filename != NULL) {
                fprintf(stderr,"Only one filename can be specified\n");
                exit(1);
            }
            filename = s;
        }
    }
    
    if (filename == NULL) usage();

    suffix = NULL;
    for( s = filename;  *s != '\0';  s++ ) {
        if (*s == '.') suffix = s;
    }

    compressing = suffix == NULL || strcmp(suffix, COMPRESSED_FILE_SUFFIX) != 0;
    
    // construct the output filename
    if (compressing) {
        newfilename = malloc(strlen(filename)+strlen(COMPRESSED_FILE_SUFFIX)+1);
        strcpy(newfilename, filename);
        strcat(newfilename, COMPRESSED_FILE_SUFFIX);
    } else {
        i = suffix - filename;
        newfilename = malloc(i + 5);
        strncpy(newfilename, "new-", 4);
        strncat(newfilename, filename, i);
    }

    // Open the input and output files -- raw bytes (binary) I/O for both
    inputFile = fopen(filename, "rb");
    if (inputFile == NULL) {
        perror(filename);
        exit(1);
    }
    outputFile = fopen(newfilename, "wb");
    if (inputFile == NULL) {
        perror(filename);
        exit(1);
    }
    
    // Now perform the compression or decompression
    if (compressing) {
        fprintf(stdout,"Compressing %s ...", filename);
        startOutputtingBits(outputFile);  // prepare bitio module
        uncompressedSize = compress(inputFile);
        fclose(inputFile);
        doneOutputtingBits();
        compressedSize = bytesWritten();
        fprintf(stdout,"    file %s created\n", newfilename);
        fprintf(stdout,"    %d bytes read, %d bytes written\n",
            uncompressedSize, compressedSize);
            
    } else {
        fprintf(stdout,"Decompressing %s ...", filename);
        startInputtingBits(inputFile);  // prepare bitio module
        uncompressedSize = decompress(outputFile);
        fclose(outputFile);
        doneInputtingBits();
        compressedSize = bytesRead();
        fprintf(stdout,"    file %s created\n", newfilename);
        fprintf(stdout,"    %d bytes read, %d bytes written\n",
            compressedSize, uncompressedSize);
    }

    if (removeFlag) unlink(filename);  // remove the input file

    return 0;
}
