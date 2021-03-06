        ; 8080 assembler code
        .hexfile PrintNumbersRev.hex
        .binfile PrintNumbersRev.com
        ; try "hex" for downloading in hex format
        .download bin
        .objcopy gobjcopy
        .postbuild echo "OK!"
        ;.nodump

	; OS call list
PRINT_B		equ 1
PRINT_MEM	equ 2
READ_B		equ 3
READ_MEM	equ 4
PRINT_STR	equ 5
READ_STR	equ 6

	; Position for stack pointer
stack   equ 0F000h

	org 000H
	jmp begin

	; Start of our Operating System
GTU_OS:	PUSH D
	push D
	push H
	push psw
	nop	; This is where we run our OS in C++, see the CPU8080::isSystemCall()
		; function for the detail.
	pop psw
	pop h
	pop d
	pop D
	ret
	; ---------------------------------------------------------------
	; YOU SHOULD NOT CHANGE ANYTHING ABOVE THIS LINE

	;This program prints a null terminated string to the screen

U_BOUND		equ 100 ; number bound to write
L_BOUND		equ 49

begin:
	LXI SP,stack 	; always initialize the stack pointer

	MVI B,U_BOUND ; initialize b

LOOP:	MVI A, PRINT_B ; initalize to print
	call GTU_OS ; system call
	DCR B ; increment b
	MVI A, L_BOUND ; set a register to 50
	SUB B ; A=A-B;
	JM LOOP ; jmp if A is positive
	hlt		; end program
