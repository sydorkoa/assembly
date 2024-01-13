global	_start

section	.data
	msg1	db "How about another coffe?", 0
	msg1Len	equ $-msg1

	msg2	db "That's a good ammount of coffe!", 0
	msg2Len	equ $-msg2
	
	cls	db `\033[2J\033[H`,0Ah
	clsLen	equ $-cls

	q1	db "How many cups of coffee did you have?", 0, 10
	q1Len	equ $-q1

section .bss
	answer	resb 2
	

section	.text

_start:
	call	_q1
	call	_read
	mov	rax, [answer]
	sub	rax,'0'
	mov	r8,2
	cmp	rax,r8
	jl	_goMsg1
	jg	_goMsg2
_continue:
	jmp	_start

_goMsg1:
	call	_msg1
	jmp	_continue

_goMsg2:
	call	_msg2
	jmp	_end
_q1:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, q1
	mov	rdx, q1Len
	syscall
	ret

_read:
	mov	rax, 0
	mov	rdi, 0
	mov	rsi, answer
	mov	rdx, 2
	syscall
	ret

_cls:
	mov	eax, 1
	xor	rsi,rsi
	xor	rdx,rdx
	lea	rsi, [cls]
	mov	edx, clsLen
	mov	rdi, 1
	syscall
	ret
_msg1:
	mov	rax, 1
	mov	rdi, 1
	xor	rsi,rsi
	mov	rsi, msg1
	xor	rdx,rdx
	mov	rdx, msg1Len
	syscall
	ret
_msg2:
	mov	rax, 1
	mov	rdi, 1
	xor	rsi,rsi
	mov	rsi, msg2
	xor	rdx,rdx
	mov	rdx, msg2Len
	syscall
	ret
_end:
	mov     rax, 60
	mov     rdi, 0
	syscall

	
