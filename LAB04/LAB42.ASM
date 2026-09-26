TITLE	LAB42
.MODEL	SMALL
.STACK	100H

.DATA
CR		EQU	0DH
LF		EQU	0AH

NL		DB	CR, LF, '$'

PROMPT		DB	"Enter a number: $"

.CODE
MAIN	PROC
;initialise DS
	MOV	AX, @DATA
	MOV	DS, AX

;show prompt
	MOV	AH, 09H
	LEA	DX, PROMPT
	INT	21H

;read input
	MOV	AH, 01H
	INT	21H
	MOV	BL, AL
	;next_line
	MOV	AH, 09H
	LEA	DX, NL
	INT	21H

;ascii_to_dec
	SUB	BL, 30H 

;default
	MOV	CL, 0	;star counter
	MOV	CH, 0	;row counter

LINE_LOOP:
	INC	CH	;new row
	MOV	CL, 0	;reset star counter
	CMP	BL, 0	;row remaining
	JNZ	PRINT_STAR
	JMP	EXIT

STAR_LOOP:
	CMP	CL, CH
	JNZ	PRINT_STAR
	;next_line
	MOV	AH, 09H
	LEA	DX, NL
	INT	21H
	;line_loop
	DEC	BL
	JMP	LINE_LOOP

PRINT_STAR:
	MOV	AH, 02H
	MOV	DL, '*'
	INT	21H
	INC	CL
	JMP	STAR_LOOP

EXIT:
	MOV	AH, 4CH
	INT	21H

MAIN	ENDP
	END	MAIN
