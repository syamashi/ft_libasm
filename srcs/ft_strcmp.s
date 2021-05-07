section .text
global _ft_strcmp

;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9
;signed:jl,je,jg, unsigned:jb, je, ja

_ft_strcmp:
	mov		rax, -1
	jmp		.L1

.L1:
	inc		rax
	xor		rdx, rdx
	xor		rcx, rcx
	mov		dl, BYTE[rdi + rax]
	mov		cl, BYTE[rsi + rax]
	cmp		rdx, 0
	je		.exit
	cmp		rdx, rcx
	je		.L1
	jmp		.exit

.exit:
	cmp		rdx, rcx
	jl		.rax_little
	je		.rax_equal
	jg		.rax_greater
	
.rax_little:
	mov		rax, -1
	ret

.rax_equal:
	xor		rax, rax
	ret

.rax_greater:
	mov		rax, 1
	ret
