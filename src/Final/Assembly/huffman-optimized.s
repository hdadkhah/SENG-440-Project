	.arch armv5
	.eabi_attribute 27, 3
	.fpu vfpv3-d16
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 0
	.eabi_attribute 18, 4
	.file	"huffman.c"
	.section	.rodata
	.align	2
.LC28:
	.ascii	"r\000"
	.align	2
.LC29:
	.ascii	"w\000"
	.align	2
.LC30:
	.ascii	"Cannot open %s\012\000"
	.align	2
.LC31:
	.ascii	"001\000"
	.align	2
.LC32:
	.ascii	"11111001\000"
	.align	2
.LC33:
	.ascii	"Compression is done!\000"
	.align	2
.LC0:
	.ascii	"1010\000"
	.align	2
.LC1:
	.ascii	"011110\000"
	.align	2
.LC2:
	.ascii	"10111\000"
	.align	2
.LC3:
	.ascii	"1110\000"
	.align	2
.LC4:
	.ascii	"010\000"
	.align	2
.LC5:
	.ascii	"011111\000"
	.align	2
.LC6:
	.ascii	"11010\000"
	.align	2
.LC7:
	.ascii	"00010\000"
	.align	2
.LC8:
	.ascii	"0110\000"
	.align	2
.LC9:
	.ascii	"111110000\000"
	.align	2
.LC10:
	.ascii	"111111\000"
	.align	2
.LC11:
	.ascii	"10110\000"
	.align	2
.LC12:
	.ascii	"11011\000"
	.align	2
.LC13:
	.ascii	"0000\000"
	.align	2
.LC14:
	.ascii	"11110\000"
	.align	2
.LC15:
	.ascii	"0111001\000"
	.align	2
.LC16:
	.ascii	"11111000101\000"
	.align	2
.LC17:
	.ascii	"1001\000"
	.align	2
.LC18:
	.ascii	"1000\000"
	.align	2
.LC19:
	.ascii	"1100\000"
	.align	2
.LC20:
	.ascii	"00011\000"
	.align	2
.LC21:
	.ascii	"1111101\000"
	.align	2
.LC22:
	.ascii	"011101\000"
	.align	2
.LC23:
	.ascii	"11111000100\000"
	.align	2
.LC24:
	.ascii	"1111100011\000"
	.align	2
.LC25:
	.ascii	"0111000\000"
	.align	2
.LC26:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.word	.LC13
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.text
	.align	2
	.global	compress
	.type	compress, %function
compress:
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {r4, fp, lr}
	add	fp, sp, #8
	sub	sp, sp, #148
	str	r0, [fp, #-152]
	str	r1, [fp, #-156]
	ldr	r3, .L13
	ldr	r3, [r3, #0]
	str	r3, [fp, #-16]
	ldr	r3, .L13+4
	sub	r1, fp, #144
	mov	r2, r3
	mov	r3, #104
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	ldr	r2, [fp, #-152]
	ldr	r3, .L13+8
	mov	r0, r2
	mov	r1, r3
	bl	fopen
	str	r0, [fp, #-40]
	ldr	r2, [fp, #-156]
	ldr	r3, .L13+12
	mov	r0, r2
	mov	r1, r3
	bl	fopen
	str	r0, [fp, #-36]
	ldr	r3, [fp, #-40]
	cmp	r3, #0
	bne	.L2
	ldr	r3, .L13+16
	mov	r0, r3
	ldr	r1, [fp, #-152]
	bl	printf
	bl	abort
.L2:
	ldr	r0, [fp, #-36]
	mov	r1, #0
	mov	r2, #0
	bl	fseek
	b	.L8
.L12:
	mov	r0, r0	@ nop
.L8:
	ldr	r0, [fp, #-40]
	bl	fgetc
	mov	r3, r0
	strh	r3, [fp, #-30]	@ movhi
	ldrsh	r3, [fp, #-30]
	mov	r0, r3
	bl	tolower
	mov	r3, r0
	strh	r3, [fp, #-30]	@ movhi
	ldrsh	r3, [fp, #-30]
	cmn	r3, #1
	beq	.L11
.L3:
	ldrsh	r3, [fp, #-30]
	cmp	r3, #32
	bne	.L5
	ldr	r3, .L13+20
	mov	r0, r3
	mov	r1, #1
	mov	r2, #3
	ldr	r3, [fp, #-36]
	bl	fwrite
	b	.L12
.L5:
	ldrsh	r3, [fp, #-30]
	cmp	r3, #225
	bne	.L7
	ldr	r3, .L13+24
	mov	r0, r3
	mov	r1, #1
	mov	r2, #8
	ldr	r3, [fp, #-36]
	bl	fwrite
	b	.L12
.L7:
	ldrsh	r3, [fp, #-30]
	cmp	r3, #96
	movle	r3, #0
	movgt	r3, #1
	and	r2, r3, #255
	ldrsh	r3, [fp, #-30]
	cmp	r3, #122
	movgt	r3, #0
	movle	r3, #1
	and	r3, r3, #255
	and	r3, r2, r3
	and	r3, r3, #255
	cmp	r3, #0
	beq	.L12
	ldrsh	r3, [fp, #-30]
	sub	r2, r3, #97
	mvn	r3, #131
	mov	r2, r2, asl #2
	sub	r1, fp, #12
	add	r2, r1, r2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mov	r4, r3
	ldrsh	r3, [fp, #-30]
	sub	r2, r3, #97
	mvn	r3, #131
	mov	r2, r2, asl #2
	sub	r1, fp, #12
	add	r2, r1, r2
	add	r3, r2, r3
	ldr	r3, [r3, #0]
	mov	r0, r3
	bl	strlen
	mov	r3, r0
	mov	r0, r4
	mov	r1, #1
	mov	r2, r3
	ldr	r3, [fp, #-36]
	bl	fwrite
	b	.L12
.L11:
	mov	r0, r0	@ nop
.L10:
	ldr	r0, .L13+28
	bl	puts
	ldr	r0, [fp, #-40]
	bl	fclose
	ldr	r0, [fp, #-36]
	bl	fclose
	ldr	r3, .L13
	ldr	r2, [fp, #-16]
	ldr	r3, [r3, #0]
	cmp	r2, r3
	beq	.L9
	bl	__stack_chk_fail
.L9:
	sub	sp, fp, #8
	ldmfd	sp!, {r4, fp, pc}
.L14:
	.align	2
.L13:
	.word	__stack_chk_guard
	.word	.LC26
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.size	compress, .-compress
	.section	.rodata
	.align	2
.LC34:
	.ascii	"Decompression is done!\000"
	.align	2
.LC27:
	.byte	97
	.byte	98
	.byte	99
	.byte	100
	.byte	101
	.byte	102
	.byte	103
	.byte	104
	.byte	105
	.byte	106
	.byte	107
	.byte	108
	.byte	109
	.byte	110
	.byte	111
	.byte	112
	.byte	113
	.byte	114
	.byte	115
	.byte	116
	.byte	117
	.byte	118
	.byte	119
	.byte	120
	.byte	121
	.byte	122
	.text
	.align	2
	.global	decompress
	.type	decompress, %function
decompress:
	@ args = 0, pretend = 0, frame = 176
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #176
	str	r0, [fp, #-176]
	str	r1, [fp, #-180]
	ldr	r3, .L68
	ldr	r3, [r3, #0]
	str	r3, [fp, #-8]
	ldr	r3, .L68+4
	sub	r1, fp, #168
	mov	r2, r3
	mov	r3, #104
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	ldr	r3, .L68+8
	sub	r1, fp, #48
	mov	r2, r3
	mov	r3, #26
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	memcpy
	ldr	r2, [fp, #-176]
	ldr	r3, .L68+12
	mov	r0, r2
	mov	r1, r3
	bl	fopen
	str	r0, [fp, #-64]
	ldr	r2, [fp, #-180]
	ldr	r3, .L68+16
	mov	r0, r2
	mov	r1, r3
	bl	fopen
	str	r0, [fp, #-60]
	ldr	r3, [fp, #-64]
	cmp	r3, #0
	bne	.L16
	ldr	r3, .L68+20
	mov	r0, r3
	ldr	r1, [fp, #-176]
	bl	printf
	bl	abort
.L16:
	ldr	r0, [fp, #-60]
	mov	r1, #0
	mov	r2, #0
	bl	fseek
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	mov	r3, #0
	strh	r3, [fp, #-52]	@ movhi
	b	.L17
.L57:
	ldrsh	r3, [fp, #-54]
	sub	r3, r3, #4
	cmp	r3, #8
	ldrls	pc, [pc, r3, asl #2]
	b	.L18
.L28:
	.word	.L19
	.word	.L20
	.word	.L21
	.word	.L22
	.word	.L23
	.word	.L24
	.word	.L25
	.word	.L26
	.word	.L27
.L19:
	sub	r3, fp, #20
	mov	r0, r3
	ldr	r1, .L68+24
	mov	r2, #3
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L29
	mov	r0, #32
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L29:
	ldr	r3, [fp, #-152]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #3
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L59
	ldrb	r3, [fp, #-44]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L20:
	ldr	r3, [fp, #-116]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L31
	ldrb	r3, [fp, #-35]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L31:
	ldr	r3, [fp, #-136]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L32
	ldrb	r3, [fp, #-40]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L32:
	ldr	r3, [fp, #-96]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L33
	ldrb	r3, [fp, #-30]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L33:
	ldr	r3, [fp, #-100]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L34
	ldrb	r3, [fp, #-31]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L34:
	ldr	r3, [fp, #-168]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L35
	ldrb	r3, [fp, #-48]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L35:
	ldr	r3, [fp, #-92]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L36
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L36:
	ldr	r3, [fp, #-156]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #4
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L60
	ldrb	r3, [fp, #-45]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L21:
	ldr	r3, [fp, #-140]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L38
	ldrb	r3, [fp, #-41]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L38:
	ldr	r3, [fp, #-88]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L39
	ldrb	r3, [fp, #-28]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L39:
	ldr	r3, [fp, #-124]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L40
	ldrb	r3, [fp, #-37]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L40:
	ldr	r3, [fp, #-160]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L41
	ldrb	r3, [fp, #-46]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L41:
	ldr	r3, [fp, #-144]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L42
	ldrb	r3, [fp, #-42]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L42:
	ldr	r3, [fp, #-120]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L43
	ldrb	r3, [fp, #-36]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L43:
	ldr	r3, [fp, #-112]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #5
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L61
	ldrb	r3, [fp, #-34]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L22:
	ldr	r3, [fp, #-80]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #6
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L45
	ldrb	r3, [fp, #-26]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L45:
	ldr	r3, [fp, #-164]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #6
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L46
	ldrb	r3, [fp, #-47]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L46:
	ldr	r3, [fp, #-148]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #6
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L47
	ldrb	r3, [fp, #-43]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L47:
	ldr	r3, [fp, #-128]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #6
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L62
	ldrb	r3, [fp, #-38]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L23:
	ldr	r3, [fp, #-68]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #7
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L49
	ldrb	r3, [fp, #-23]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L49:
	ldr	r3, [fp, #-108]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #7
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L50
	ldrb	r3, [fp, #-33]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L50:
	ldr	r3, [fp, #-84]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #7
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L63
	ldrb	r3, [fp, #-27]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L24:
	sub	r3, fp, #20
	mov	r0, r3
	ldr	r1, .L68+28
	mov	r2, #8
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L64
	mov	r0, #225
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L25:
	ldr	r3, [fp, #-132]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #9
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L65
	ldrb	r3, [fp, #-39]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L26:
	ldr	r3, [fp, #-72]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #10
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L66
	ldrb	r3, [fp, #-24]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L27:
	ldr	r3, [fp, #-76]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #11
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L55
	ldrb	r3, [fp, #-25]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L55:
	ldr	r3, [fp, #-104]
	sub	r2, fp, #20
	mov	r0, r2
	mov	r1, r3
	mov	r2, #11
	bl	strncmp
	mov	r3, r0
	cmp	r3, #0
	bne	.L67
	ldrb	r3, [fp, #-32]	@ zero_extendqisi2
	mov	r0, r3
	ldr	r1, [fp, #-60]
	bl	fputc
	mov	r3, #1
	strh	r3, [fp, #-54]	@ movhi
	b	.L18
.L59:
	mov	r0, r0	@ nop
	b	.L18
.L60:
	mov	r0, r0	@ nop
	b	.L18
.L61:
	mov	r0, r0	@ nop
	b	.L18
.L62:
	mov	r0, r0	@ nop
	b	.L18
.L63:
	mov	r0, r0	@ nop
	b	.L18
.L64:
	mov	r0, r0	@ nop
	b	.L18
.L65:
	mov	r0, r0	@ nop
	b	.L18
.L66:
	mov	r0, r0	@ nop
	b	.L18
.L67:
	mov	r0, r0	@ nop
.L18:
	ldrsh	r3, [fp, #-54]
	sub	r1, r3, #1
	ldrh	r3, [fp, #-50]	@ movhi
	and	r2, r3, #255
	mvn	r3, #15
	sub	r0, fp, #4
	add	r1, r0, r1
	add	r3, r1, r3
	strb	r2, [r3, #0]
	ldrh	r3, [fp, #-54]	@ movhi
	add	r3, r3, #1
	strh	r3, [fp, #-54]	@ movhi
.L17:
	ldr	r0, [fp, #-64]
	bl	fgetc
	mov	r3, r0
	strh	r3, [fp, #-50]	@ movhi
	ldrsh	r3, [fp, #-50]
	cmn	r3, #1
	bne	.L57
	ldr	r0, .L68+32
	bl	puts
	ldr	r0, [fp, #-64]
	bl	fclose
	ldr	r0, [fp, #-60]
	bl	fclose
	ldr	r3, .L68
	ldr	r2, [fp, #-8]
	ldr	r3, [r3, #0]
	cmp	r2, r3
	beq	.L58
	bl	__stack_chk_fail
.L58:
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L69:
	.align	2
.L68:
	.word	__stack_chk_guard
	.word	.LC26
	.word	.LC27
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	.LC31
	.word	.LC32
	.word	.LC34
	.size	decompress, .-decompress
	.section	.rodata
	.align	2
.LC35:
	.ascii	"Unknown option `-%c'.\012\000"
	.align	2
.LC36:
	.ascii	"Unknown option character `\\x%x'.\012\000"
	.align	2
.LC37:
	.ascii	"cd\000"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	stmfd	sp!, {fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	str	r1, [fp, #-20]
	strh	r3, [fp, #-14]	@ movhi
	ldr	r3, .L81
	mov	r2, #0
	str	r2, [r3, #0]
	b	.L71
.L79:
	ldrsh	r3, [fp, #-6]
	cmp	r3, #99
	beq	.L74
	cmp	r3, #100
	beq	.L75
	cmp	r3, #63
	beq	.L73
	b	.L80
.L74:
	ldr	r3, [fp, #-20]
	add	r3, r3, #8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #12
	ldr	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	compress
	b	.L71
.L75:
	ldr	r3, [fp, #-20]
	add	r3, r3, #8
	ldr	r2, [r3, #0]
	ldr	r3, [fp, #-20]
	add	r3, r3, #12
	ldr	r3, [r3, #0]
	mov	r0, r2
	mov	r1, r3
	bl	decompress
	b	.L71
.L73:
	bl	__ctype_b_loc
	mov	r3, r0
	ldr	r2, [r3, #0]
	ldr	r3, .L81+4
	ldr	r3, [r3, #0]
	mov	r3, r3, asl #1
	add	r3, r2, r3
	ldrh	r3, [r3, #0]
	and	r3, r3, #16384
	cmp	r3, #0
	beq	.L76
	ldr	r3, .L81+8
	ldr	r3, [r3, #0]
	mov	r1, r3
	ldr	r2, .L81+12
	ldr	r3, .L81+4
	ldr	r3, [r3, #0]
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	fprintf
	b	.L77
.L76:
	ldr	r3, .L81+8
	ldr	r3, [r3, #0]
	mov	r1, r3
	ldr	r2, .L81+16
	ldr	r3, .L81+4
	ldr	r3, [r3, #0]
	mov	r0, r1
	mov	r1, r2
	mov	r2, r3
	bl	fprintf
.L77:
	mov	r3, #1
	b	.L78
.L80:
	bl	abort
.L71:
	ldrsh	r3, [fp, #-14]
	mov	r0, r3
	ldr	r1, [fp, #-20]
	ldr	r2, .L81+20
	bl	getopt
	mov	r3, r0
	strh	r3, [fp, #-6]	@ movhi
	ldrsh	r3, [fp, #-6]
	cmn	r3, #1
	bne	.L79
	mov	r3, #1
.L78:
	mov	r3, r3, asl #16
	mov	r3, r3, asr #16
	mov	r0, r3
	sub	sp, fp, #4
	ldmfd	sp!, {fp, pc}
.L82:
	.align	2
.L81:
	.word	opterr
	.word	optopt
	.word	stderr
	.word	.LC35
	.word	.LC36
	.word	.LC37
	.size	main, .-main
	.ident	"GCC: (Ubuntu/Linaro 4.6.3-1ubuntu5) 4.6.3"
	.section	.note.GNU-stack,"",%progbits
