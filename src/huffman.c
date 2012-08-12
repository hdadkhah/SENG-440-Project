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
#include <unistd.h>


char *ALPHA[26] = { "1010", "011110", "10111", "1110", "010", "011111", "11010",
				    "00010", "0110", "111110000", "111111", "10110","11011", "0000", 
				    "11110", "0111001", "11111000101", "1001", "1000", "1100", "00011",
				    "1111101", "011101", "11111000100", "1111100011", "0111000" };
char ALPHA_REVERSE[26] = { 'a' , 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 
   						   'n', 'o', 'p' , 'q', 'r' , 's', 't', 'u', 'v', 'w', 'x', 'y', 'z' };

void compress(char *infile, char *outfile)
{
	char symbol_to_encode;
	FILE *in = fopen(infile, "r");
	FILE *out = fopen (outfile , "w");
	char buffer[11];
    int ch;

    if (in == NULL)
    {
    	printf("Cannot open %s\n", infile);
    	abort();
    }
		
	//set the pointer to the begining of file	
	fseek ( out , 0 , SEEK_SET );
	while (1) 
	{
		ch = fgetc(in);
		ch = tolower(ch);
		if (ch == EOF)
			break;
		else
		{
			 /* since the space and the character § are out of range of our alphabet and we use integer arithmetic to figu
			 	re out the huffman value, we put sepeate if statement for them*/
			 if (ch == 32)
			 {
			 	strcpy(buffer, "001");
			 }
			 else if (ch == 225)
			 {
			 	strcpy(buffer,"11111001");
			 }
			 else
			 {	
			 	/* we dont care for characters out of range for our purpose, such as . or ', we just consider 25 letters of 
			 	alphabet and space and §*/
			 	if ((ch > 96) & (ch < 123))
			 	{	 
					strcpy(buffer,ALPHA[(int)ch-97]);
				}
				else
				{
					strcpy(buffer,"");
				}
			 }
			 //Now write the string buffer to the file
			 fwrite (buffer,1,strlen(buffer),out);
		}
	}
	printf("Compression is done!\n");
    fclose(in);
    fclose (out);
    
}

void decompress (char *infile, char *outfile)
{
	char symbol_to_encode;
	FILE *in = fopen(infile, "r");
	FILE *out = fopen (outfile , "w");
	int currentbuffersize;
    int ch;
    int i;
    int j;

    if (in == NULL)
    {
    	printf("Cannot open %s\n", infile);
        abort();
    }
		
	//set the pointer to the begining of file	
	fseek ( out , 0 , SEEK_SET );
	
	i = 1;
	j = 0;
	char buffer[11];
	
	while ((ch = fgetc(in)) != EOF) 
	{
       	if (i == 4)
       	{
   			if (strncmp(buffer, "001", 3) == 0)
   			{
   				fputc(32, out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[4], 3) == 0)
   			{
   				fputc(ALPHA_REVERSE[4], out);
   				i = 1;
   			}
   			
       	}
       	if (i == 5)
       	{
   			if (strncmp(buffer, ALPHA[13], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[13], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[8], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[8], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[18], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[18], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[17], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[17], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[0], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[0], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[19], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[19], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[3], 4) == 0)
   			{
   				fputc(ALPHA_REVERSE[3], out);
   				i = 1;
   			}
       	}
       	if (i == 6)
       	{
   			if (strncmp(buffer, ALPHA[7], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[7], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[20], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[20], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[11], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[11], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[2], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[2], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[6], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[6], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[12], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[12], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[14], 5) == 0)
   			{
   				fputc(ALPHA_REVERSE[14], out);
   				i = 1;
   			}
       	}
       	if (i == 7)
       	{
   			if (strncmp(buffer, ALPHA[22], 6) == 0)
   			{
   				fputc(ALPHA_REVERSE[22], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[1], 6) == 0)
   			{
   				fputc(ALPHA_REVERSE[1], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[5], 6) == 0)
   			{
   				fputc(ALPHA_REVERSE[5], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[10], 6) == 0)
   			{
   				fputc(ALPHA_REVERSE[10], out);
   				i = 1;
   			}
       	}
        if (i == 8)
       	{
   			if (strncmp(buffer, ALPHA[25], 7) == 0)
   			{
   				fputc(ALPHA_REVERSE[25], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[15], 7) == 0)
   			{
   				fputc(ALPHA_REVERSE[15], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[21], 7) == 0)
   			{
   				fputc(ALPHA_REVERSE[21], out);
   				i = 1;
   			}
       	}
       	if (i == 1)
       	{
       		if (strncmp(buffer, "11111001", 8) == 0)
   			{
   				fputc(225, out);
   				i = 1;
   			}
       	}
       	if (i == 10)
       	{
       		if (strncmp(buffer, ALPHA[9] , 9) == 0)
   			{
   				fputc(ALPHA_REVERSE[9], out);
   				i = 1;
   			}
       	}
       	if (i == 11)
       	{
       		if (strncmp(buffer, ALPHA[24] , 10) == 0)
   			{
   				fputc(ALPHA_REVERSE[24], out);
   				i = 1;
   			}
       	}
        else if(i == 12)
        {
        	if (strncmp(buffer, ALPHA[23] , 11) == 0)
   			{
   				fputc(ALPHA_REVERSE[23], out);
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[16] , 11) == 0)
   			{
   				fputc(ALPHA_REVERSE[16], out);
   				i = 1;
   			}
        }
        
		buffer[i-1] = ch;
		i++;

    }
    printf("Decompression is done!\n");
    fclose(in);
    fclose (out);
    
}


int main(int argc, char *argv[])
{
   int index;
   int c;
   opterr = 0;
   
   /* Clear The Screen */
   system ("clear");
   
   while ((c = getopt (argc, argv, "cd")) != -1)
     switch (c)
       {
       case 'c':
       	 compress(argv[2], argv[3]);
         break;
       case 'd':
         decompress(argv[2], argv[3]);
         break;
       case '?':
         if (isprint (optopt))
           fprintf (stderr, "Unknown option `-%c'.\n", optopt);
         else
           fprintf (stderr,"Unknown option character `\\x%x'.\n",optopt);
         return 1;
       default:
         abort();
       }
       	
   return 1;
}