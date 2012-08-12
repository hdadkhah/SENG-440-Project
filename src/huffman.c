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


char *compress(char *infile, char *outfile)
{
    char *ALPHA[26] = { "1010", "011110", "10111", "1110", "010", "011111", "11010",
    				    "00010", "0110", "111110000", "111111", "10110","11011", "0000", 
    				    "11110", "0111001", "11111000101", "1001", "1000", "1100", "00011",
    				    "1111101", "011101", "11111000100", "1111100011", "0111000" };
	char symbol_to_encode;
	FILE *in = fopen(infile, "r");
	FILE *out = fopen (outfile , "w");
	char buffer[11];
    int ch;

    if (in == NULL)
    {
    	printf("Cannot open %s\n", infile);
        return NULL;
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
    fclose(in);
    fclose (out);
    
}


char* substring(const char* str, size_t begin, size_t len) 
{ 
  if (str == 0 || strlen(str) == 0 || strlen(str) < begin || strlen(str) < (begin+len)) 
    return 0; 

  return strndup(str + begin, len); 
} 


char *decompress (char *infile, char *outfile)
{
    char *ALPHA[26] = { "1010", "011110", "10111", "1110", "010", "011111", "11010",
    				    "00010", "0110", "111110000", "111111", "10110","11011", "0000", 
    				    "11110", "0111001", "11111000101", "1001", "1000", "1100", "00011",
    				    "1111101", "011101", "11111000100", "1111100011", "0111000" };
   	char *ALPHA_REVERSE[26] = { "a" , "b", "c", "d", "e", "f", "g",
    				    "h", "i", "j", "k","l", "m","n" 
    				    "o", "p", "q", "r", "s", "t", "u"
    				    "v", "w", "x", "y", "z" };
	char symbol_to_encode;
	FILE *in = fopen(infile, "r");
	//FILE *out = fopen (outfile , "w");
	int currentbuffersize;
    int ch;
    int i;
    int j;

    if (in == NULL)
    {
    	printf("Cannot open %s\n", infile);
        return NULL;
    }
		
	//set the pointer to the begining of file	
	//fseek ( out , 0 , SEEK_SET );
	
	i = 1;
	j = 0;
	char buffer[11];
	
	while ((ch = fgetc(in)) != EOF) 
	{
       	if (i == 4)
       	{
   			if (strncmp(buffer, "001", 3) == 0)
   			{
   				printf("%s", " ");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[4], 3) == 0)
   			{
   				printf("%s", "e");
   				i = 1;
   			}
   			
       	}
       	if (i == 5)
       	{
   			if (strncmp(buffer, ALPHA[13], 4) == 0)
   			{
   				printf("%s", "n");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[8], 4) == 0)
   			{
   				printf("%s", "i");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[18], 4) == 0)
   			{
   				printf("%s", "s");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[17], 4) == 0)
   			{
   				printf("%s", "r");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[0], 4) == 0)
   			{
   				printf("%s", "a");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[19], 4) == 0)
   			{
   				printf("%s", "t");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[3], 4) == 0)
   			{
   				printf("%s", "d");
   				i = 1;
   			}
       	}
       	if (i == 6)
       	{
   			if (strncmp(buffer, ALPHA[7], 5) == 0)
   			{
   				printf("%s", "h");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[20], 5) == 0)
   			{
   				printf("%s", "u");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[11], 5) == 0)
   			{
   				printf("%s", "l");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[2], 5) == 0)
   			{
   				printf("%s", "c");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[6], 5) == 0)
   			{
   				printf("%s", "g");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[12], 5) == 0)
   			{
   				printf("%s", "m");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[14], 5) == 0)
   			{
   				printf("%s", "o");
   				i = 1;
   			}
       	}
       	if (i == 7)
       	{
   			if (strncmp(buffer, ALPHA[22], 6) == 0)
   			{
   				printf("%s", "w");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[1], 6) == 0)
   			{
   				printf("%s", "b");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[5], 6) == 0)
   			{
   				printf("%s", "f");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[10], 6) == 0)
   			{
   				printf("%s", "k");
   				i = 1;
   			}
       	}
        if (i == 8)
       	{
   			if (strncmp(buffer, ALPHA[25], 7) == 0)
   			{
   				printf("%s", "z");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[15], 7) == 0)
   			{
   				printf("%s", "p");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[21], 7) == 0)
   			{
   				printf("%s", "v");
   				i = 1;
   			}
       	}
       	if (i == 1)
       	{
       		if (strncmp(buffer, "11111001", 8) == 0)
   			{
   				printf("%c", 225);
   				i = 1;
   			}
       	}
       	if (i == 10)
       	{
       		if (strncmp(buffer, ALPHA[9] , 9) == 0)
   			{
   				printf("%s", "j");
   				i = 1;
   			}
       	}
       	if (i == 11)
       	{
       		if (strncmp(buffer, ALPHA[22] , 10) == 0)
   			{
   				printf("%s", "y");
   				i = 1;
   			}
       	}
        else if(i == 12)
        {
        	if (strncmp(buffer, ALPHA[21] , 11) == 0)
   			{
   				printf("%s", "x");
   				i = 1;
   			}
   			if (strncmp(buffer, ALPHA[16] , 11) == 0)
   			{
   				printf("%s", "q");
   				i = 1;
   			}
        	//printf("%s", buffer);
        }
        
		buffer[i-1] = ch;
		i++;

    }
    fclose(in);
    //fclose (out);
    
}


int main()
{
	//compress("README", "compression.out");
	decompress("compression.out", "original.out");
	return 0;
}