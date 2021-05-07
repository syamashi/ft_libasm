section .text
global _ft_list_size

;int		ft_list_size(t_list *begin_list);
;0=rax 1=rdi 2=rsi 3=rdx 4=rcx 5=r8 6=r9

;typedef struct	s_list{
;	void			*data;
;	struct s_list	*next;
;}				t_list;

_ft_list_size:
	xor	rax, rax
	jmp	.cnt_size
	
.cnt_size:
	cmp		rdi, 0
	je		.exit
	inc		rax
	mov		rdi, [rdi + 8]
	jmp 	.cnt_size

.exit:
	ret
