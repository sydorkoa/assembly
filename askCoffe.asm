; Compile with:
; nasm  -f elf64 askCoffe.asm && ld askCoffe.o -o askCoffe
;
section	.data
	msg1		db 0xa, "How about another coffe?", 10, 0
	.len	equ $-msg1

	msg2		db 0xa, "That's a good ammount of coffe!", 10, 0
	.len	equ $-msg2
	
        msg3            db 0xa, "A perfect way to start!", 10, 0
        .len    equ $-msg3

	cls		db `\033[2J\033[H`,0Ah, 0
	.len		equ $-cls

	q1		db 0xa, "How many cups of coffee did you have?", 0 
	.len		equ $-q1

section .bss
	answer		resb 2
	
section	.text
global	_start

_start:
	nop
	call	_cls
_continue:
	call	_q1
	call	_read
	cmp	al, 2
	call	_cls
	jl	_msg1
	je	_msg3
	jg	_msg2
	jmp	_start

_q1:
	mov	rax, 1
	mov	rdi, 1
	lea	rsi, q1
	mov	rdx, q1.len
	syscall
	ret
_read:
	mov	al, 0
	mov	rdi, 0
	xor	rsi,rsi
	mov	rsi, answer
	mov	dl, 2
	syscall
	mov	al, byte [answer]
	sub	al, '0'
	ret

_cls:
	mov	rax, 1
	lea	rsi, [cls]
	mov	rdx, cls.len
	mov	rdi, 1
	syscall
	ret
_msg1:
	mov	rax, 1
	mov	rdi, 1
	lea	rsi, [msg1]
	mov	rdx, msg1.len
	syscall
	jmp	_continue
_msg2:
	mov	rax, 1
	mov	rdi, 1
	lea	rsi, [msg2]
	mov	rdx, msg2.len
	syscall
	jmp	_continue
	
_msg3:
        mov     rax, 1
        mov     rdi, 1
        lea     rsi, [msg3]
        mov     rdx, msg3.len
        syscall
        jmp     _continue


_end:
	mov     rax, 60
	mov     rdi, 0
	syscall

	
