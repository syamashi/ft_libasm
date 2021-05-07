section .text
global	_ft_list_push_front
extern	_malloc

;void	ft_list_push_front(t_list **begin_list, void *data);
;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

;typedef struct s_list
;{
;	void 			*data;
;	struct s_list	*next;
;} 				t_list;

_ft_list_push_front:
	cmp		rdi, 0
	je		.error
	push	rbp
	mov		rbp, rsp
	push	rdi
	push	rsi 		; escape before call
	mov		rdi, 16
	call	_malloc
	pop		rsi
	pop		rdi
	cmp		rax, 0
	je		.exit
	mov		[rax], rsi	; list->data
	cmp		rdi, 0
	je		.exit
	mov		r8, [rdi]
	mov		[rax + 8], r8	; list->next
	mov		[rdi], rax
	jmp		.exit
	
.error:
	ret	

.exit:
	pop		rbp
	ret
