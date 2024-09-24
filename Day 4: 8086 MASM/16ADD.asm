.MODEL SMALL
.STACK 100H
.DATA
	A DW 6090H      ; Define word A with value 1234H
	B DW 9060H      ; Define word B with value 5678H
.CODE
	MOV AX, @DATA   ; Initialize data segment
	MOV DS, AX

	MOV SI, OFFSET A ; Load offset of A into SI
	MOV BX, [SI]     ; Move value of A into BX

	MOV DI, OFFSET B ; Load offset of B into DI
	MOV AX, [DI]     ; Move value of B into AX

	ADD AX, BX       ; Add A and B, result stored in AX

	MOV CX, 0000H    ; Initialize CX to 0 (for counting characters)
	MOV BX, 16       ; BX = 16 for hexadecimal division
	
CONVERT:
	XOR DX, DX       ; Clear DX
	DIV BX           ; AX / 16 (result in AX, remainder in DX)
	PUSH DX          ; Push remainder onto the stack
	INC CX           ; Increment character count
	CMP AX, 0        ; Check if quotient is zero
	JNZ CONVERT      ; If not, continue converting

PRINT:
	POP DX           ; Pop the last remainder from the stack
	ADD DX, '0'      ; Convert to ASCII
	CMP DX, '9'      ; Check if it's greater than '9'
	JBE OUTPUT       ; If so, print it
	ADD DX, 7        ; Adjust for A-F range

OUTPUT:
	MOV AH, 02H      ; DOS interrupt for displaying character
	INT 21H          ; Call interrupt

	DEC CX           ; Decrement character count
	JNZ PRINT        ; If more characters, print next

	MOV AH, 4CH      ; DOS interrupt to exit program
	INT 21H
END
