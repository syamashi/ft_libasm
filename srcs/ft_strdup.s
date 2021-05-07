section.text:
	global _ft_strdup
	extern _malloc
	extern _ft_strlen
	extern _ft_strcpy

;char	*ft_strdup(const char *str);
;size_t	ft_strlen(const char *s);
;char	*ft_strcpy(char *dst, const char *src);

;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

_ft_strdup:
	push	rbp
	mov		rbp, rsp
	push	rdi
	call	_ft_strlen
	inc		rax
	mov		rdi, rax
	call	_malloc		; raxに先頭ポインタ
	cmp		rax, 0
	je		.error
	pop		rsi
	mov		rdi, rax
	call	_ft_strcpy
	jmp		.exit

.error:
	pop		rdi
	jmp		.exit

.exit:
	pop		rbp
	ret
