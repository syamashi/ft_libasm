section .text
global _ft_atoi_base
extern _ft_strlen

;int ft_atoi_base(char *str, char *base);
;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

_ft_atoi_base:
	push	rbp
	mov		rbp, rsp
	push	r12
	push	r13
	push	r14
	push	r15
	cmp		rdi, 0
	je		.error
	cmp		rsi, 0
	je		.error
	xor		rax, rax ; total
	xor		r12, r12 ; strlen(base)
	xor		r13, r13 ; base_dupcheck_top
	xor		r14, r14 ; base_dupcheck_back
	xor		r15, r15 ; base_dupcheck_backchar
	jmp		.base_len

.base_len:
	cmp		BYTE[rsi + r12], 0
	je		.base_sizecheck
	inc		r12
	jmp		.base_len

.base_sizecheck:
	cmp		r12, 2
	jl		.error
	jmp		.base_dupcheck

.base_dupcheck:
	inc		r14
	mov		r15b, BYTE[rsi + r14]
	cmp		BYTE[rsi + r13], r15b
	je		.error
	cmp		r14, r12
	jmp		.base_topcheck

.base_topcheck:
	cmp		BYTE[rsi + r13], 9	;'\t'
	je		.error
	cmp		BYTE[rsi + r13], 10	; '\n'
	je		.error
	cmp		BYTE[rsi + r13], 11	; '\v'
	je		.error
	cmp		BYTE[rsi + r13], 12	; '\f'
	je		.error
	cmp		BYTE[rsi + r13], 13	; '\r'
	je		.error
	cmp		BYTE[rsi + r13], 32	; ' '
	je		.error
	cmp		BYTE[rsi + r13], 43	; '+'
	je		.error
	cmp		BYTE[rsi + r13], 45	; '-'
	je		.error
	inc		r13
	cmp		r13, r12
	je		.str_read_space
	jmp		.base_dupcheck

.str_read_space:
	xor		r13, r13;strindex
	xor		r14, r14;flag
	xor		r15, r15;strchar
	jmp		.str_is_space

.str_is_space:
	cmp		BYTE[rdi + r13], 9	; \t
	je		.str_inc
	cmp		BYTE[rdi + r13], 10	; \n
	je		.str_inc
	cmp		BYTE[rdi + r13], 11	; \v
	je		.str_inc
	cmp		BYTE[rdi + r13], 12	; \f
	je		.str_inc
	cmp		BYTE[rdi + r13], 13	; \r
	je		.str_inc
	cmp		BYTE[rdi + r13], 32	; ' '
	je		.str_inc
	jmp		.str_is_flag

.str_inc:
	inc		r13
	jmp		.str_is_space

.str_is_flag:
	cmp		BYTE[rdi + r13], 43	; '+'
	je		.str_inc_plus
	cmp		BYTE[rdi + r13], 45	; '-'
	je		.str_inc_minus
	jmp		.str_atoi

.str_inc_plus:
	inc		r13
	jmp		.str_is_flag

.str_inc_minus:
	xor		r14, 1
	inc		r13
	jmp		.str_is_flag

.str_atoi:					; BYTE[rdi + r13] = afterflag
	xor 	r9, r9;baseindex
	mov		r15b, BYTE[rdi + r13]
	cmp		r15b, 0;strchar
	je		.judge_flag
	jmp		.search_base

.search_base:
	cmp		r15b, BYTE[rsi + r9]
	je		.add_atoi
	inc		r9
	cmp		r9, r12
	je		.judge_flag
	jmp		.search_base
	
.add_atoi:
	mul		r12				; rax * strlen(base)
	add		rax, r9			; rax + baseindex
	inc		r13;strindex++
	jmp		.str_atoi

.error:
	xor		rax, rax
	jmp 	.exit

.judge_flag:
	cmp		r14, 1
	je		.add_flag
	jmp		.exit

.add_flag:
	mov		r14, -1
	mul		r14
	jmp		.exit

.exit:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbp
	ret
