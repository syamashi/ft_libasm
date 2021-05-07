section	.text
global _ft_list_remove_if
extern _free

;void	ft_list_remove_if(t_list **begin_list,
;						  void *data_ref,
;					      int (*cmp)(),
;						  void (*free_fct)(void *));
;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

_ft_list_remove_if:
	cmp		rdi, 0
	je		.error
	cmp		rdx, 0
	je		.error
	cmp		rsi, 0
	je		.error
	cmp		rcx, 0
	je		.error
	push	rbp
	push	rbx
	push	r12
	push	r13
	push	r14
	push	r15
	mov		r12, rdi    ; &begin
	mov		r13, rsi    ; data_ref
	mov		r14, rdx    ; *cmp
	mov		r15, rcx    ; free
	jmp		.set_begin

.set_begin:
	mov		r8, [r12]
	cmp		r8, 0		; *begin == NULL
	je		.exit
	mov		rdi, [r8]	; (*begin)->data
	cmp		rdi, 0		; (*begin)->data == NULL
	je		.null_pass
	mov		rsi, r13
	push	r8
	call	r14			; *cmp
	pop		r8			; *begin
	cmp		rax, 0
	je		.remove_begin
	mov		r10, r8		; *begin
	jmp		.set_next

.null_pass:
	mov		r10, r8
	jmp		.set_next

.remove_begin:
	mov		r8, [r12]
	mov		rdi, [r8] ; begin->data
	mov		r9, [r8 + 8] ; begin->next
	push	r9
	call	r15          ; free(begin->data)
	mov		rdi, [r12]
	call	_free 	   ; free(*begin)
	pop		r9
	mov		[r12], r9
	jmp		.set_begin

.set_next:
	mov		r8, [r8 + 8]	; begin->next
	cmp		r8, 0			; begin->next == NULL
	je		.exit
	mov		rdi, [r8]		; next->data
	cmp		rdi, 0			; next-> == NULL
	je		.next_null_pass
	mov		rsi, r13		; *data_ref
	push	r8
	push	r10
	call	r14				; *cmp
	pop		r10
	pop		r8
	cmp		rax, 0
	je		.remove_next
	mov		r10, [r10 + 8]
	jmp		.set_next

.next_null_pass:
	mov		r10, [r10 + 8]
	jmp		.set_next

.remove_next:
	mov		rdi, [r8]	 ; next->data
	mov		r9, [r8 + 8] ; next->next
	mov		r11, [r10 + 8] ; *next
	push	r9
	push	r10
	push	r11
	call	r15			 ; free(next->data)
	pop		rdi			 ; *next
	call	_free		 ; free(*next)
	pop		r10
	pop		r9
	mov		[r10 + 8], r9
	mov		r8, r10
	jmp		.set_next

.exit:
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx
	pop		rbp
	mov		rdi, r12	; *begin = first
	ret

.error:
	ret
