	.file	"playerIN.c"
	
	.balign 2
	.global	p1_UP_DOWN
	.type	p1_UP_DOWN, @function
p1_UP_DOWN:
	SUB.W	#2, R1
	; end of prologue
	MOV.W	R12, @R1
	MOV.W	@R1, R12
	AND.B	#1, R12
	CMP.W	#0, R12 { JNE	.L30
	MOV.W	#-5, &ml0+4
	BR	#.L33
.L30:
	MOV.W	@R1, R12
	AND.B	#2, R12
	CMP.W	#0, R12 { JNE	.L32
	MOV.W	#5, &ml0+4
	BR	#.L33
.L32:
	MOV.W	#0, &ml0+4
.L33:
	NOP
	; start of epilogue
	ADD.W	#2, R1
	RET
	.size	p1_UP_DOWN, .-p1_UP_DOWN
	.balign 2
	.global	p2_UP_DOWN
	.type	p2_UP_DOWN, @function
p2_UP_DOWN:
	SUB.W	#2, R1
	; end of prologue
	MOV.W	R12, @R1
	MOV.W	@R1, R12
	AND.B	#4, R12
	CMP.W	#0, R12 { JNE	.L35
	MOV.W	#-5, &ml1+4
	BR	#.L38
.L35:
	MOV.W	@R1, R12
	AND.B	#8, R12
	CMP.W	#0, R12 { JNE	.L37
	MOV.W	#5, &ml1+4
	BR	#.L38
.L37:
	MOV.W	#0, &ml1+4
.L38:
	NOP
	; start of epilogue
	ADD.W	#2, R1
	RET
	.size	p2_UP_DOWN, .-p2_UP_DOWN

	.local	count.1826
	.comm	count.1826,2,2
	.ident	"GCC: (SOMNIUM Technologies Limited - msp430-gcc 6.2.1.16) 6.2.1 20161212"
