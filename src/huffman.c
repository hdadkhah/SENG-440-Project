/****************************************************************************/
/*                A simple implementation of the Huffman coding             */
/*                author: danielscocco@gmail.com                            */
/*                                                                          */
/****************************************************************************/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#define len(x) ((int)log10(x)+1)

/* Node of the huffman tree */
struct node{
    int value;
    char letter;
    struct node *left,*right;
};

typedef struct node Node;

/* 651 = 6.51%, 1740 = 17.40% and so on. The 27th frequency is the beta (ASCII character code 225) 28th frequency is the space. Source is Wikipedia */
int germanLetterFrequencies [28] = {651, 189, 306, 508, 1740, 166, 301, 476, 755, 27, 121, 344, 253, 978, 251, 79, 2, 700, 727, 615, 435, 067, 189, 3, 4, 113, 31, 180};

/*finds and returns the small sub-tree in the forrest*/
int findSmaller (Node *array[], int differentFrom){
    int smaller;
    int i = 0;
	
    while (array[i]->value==-1)
        i++;
    smaller=i;
    if (i==differentFrom){
        i++;
        while (array[i]->value==-1)
            i++;
        smaller=i;
    }
	
    for (i=1;i<28;i++){
        if (array[i]->value==-1)
            continue;
        if (i==differentFrom)
            continue;
        if (array[i]->value<array[smaller]->value)
            smaller = i;
    }
	
    return smaller;
}

/*builds the huffman tree and returns its address by reference*/
void buildHuffmanTree(Node **tree){
    Node *temp;
    Node *array[28];
    int i, subTrees = 28;
    int smallOne,smallTwo;
	
    for (i=0;i<27;i++){
        array[i] = malloc(sizeof(Node));
        array[i]->value = englishLetterFrequencies[i];
        array[i]->letter = i;
        array[i]->left = NULL;
        array[i]->right = NULL;
    }
	
    while (subTrees>1){
        smallOne=findSmaller(array,-1);
        smallTwo=findSmaller(array,smallOne);
        temp = array[smallOne];
        array[smallOne] = malloc(sizeof(Node));
        array[smallOne]->value=temp->value+array[smallTwo]->value;
        array[smallOne]->letter=127;
        array[smallOne]->left=array[smallTwo];
        array[smallOne]->right=temp;
        array[smallTwo]->value=-1;
        subTrees--;
    }
	
    *tree = array[smallOne];
	
	return;
}


//Print the table with 90 degree rotation
void padding ( char ch, int n )
{
	int i;
	for ( i = 0; i < n; i++ )
		putchar ( ch );
}
void structure ( struct node *root, int level )
{
	int i;
	if ( root == NULL ) {
		padding ( '\t', level );
		puts ( "~" );
	}
	else {
		structure ( root->right, level + 1 );
		padding ( '\t', level );
		printf ( "%d\n", root->value);
		structure ( root->left, level + 1 );
	}
}


/* builds the table with the bits for each letter. 1 stands for binary 0 and 2 for binary 1 (used to facilitate arithmetic)*/
void fillTable(int codeTable[], Node *tree, int Code){
    if (tree->letter<28)
        codeTable[(int)tree->letter] = Code;
    else{
        fillTable(codeTable, tree->left, Code*10+1);
        fillTable(codeTable, tree->right, Code*10+2);
    }
	
    return;
}

/*function to compress the input*/
void compressFile(FILE *input, FILE *output, int codeTable[]){
    char bit, c, x = 0;
    int n,length,bitsLeft = 8;
    int originalBits = 0, compressedBits = 0;
	
    while ((c=fgetc(input))!=10){
        originalBits++;
        if (c==32){
            length = len(codeTable[26]);
            n = codeTable[26];
        }
        else{
            length=len(codeTable[c-97]);
            n = codeTable[c-97];
        }
		
        while (length>0){
            compressedBits++;
            bit = n % 10 - 1;
            n /= 10;
            x = x | bit;
            bitsLeft--;
            length--;
            if (bitsLeft==0){
                fputc(x,output);
                x = 0;
                bitsLeft = 8;
            }
            x = x << 1;
        }
    }
	
    if (bitsLeft!=8){
        x = x << (bitsLeft-1);
        fputc(x,output);
    }
	
    /*print details of compression on the screen*/
    fprintf(stderr,"Original bits = %d\n",originalBits*8);
    fprintf(stderr,"Compressed bits = %d\n",compressedBits);
    fprintf(stderr,"Saved %.2f%% of memory\n",((float)compressedBits/(originalBits*8))*100);
	
    return;
}

/*function to decompress the input*/
void decompressFile (FILE *input, FILE *output, Node *tree){
    Node *current = tree;
    char c,bit;
    char mask = 1 << 7;
    int i;
	
    while ((c=fgetc(input))!=EOF){
		
        for (i=0;i<8;i++){
            bit = c & mask;
            c = c << 1;
            if (bit==0){
                current = current->left;
                if (current->letter!=127){
                    if (current->letter==26)
                        fputc(32, output);
                    else
                        fputc(current->letter+97,output);
                    current = tree;
                }
            }
			
            else{
                current = current->right;
                if (current->letter!=127){
                    if (current->letter==26)
                        fputc(32, output);
                    else
                        fputc(current->letter+97,output);
                    current = tree;
                }
            }
        }
    }
	
    return;
}

/*invert the codes in codeTable2 so they can be used with mod operator by compressFile function*/
void invertCodes(int codeTable[],int codeTable2[]){
    int i, n, copy;
	
    for (i=0;i<29;i++){
        n = codeTable[i];
        copy = 0;
        while (n>0){
            copy = copy * 10 + n %10;
            n /= 10;
        }
        codeTable2[i]=copy;
    }
	
	return;
}

int main(){
    Node *tree;
    int codeTable[28], codeTable2[28];
    int compress;
    char filename[20];
    FILE *input, *output;
	
    buildHuffmanTree(&tree);
	
	//print the tree
	structure ( tree, 0 );
	
	return 1;
	
    fillTable(codeTable, tree, 0);
	
    invertCodes(codeTable,codeTable2);
	
    /*get input details from user*/
    printf("Type the name of the file to process:\n");
    scanf("%s",filename);
    printf("Type 1 to compress and 2 to decompress:\n");
    scanf("%d",&compress);
	
    input = fopen(filename, "r");
    output = fopen("output.txt","w");
	
    if (compress==1)
        compressFile(input,output,codeTable2);
    else
        decompressFile(input,output, tree);
	
    return 0;
}
