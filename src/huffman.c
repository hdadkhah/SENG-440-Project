/****************************************************************************/
/*                A simple implementation of the Huffman coding             */
/*                author: hamid@dadkhah.ca									*/
/*  			  Hamidreza Eftekharadkhah - V00661878                      */
/*  			  Rhett Dobson - V00214277			                        */
/*                                                                          */
/****************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>


char *compress(char *fileName)
{
    char *ALPHA[26] = { "1010", "011110", "10111", "1110", "010", "011111", "11010",
    				    "00010", "0110", "111110000", "111111", "10110","11011", "0000", 
    				    "11110", "0111001", "11111000101", "1001", "1000", "1100", "00011",
    				    "1111101", "011101", "11111000100", "1111100011", "0111000" };
	char symbol_to_encode;
	FILE *file = fopen(fileName, "r");
	FILE *pFile = fopen ("compressed.txt" , "w");
	char buffer[10];
    int ch;

    if (file == NULL)
    {
    	printf("Cannot open %s\n", fileName);
        return NULL;
    }
	
	while (1) 
	{
		ch = fgetc(file);
		ch = tolower(ch);
		if (ch == EOF)
			break;
		else
		{
			 if (ch == 32)
			 {
			 	//printf( "%s", "001");
			 }
			 else if (ch == 225)
			 {
			 	//printf( "%s", "11111001");
			 }
			 else
			 {	
			 	if ((ch > 96) & (ch < 123))	 
			 		//printf( "%s", ALPHA[(int)ch-97]);
					strcpy(buffer,ALPHA[(int)ch-97]);
					fwrite (buffer,1,strlen(buffer),pFile);
			 }
			 
			 //printf( "%c", (char)ch);
		}
		
	}
    fclose(file);
    fclose (pFile);
    
}


int main()
{
	compress("README");
	return 0;
}