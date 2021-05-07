section .text
global _ft_list_sort
extern _ft_list_size

;int        ft_list_size(t_list *begin_list);
;void ft_list_sort(t_list **begin_list, int (*cmp)());
;(*cmp)(list_ptr->data, list_other_ptr->data)
;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

;typedef struct s_list{
;   void			*data;
;   struct s_list	*next;
;}				t_list;

;call rsi can get cmp return value
;cmp = ft_strcmp
;low = top, high = back

_ft_list_sort:
	xor		r8, r8		; list_size
	xor		r9, r9		; work_cnt
	xor		r10, r10	; *cmp
	xor		r11, r11	; top_ptr
	cmp		rdi, 0
	je		.error
	cmp		rsi, 0
	je		.error
	push	rbp
	mov		rbp, rsp
	push	r12 
	push	r13
	push	r14
	mov		r14, rdi	; &begin
	mov		r10, rsi	; *cmp
	mov		r11, rdi	; &begin
	mov		rdi, [rdi]	; *begin
	call	_ft_list_size
	mov		r8, rax		; ft_list_size(list)
	jmp		.def_sort

.def_sort:
	dec		r8			; max_sort_cnt
	cmp		r8, 0		; finish sort cnt
	je		.exit
	mov 	r9, r8		; r9 = work_cnt
	mov		r12, [r11]	; *begin
	mov 	rsi, [r12]	; begin->data
	jmp		.check_sort

.check_sort: ; r12 = now_ptr, r13 = next_ptr
	cmp		r9, 0
	je		.def_sort
	mov		rdi, rsi		; begin->data
	cmp		rdi, 0
	je		.exit			; now->data == NULL is end
	mov		r13, [r12 + 8]	; begin->next
	mov		rsi, [r13]		; next->data
	cmp		rsi, 0			; next->data == NULL is end
	je		.exit
	push	rdi
	push	rsi
	call	r10				; *cmp
	pop		rsi
	pop		rdi
	cmp		rax, 1			; strcmp == 1
	je		.swap
	jmp		.dec_cnt
	
.swap:
	mov		[r12], rsi
	mov		[r13], rdi
	mov		rsi, rdi
	jmp		.dec_cnt

.dec_cnt:
	dec		r9
	mov		r12, r13
	jmp		.check_sort

.error:
	ret
	
.exit:
	pop 	r14
	pop		r13
	pop 	r12
	pop 	rbp
	mov		rdi, r14 ; &begin
	ret
