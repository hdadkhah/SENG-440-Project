// arith.h

#define Half ((unsigned) 1 << 31)
#define Quarter ((unsigned) 1 << 30)

extern void start_encode(void);
extern void finish_encode(void);
extern void encode( unsigned low, unsigned high, unsigned total );

extern void start_decode(void);
extern void finish_decode(void);
extern unsigned decode_target( unsigned total );
extern void decode( unsigned low, unsigned high, unsigned total );

