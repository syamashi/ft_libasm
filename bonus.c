/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   bonus.c                                            :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: syamashi <syamashi@student.42.tokyo>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/11/08 01:26:03 by syamashi          #+#    #+#             */
/*   Updated: 2020/11/09 18:21:42 by syamashi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./includes/libasm.h"

char	tr_space(char c){
	if (c == '\t')
		return ('t');
	if (c == '\n')
		return ('n');
	if (c == '\v')
		return ('v');
	if (c == '\f')
		return ('v');
	if (c == '\r')
		return ('r');
	else
		return (c);
	}

void	print_ft_atoi_base(char s1[], char s2[]){
	int n;
	char *t1 = NULL;
	char *t2 = NULL;
	int i = -1;
	if (s1)
		t1 = ft_strdup(s1);
	if (s2)
		t2 = ft_strdup(s2);
	if (t1){
		while (t1[++i])
			t1[i] = tr_space(t1[i]);
	}
	i = -1;
	if (t2){
		while (t2[++i])
			t2[i] = tr_space(t2[i]);
	}
	n = ft_atoi_base(s1, s2);
	printf("ft_atoi_base(%s, %s) : %d\n", t1, t2, n);
	free(t1);
	free(t2);
}

void	lstclear(t_list **list){
	t_list *tmp;
	while (*list){
		tmp = (*list)->next;
		if ((*list)->data){
			free((*list)->data);
			(*list)->data = NULL;
		}
		free(*list);
		*list = NULL;
		*list = tmp;
	}
}

void	print_list(t_list *list){
	int n = 0;
	while (list)
	{
		printf("list[%d]->data : [%s]\n",n ,list->data);
		list = list->next;
		n++;
	}
}

void	free_fct(void *data){
	if (data){
		free(data);
		data = NULL;
	}
}

t_list	*ft_create_elem(void *data)
{
	t_list	*list;

	list = NULL;
	list = malloc(sizeof(t_list));
	if (list)
	{
		list->data = data;
		list->next = NULL;
	}
	return (list);
}

void	ft_list_push_front_sample(t_list **begin_list, void *data)
{
	t_list	*list;

	if (*begin_list)
	{
		list = ft_create_elem(data);
		list->next = *begin_list;
		*begin_list = list;
	}
	else
		*begin_list = ft_create_elem(data);
}


int main(){
	int n;
	t_list	*list = NULL;

	setbuf(stdout, NULL);
	print_ft_atoi_base("123", "0123456789");
	print_ft_atoi_base("2147483646", "0123456789");
	print_ft_atoi_base("2147483647", "0123456789");
	print_ft_atoi_base("2147483648", "0123456789");
	print_ft_atoi_base("-2147483647", "0123456789");
	print_ft_atoi_base("-2147483648", "0123456789");
	print_ft_atoi_base("-2147483649", "0123456789");
	print_ft_atoi_base("   +++-100", "0123456789");
	print_ft_atoi_base("   ------100", "0123456789");
	print_ft_atoi_base(NULL, "0123456789");
	print_ft_atoi_base("100", NULL);
	print_ft_atoi_base("000", "0");
	print_ft_atoi_base("000", "");
	print_ft_atoi_base("", "0123456789");
	print_ft_atoi_base("100", " 0123");
	print_ft_atoi_base("100", "0\t123");
	print_ft_atoi_base("100", "01\n23");
	print_ft_atoi_base("100", "012\v3");
	print_ft_atoi_base("100", "0123\f");
	print_ft_atoi_base("100", "\r0123");
	print_ft_atoi_base("100", "0 123");
	print_ft_atoi_base("100", "01+23");
	print_ft_atoi_base("100", "012-3");
	print_ft_atoi_base("100", "01");
	print_ft_atoi_base("0", "0123");
	print_ft_atoi_base("123", "00123");
	print_ft_atoi_base(" \t\n\v\f\r+-100", "0123456789");
	print_ft_atoi_base(" \t\n\v\f\r+-100a100", "0123456789");
	print_ft_atoi_base("baa", "abcdefghij");
	print_ft_atoi_base("aaaaabaa", "abcdefghij");
	printf("\n");

	printf("-----ft_list_push_front(1st -> 2nd)-----\n");
	ft_list_push_front(&list, strdup("1st_push"));
	ft_list_push_front(&list, strdup("2nd_push"));
	print_list(list);
	lstclear(&list);
	printf("\n");

	printf("-----ft_list_size-----\n");
	n = ft_list_size(list);
	printf("ft_list_size[0] : %d\n", n);
	ft_list_push_front(&list, strdup("1st_push"));
	n = ft_list_size(list);
	printf("ft_list_size[1push] : %d\n", n);
	ft_list_push_front(&list, strdup("2nd_push"));
	n = ft_list_size(list);
	printf("ft_list_size[2push] : %d\n", n);
	ft_list_push_front(&list, strdup("3rd_push"));
	n = ft_list_size(list);
	printf("ft_list_size[3push] : %d\n", n);
	ft_list_push_front(&list, strdup("2nd_push"));
	n = ft_list_size(list);
	printf("ft_list_size[re2push] : %d\n\n", n);

	printf("-----pre_sort[2nd,3rd,2nd,1st]-----\n");
	print_list(list);
	ft_list_sort(&list, strcmp);
	printf("\n");
	printf("-----ft_list_sort[2nd,3rd,2nd,1st]-----\n");
	print_list(list);

	printf("\n");
	printf("-----ft_list_remove_if[1st,2nd,2nd,3rd]-----\n");
	printf("list_p				: %p\n", list);
	printf("list->data_p			: %p\n", list->data);
	printf("list->next_p			: %p\n", list->next);
	printf("list->next->data_p		: %p\n", list->next->data);
	printf("list->next->next_p		: %p\n", list->next->next);
	printf("list->next->next->data_p	: %p\n", list->next->next->data);
	printf("list->next->next->next_p	: %p\n", list->next->next->next);
	printf("list->next->next->next->data_p	: %p\n", list->next->next->next->data);
	printf("list->next->next->next->next_p	: %p\n", list->next->next->next->next);
	ft_list_remove_if(&list, "2nd_push", strcmp, free_fct);
	printf("\n");
	printf("after list_p		: %p\n", list);
	printf("after list->data_p	: %p\n", list->data);
	printf("after list->next_p	: %p\n", list->next);
	printf("after list->next->data_p: %p\n", list->next->data);
	printf("after list->next->next_p: %p\n", list->next->next);
	printf("\n");
	print_list(list);
}
