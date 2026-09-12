TITLE	LAB11
.MODEL	SMALL
.STACK	100H

.DATA
CR		EQU	0DH
LF		EQU	0AH
ASCII_ZERO	EQU	48

NL		DB	CR, LF, '$'

MSG		DB	"THE SUM OF "
NUM1		DB	?
MSG_AND		DB	" AND "
NUM2		DB	?
MSG_IS		DB	" IS "
SUM		DB	?, '$'

.CODE
MAIN	PROC
;initialise DS
	MOV	AX, @DATA
	MOV	DS, AX

;display prompt
	MOV	AH, 02H
	MOV	DL, '?'
	INT	21H

;read two decimal digits
	MOV	AH, 01H

	INT	21H
	MOV	NUM1, AL
	INT	21H
	MOV	NUM2, AL

	;next line
	LEA	DX, NL
	MOV	AH, 09H
	INT	21H

;add===========================
	MOV	AL, NUM1

	SUB	AL, ASCII_ZERO
	ADD	AL, NUM2

	MOV	SUM, AL

;display result
	LEA	DX, MSG
	MOV	AH, 09H
	INT	21H

;DOS exit
	MOV	AH, 4CH
	INT	21H

MAIN	ENDP
	END	MAIN
