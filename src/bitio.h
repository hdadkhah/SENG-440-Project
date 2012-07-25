// bitio.h

#ifndef BITIO_H
#define BITIO_H

#include <stdio.h>

#define		BYTE_SIZE		8

extern void OUTPUT_BIT(int b);
extern int INPUT_BIT(void);
extern int INPUT_BYTE(void);

void startOutputtingBits(FILE*);
void startInputtingBits(FILE*);
void doneOutputtingBits(void);
void doneInputtingBits(void);
int bytesRead(void);
int bytesWritten(void);

void ungetBit(int bit);

#endif		/* ifndef bitio_h */
