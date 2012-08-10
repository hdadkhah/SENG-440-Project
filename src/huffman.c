/****************************************************************************/
/*                A simple implementation of the Huffman coding             */
/*                author: hamid@dadkhah.ca									*/
/*  			  Hamidreza Eftekharadkhah - V00661878                      */
/*                                                                          */
/****************************************************************************/
#include <stdio.h>
#include <stdlib.h>


char *compress(char *fileName)
{
    FILE *file = fopen(fileName, "r");
    char *code;
    size_t n = 0;
    int c;

    if (file == NULL)
        return NULL; //could not open file

    code = malloc(1000);

    while ((c = fgetc(file)) != EOF)
    {
        code[n++] = (char) c;
    }

    // don't forget to terminate with the null character
    code[n] = '\0';        

    return code;
}

int main()
{
	printf ("%s\n", compress("README"));
	return 0;
}