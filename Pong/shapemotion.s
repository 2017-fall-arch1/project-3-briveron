	.file	"shapemotion.c"
	.global	p2Score
.data
	.balign 2
	.type	p2Score, @object
	.size	p2Score, 2
p2Score:
	.zero	2
	.global	p1Score
	.balign 2
	.type	p1Score, @object
	.size	p1Score, 2
p1Score:
	.zero	2
	.comm	scoreBoard,3,1
	.global	rectFence
	.balign 2
	.type	rectFence, @object
	.size	rectFence, 8
rectFence:
	.short	abRectGetBounds
	.short	abRectCheck
	.short	1
	.short	70
	.global	leftPad
	.balign 2
	.type	leftPad, @object
	.size	leftPad, 8
leftPad:
	.short	abRectGetBounds
	.short	abRectCheck
	.short	2
	.short	20
	.global	rightPad
	.balign 2
	.type	rightPad, @object
	.size	rightPad, 8
rightPad:
	.short	abRectGetBounds
	.short	abRectCheck
	.short	2
	.short	20
	.global	fieldOutline
	.balign 2
	.type	fieldOutline, @object
	.size	fieldOutline, 8
fieldOutline:
	.short	abRectOutlineGetBounds
	.short	abRectOutlineCheck
	.short	63
	.short	70
	.global	Fence
	.balign 2
	.type	Fence, @object
	.size	Fence, 18
Fence:
	.short	rectFence
	.short	64
	.short	80
	.short	0
	.short	0
	.short	0
	.short	0
	.short	-1
	.short	0
	.global	layer3
	.balign 2
	.type	layer3, @object
	.size	layer3, 18
layer3:
	.short	circle4
	.short	74
	.short	85
	.short	0
	.short	0
	.short	0
	.short	0
	.short	-1
	.short	Fence
	.global	fieldLayer
	.balign 2
	.type	fieldLayer, @object
	.size	fieldLayer, 18
fieldLayer:
	.short	fieldOutline
	.short	64
	.short	80
	.short	0
	.short	0
	.short	0
	.short	0
	.short	-1
	.short	layer3
	.global	layer1
	.balign 2
	.type	layer1, @object
	.size	layer1, 18
layer1:
	.short	rightPad
	.short	124
	.short	80
	.short	0
	.short	0
	.short	0
	.short	0
	.short	31
	.short	fieldLayer
	.global	layer0
	.balign 2
	.type	layer0, @object
	.size	layer0, 18
layer0:
	.short	leftPad
	.short	4
	.short	80
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1343
	.short	layer1
	.global	ml3
	.balign 2
	.type	ml3, @object
	.size	ml3, 8
ml3:
	.short	layer3
	.short	4
	.short	4
	.short	0
	.global	ml1
	.balign 2
	.type	ml1, @object
	.size	ml1, 8
ml1:
	.short	layer1
	.short	0
	.short	0
	.short	ml3
	.global	ml0
	.balign 2
	.type	ml0, @object
	.size	ml0, 8
ml0:
	.short	layer0
	.short	0
	.short	0
	.short	ml1
.text
	.balign 2
	.global	movLayerDraw
	.type	movLayerDraw, @function
movLayerDraw:
; start of function
; framesize_regs:     0
; framesize_locals:   28
; framesize_outgoing: 0
; framesize:          28
; elim ap -> fp       2
; elim fp -> sp       28
; saved regs:(none)
	; start of prologue
	SUB.W	#28, R1
	; end of prologue
	MOV.W	R12, 2(R1)
	MOV.W	R13, @R1
	MOV.W	#-9, R12
	CALL	#and_sr
	MOV.W	2(R1), 22(R1)
	BR	#.L2
.L3:
	MOV.W	22(R1), R12
	MOV.W	@R12, 16(R1)
	MOV.W	16(R1), R12
	MOV.W	16(R1), R13
	MOV.W	2(R13), 6(R12)
	MOV.W	4(R13), 8(R12)
	MOV.W	16(R1), R12
	MOV.W	16(R1), R13
	MOV.W	10(R13), 2(R12)
	MOV.W	12(R13), 4(R12)
	MOV.W	22(R1), R12
	MOV.W	6(R12), 22(R1)
.L2:
	CMP.W	#0, 22(R1) { JNE	.L3
	MOV.B	#8, R12
	CALL	#or_sr
	MOV.W	2(R1), 22(R1)
	BR	#.L4
.L13:
	MOV.W	22(R1), R12
	MOV.W	@R12, R12
	MOV.W	R1, R13
	ADD.W	#8, R13
	CALL	#layerGetBounds
	MOV.W	8(R1), R12
	AND	#0xff, R12
	MOV.W	10(R1), R13
	AND	#0xff, R13
	MOV.W	12(R1), R14
	AND	#0xff, R14
	MOV.W	14(R1), R15
	AND	#0xff, R15
	CALL	#lcd_setArea
	MOV.W	10(R1), 26(R1)
	BR	#.L5
.L12:
	MOV.W	8(R1), 24(R1)
	BR	#.L6
.L11:
	MOV.W	24(R1), 4(R1)
	MOV.W	26(R1), 6(R1)
	MOV.W	&bgColor, 20(R1)
	MOV.W	@R1, 18(R1)
	BR	#.L7
.L10:
	MOV.W	18(R1), R12
	MOV.W	@R12, R12
	MOV.W	18(R1), R13
	ADD.W	#2, R13
	MOV.W	R1, R14
	ADD.W	#4, R14
	CALL	#abShapeCheck
	CMP.W	#0, R12 { JEQ	.L8
	MOV.W	18(R1), R12
	MOV.W	14(R12), 20(R1)
	BR	#.L9
.L8:
	MOV.W	18(R1), R12
	MOV.W	16(R12), 18(R1)
.L7:
	CMP.W	#0, 18(R1) { JNE	.L10
.L9:
	MOV.W	20(R1), R12
	CALL	#lcd_writeColor
	ADD.W	#1, 24(R1)
.L6:
	MOV.W	12(R1), R12
	CMP.W	24(R1), R12 { JGE	.L11
	ADD.W	#1, 26(R1)
.L5:
	MOV.W	14(R1), R12
	CMP.W	26(R1), R12 { JGE	.L12
	MOV.W	22(R1), R12
	MOV.W	6(R12), 22(R1)
.L4:
	CMP.W	#0, 22(R1) { JNE	.L13
	NOP
	; start of epilogue
	ADD.W	#28, R1
	RET
	.size	movLayerDraw, .-movLayerDraw
	.balign 2
	.global	mlAdvance
	.type	mlAdvance, @function
mlAdvance:
; start of function
; framesize_regs:     0
; framesize_locals:   68
; framesize_outgoing: 2
; framesize:          70
; elim ap -> fp       2
; elim fp -> sp       70
; saved regs:(none)
	; start of prologue
	SUB.W	#70, R1
	; end of prologue
	MOV.W	R12, 8(R1)
	MOV.W	R13, 6(R1)
	MOV.W	R14, 4(R1)
	MOV.W	R15, 2(R1)
	MOV.B	#124, &scoreBoard+1
	MOV.W	2(R1), R12
	MOV.W	@R12, R12
	ADD.W	#7, R12
	MOV.W	R12, 34(R1)
	MOV.W	2(R1), R12
	MOV.W	2(R12), R12
	MOV.W	R12, 36(R1)
	MOV.W	2(R1), R12
	MOV.W	4(R12), R12
	ADD.W	#-7, R12
	MOV.W	R12, 38(R1)
	MOV.W	2(R1), R12
	MOV.W	6(R12), R12
	MOV.W	R12, 40(R1)
	BR	#.L15
.L28:
	MOV.B	#0, R12
	CALL	#buzzer_set_period
	MOV.W	8(R1), R12
	MOV.W	@R12, R12
	MOV.W	R12, R13
	ADD.W	#10, R13
	MOV.W	8(R1), R14
	ADD.W	#2, R14
	MOV.W	R1, R12
	ADD.W	#50, R12
	CALL	#vec2Add
	MOV.W	8(R1), R12
	MOV.W	@R12, R12
	MOV.W	@R12, R12
	MOV.W	R1, R14
	ADD.W	#42, R14
	MOV.W	R1, R13
	ADD.W	#50, R13
	CALL	#abShapeGetBounds
	MOV.W	6(R1), R12
	MOV.W	@R12, R12
	MOV.W	R12, R13
	ADD.W	#10, R13
	MOV.W	6(R1), R14
	ADD.W	#2, R14
	MOV.W	R1, R12
	ADD.W	#30, R12
	CALL	#vec2Add
	MOV.W	6(R1), R12
	MOV.W	@R12, R12
	MOV.W	@R12, R12
	MOV.W	R1, R14
	ADD.W	#22, R14
	MOV.W	R1, R13
	ADD.W	#30, R13
	CALL	#abShapeGetBounds
	MOV.W	4(R1), R12
	MOV.W	@R12, R12
	MOV.W	R12, R13
	ADD.W	#10, R13
	MOV.W	4(R1), R14
	ADD.W	#2, R14
	MOV.W	R1, R12
	ADD.W	#18, R12
	CALL	#vec2Add
	MOV.W	4(R1), R12
	MOV.W	@R12, R12
	MOV.W	@R12, R12
	MOV.W	R1, R14
	ADD.W	#10, R14
	MOV.W	R1, R13
	ADD.W	#18, R13
	CALL	#abShapeGetBounds
	MOV.B	#0, 69(R1)
	BR	#.L16
.L25:
	MOV.B	69(R1), R12
	ADD.W	R12, R12
	MOV.B	#70, R13
	ADD.W	R1, R13
	ADD.W	R13, R12
	ADD.W	#-28, R12
	MOV.W	@R12, R13
	MOV.B	69(R1), R12
	ADD.W	R12, R12
	MOV.B	#70, R14
	ADD.W	R1, R14
	ADD.W	R14, R12
	ADD.W	#-36, R12
	MOV.W	@R12, R12
	CMP.W	R12, R13 { JL	.L17
	MOV.B	69(R1), R12
	ADD.W	#2, R12
	ADD.W	R12, R12
	MOV.B	#70, R13
	ADD.W	R1, R13
	ADD.W	R13, R12
	ADD.W	#-28, R12
	MOV.W	@R12, R13
	MOV.B	69(R1), R12
	ADD.W	#2, R12
	ADD.W	R12, R12
	MOV.B	#70, R14
	ADD.W	R1, R14
	ADD.W	R14, R12
	ADD.W	#-36, R12
	MOV.W	@R12, R12
	CMP.W	R13, R12 { JGE	.L18
.L17:
	MOV.W	44(R1), R13
	MOV.W	12(R1), R12
	CMP.W	R13, R12 { JGE	.L19
	MOV.W	48(R1), R13
	MOV.W	16(R1), R12
	CMP.W	R12, R13 { JGE	.L19
	MOV.W	42(R1), R13
	MOV.B	#64, R12
	CMP.W	R13, R12 { JGE	.L19
	MOV.W	8(R1), R12
	MOV.W	2(R12), R12
	MOV.W	#0, R13 { SUB.W	R12, R13
	MOV.W	8(R1), R12
	MOV.W	R13, 2(R12)
	MOV.W	8(R1), R12
	MOV.W	2(R12), 58(R1)
	MOV.W	#5000, R12
	CALL	#buzzer_set_period
	MOV.W	50(R1), R13
	MOV.W	58(R1), R12
	ADD.W	R12, R12
	ADD.W	R13, R12
	MOV.W	R12, 50(R1)
	BR	#.L20
.L19:
	MOV.W	44(R1), R13
	MOV.W	24(R1), R12
	CMP.W	R13, R12 { JGE	.L18
	MOV.W	48(R1), R13
	MOV.W	28(R1), R12
	CMP.W	R12, R13 { JGE	.L18
	MOV.W	42(R1), R13
	MOV.B	#63, R12
	CMP.W	R13, R12 { JL	.L18
	MOV.W	8(R1), R12
	MOV.W	2(R12), R12
	MOV.W	#0, R13 { SUB.W	R12, R13
	MOV.W	8(R1), R12
	MOV.W	R13, 2(R12)
	MOV.W	8(R1), R12
	MOV.W	2(R12), 60(R1)
	MOV.W	#4000, R12
	CALL	#buzzer_set_period
	MOV.W	50(R1), R13
	MOV.W	60(R1), R12
	ADD.W	R12, R12
	ADD.W	R13, R12
	MOV.W	R12, 50(R1)
	BR	#.L20
.L18:
	MOV.B	69(R1), R12
	ADD.W	R12, R12
	MOV.B	#70, R13
	ADD.W	R1, R13
	ADD.W	R13, R12
	ADD.W	#-28, R12
	MOV.W	@R12, R13
	MOV.B	69(R1), R12
	MOV.W	2(R1), R14
	ADD.W	R12, R12
	ADD.W	R14, R12
	MOV.W	@R12, R12
	CMP.W	R12, R13 { JL	.L21
	MOV.B	69(R1), R12
	ADD.W	#2, R12
	ADD.W	R12, R12
	MOV.B	#70, R14
	ADD.W	R1, R14
	ADD.W	R14, R12
	ADD.W	#-28, R12
	MOV.W	@R12, R13
	MOV.B	69(R1), R12
	MOV.W	2(R1), R14
	ADD.W	#2, R12
	ADD.W	R12, R12
	ADD.W	R14, R12
	MOV.W	@R12, R12
	CMP.W	R13, R12 { JGE	.L22
.L21:
	MOV.B	69(R1), R12
	MOV.B	69(R1), R13
	MOV.W	8(R1), R14
	ADD.W	#1, R13
	ADD.W	R13, R13
	ADD.W	R14, R13
	MOV.W	@R13, R13
	MOV.W	#0, R14 { SUB.W	R13, R14
	MOV.W	8(R1), R15
	MOV.W	R12, R13
	ADD.W	#1, R13
	ADD.W	R13, R13
	ADD.W	R15, R13
	MOV.W	R14, @R13
	MOV.W	8(R1), R13
	ADD.W	#1, R12
	ADD.W	R12, R12
	ADD.W	R13, R12
	MOV.W	@R12, 66(R1)
	MOV.W	#500, R12
	CALL	#buzzer_set_period
	MOV.B	69(R1), R12
	MOV.B	69(R1), R13
	ADD.W	R13, R13
	MOV.B	#70, R14
	ADD.W	R1, R14
	ADD.W	R14, R13
	ADD.W	#-20, R13
	MOV.W	@R13, R14
	MOV.W	66(R1), R13
	ADD.W	R13, R13
	ADD.W	R14, R13
	ADD.W	R12, R12
	MOV.B	#70, R14
	ADD.W	R1, R14
	ADD.W	R14, R12
	ADD.W	#-20, R12
	MOV.W	R13, @R12
.L22:
	MOV.W	42(R1), R13
	MOV.W	2(R1), R12
	MOV.W	@R12, R12
	CMP.W	R12, R13 { JGE	.L23
	MOV.W	#64, 50(R1)
	MOV.W	#80, 52(R1)
	MOV.W	8(R1), R12
	MOV.W	#2, 2(R12)
	MOV.W	8(R1), R12
	MOV.W	@R12, R12
	MOV.W	50(R1), 10(R12)
	MOV.W	52(R1), 12(R12)
	MOV.W	&p1Score, R12
	ADD.W	#1, R12
	MOV.W	R12, &p1Score
	MOV.W	#1, 62(R1)
	BR	#.L20
.L23:
	MOV.W	46(R1), R13
	MOV.W	2(R1), R12
	MOV.W	4(R12), R12
	CMP.W	R13, R12 { JGE	.L24
	MOV.W	#64, 50(R1)
	MOV.W	#80, 52(R1)
	MOV.W	8(R1), R12
	MOV.W	#-2, 2(R12)
	MOV.W	8(R1), R12
	MOV.W	@R12, R12
	MOV.W	50(R1), 10(R12)
	MOV.W	52(R1), 12(R12)
	MOV.W	&p2Score, R12
	ADD.W	#1, R12
	MOV.W	R12, &p2Score
	MOV.W	#1, 64(R1)
	BR	#.L20
.L24:
	MOV.B	69(R1), R12
	MOV.B	R12, R13
	ADD.B	#1, R13
	MOV.B	R13, 69(R1)
.L16:
	MOV.B	#1, R12
	CMP.B	69(R1), R12 { JHS	.L25
.L20:
	MOV.W	#1, 56(R1)
	MOV.W	8(R1), R12
	MOV.W	@R12, R12
	MOV.W	50(R1), 10(R12)
	MOV.W	52(R1), 12(R12)
	MOV.W	&p1Score, R13
	MOV.B	#9, R12
	CMP.W	R13, R12 { JL	.L26
	MOV.W	&p2Score, R13
	MOV.B	#9, R12
	CMP.W	R13, R12 { JGE	.L27
.L26:
	MOV.W	#0, &p1Score
	MOV.W	#0, &p2Score
.L27:
	MOV.W	&p1Score, R12
	AND	#0xff, R12
	ADD.B	#48, R12
	AND	#0xff, R12
	MOV.B	R12, &scoreBoard+2
	MOV.W	&p2Score, R12
	AND	#0xff, R12
	ADD.B	#48, R12
	AND	#0xff, R12
	MOV.B	R12, &scoreBoard
	MOV.W	8(R1), R12
	MOV.W	6(R12), 8(R1)
.L15:
	CMP.W	#0, 8(R1) { JNE	.L28
	MOV.W	#1, 54(R1)
	MOV.W	#0, @R1
	MOV.W	#-1, R15
	MOV.W	#scoreBoard, R14
	MOV.B	#15, R13
	MOV.B	#55, R12
	CALL	#drawString5x7
	NOP
	; start of epilogue
	ADD.W	#70, R1
	RET
	.size	mlAdvance, .-mlAdvance
	.balign 2
	.global	p1_UP_DOWN
	.type	p1_UP_DOWN, @function
p1_UP_DOWN:
; start of function
; framesize_regs:     0
; framesize_locals:   2
; framesize_outgoing: 0
; framesize:          2
; elim ap -> fp       2
; elim fp -> sp       2
; saved regs:(none)
	; start of prologue
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
; start of function
; framesize_regs:     0
; framesize_locals:   2
; framesize_outgoing: 0
; framesize:          2
; elim ap -> fp       2
; elim fp -> sp       2
; saved regs:(none)
	; start of prologue
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
	.global	bgColor
.data
	.balign 2
	.type	bgColor, @object
	.size	bgColor, 2
bgColor:
	.zero	2
	.global	redrawScreen
	.balign 2
	.type	redrawScreen, @object
	.size	redrawScreen, 2
redrawScreen:
	.short	1
	.comm	fieldFence,8,2
	.comm	pad1,8,2
	.comm	pad2,8,2
	.global	points1
	.type	points1, @object
	.size	points1, 1
points1:
	.zero	1
	.global	points2
	.type	points2, @object
	.size	points2, 1
points2:
	.zero	1
	.section	.rodata
.LC0:
	.string	"SCORE"
.text
	.balign 2
	.global	main
	.type	main, @function
main:
; start of function
; framesize_regs:     0
; framesize_locals:   2
; framesize_outgoing: 2
; framesize:          4
; elim ap -> fp       2
; elim fp -> sp       4
; saved regs:(none)
	; start of prologue
	SUB.W	#4, R1
	; end of prologue
	CALL	#configureClocks
	CALL	#lcd_init
	CALL	#shapeInit
	CALL	#buzzer_init
	MOV.B	#15, R12
	CALL	#p2sw_init
	CALL	#shapeInit
	MOV.W	#layer0, R12
	CALL	#layerInit
	MOV.W	#layer0, R12
	CALL	#layerDraw
	MOV.W	#fieldFence, R13
	MOV.W	#fieldLayer, R12
	CALL	#layerGetBounds
	MOV.W	#0, @R1
	MOV.W	#-1, R15
	MOV.W	#.LC0, R14
	MOV.B	#1, R13
	MOV.B	#50, R12
	CALL	#drawString5x7
	CALL	#enableWDTInterrupts
	MOV.B	#8, R12
	CALL	#or_sr
.L42:
	CALL	#p2sw_read
	MOV.W	R12, 2(R1)
	BR	#.L40
.L41:
	MOV.B	#16, R12
	CALL	#or_sr
.L40:
	MOV.W	&redrawScreen, R12
	CMP.W	#0, R12 { JEQ	.L41
	MOV.W	2(R1), R12
	CALL	#p1_UP_DOWN
	MOV.W	2(R1), R12
	CALL	#p2_UP_DOWN
	MOV.W	#0, &redrawScreen
	MOV.W	#layer0, R13
	MOV.W	#ml0, R12
	CALL	#movLayerDraw
	BR	#.L42
	.size	main, .-main
	.balign 2
	.global	wdt_c_handler
	.type	wdt_c_handler, @function
wdt_c_handler:
; start of function
; framesize_regs:     0
; framesize_locals:   0
; framesize_outgoing: 0
; framesize:          0
; elim ap -> fp       2
; elim fp -> sp       0
; saved regs:(none)
	; start of prologue
	; end of prologue
	MOV.W	&count.1826, R12
	ADD.W	#1, R12
	MOV.W	R12, &count.1826
	MOV.W	&count.1826, R12
	CMP.W	#15, R12 { JNE	.L46
	MOV.W	#fieldFence, R15
	MOV.W	#ml1, R14
	MOV.W	#ml0, R13
	MOV.W	#ml0, R12
	CALL	#mlAdvance
	CALL	#p2sw_read
	CMP.W	#0, R12 { JEQ	.L45
	MOV.W	#1, &redrawScreen
.L45:
	MOV.W	#1, &redrawScreen
	MOV.W	#0, &count.1826
.L46:
	NOP
	; start of epilogue
	RET
	.size	wdt_c_handler, .-wdt_c_handler
	.local	count.1826
	.comm	count.1826,2,2
	.ident	"GCC: (SOMNIUM Technologies Limited - msp430-gcc 6.2.1.16) 6.2.1 20161212"
 
