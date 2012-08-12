
unsigned int germanLUT (char symbol) {
	if (symbol == ' ') return 112; 	//001
	if (symbol == 'e') return 121; 	//010
	if (symbol == 'n') return 1111; 	//0000
	if (symbol == 'i') return 1221; 	//0110
	if (symbol == 's') return 2111; 	//1000
	if (symbol == 'r') return 2112; 	//1001
	if (symbol == 'a') return 2121; 	//1010
	if (symbol == 't') return 2211; 	//1100
	if (symbol == 'd') return 2221;	//1110
	if (symbol == 'h') return 1121; 	//00010
	if (symbol == 'u') return 11122; 	//00011
	if (symbol == 'l') return 21221; 	//10110
	if (symbol == 'c') return 21222; 	//10111
	if (symbol == 'g') return 22121; 	//11010
	if (symbol == 'm') return 22122; 	//11011
	if (symbol == 'o') return 22221; 	//11110
	if (symbol == 'w') return 122212; 	//011101
	if (symbol == 'b') return 122221;	//011110
	if (symbol == 'f') return 122222; 	//011111
	if (symbol == 'k') return 222222;      //111111
	if (symbol == 'z') return 1222111;     //0111000
	if (symbol == 'p') return 1222112;     //0111001
	//use a second lookup table for codes starting with 11111?
	if (symbol == 'v') return 2222212;     //1111101
	if (symbol == 225) return 22222112;    //11111001
	if (symbol == 'j') return 222221111;   //111110000
	if (symbol == 'y') return 2222211122;  //1111100011
	if (symbol == 'x') return 22222111211; //11111000100
	if (symbol == 'q') return 22222111212; //11111000101	
}
