/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sort.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: syamashi <syamashi@student.42.tokyo>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/11/11 01:27:53 by syamashi          #+#    #+#             */
/*   Updated: 2020/11/11 15:44:50 by syamashi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./includes/libasm_bonus.h"

static int compar_int(void *a, void *b)
{
	return *(int*)a - *(int*)b;
}

void	print_list(t_list *list){
	int n = 0;
	while (list)
	{
		printf("list[%d]->data : [%d]\n",n ,*(int*)list->data);
		list = list->next;
		n++;
	}
}

static void	lstclear(t_list **list){
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

static int *ft_numdup(int n){
	int *dup;
	dup = malloc(sizeof(int));
	*dup = n;
	printf("n:%d\n", *dup);
	return (dup);
}

int main(){
	t_list *list = NULL;
	setbuf(stdout, NULL);
	printf("-----ft_list_push_front(98 12 12 45 1 -1 232 34 23)-----\n");
	ft_list_push_front(&list, ft_numdup(23));
	ft_list_push_front(&list, ft_numdup(34));
	ft_list_push_front(&list, ft_numdup(232));
	ft_list_push_front(&list, ft_numdup(-1));
	ft_list_push_front(&list, ft_numdup(1));
	ft_list_push_front(&list, ft_numdup(45));
	ft_list_push_front(&list, ft_numdup(12));
	ft_list_push_front(&list, ft_numdup(12));
	ft_list_push_front(&list, ft_numdup(98));
	printf("---pre---\n");
	print_list(list);
	printf("---print_end---\n");
	int	z = ft_list_sort(&list, compar_int);
	printf("rax : %d\n", z);
	printf("\n---sort---\n");
	print_list(list);
	lstclear(&list);

	printf("-----ft_list_push_front(12 45 1 -1 232 34 23 87879)-----\n");
	ft_list_push_front(&list, ft_numdup(87879));
	ft_list_push_front(&list, ft_numdup(23));
	ft_list_push_front(&list, ft_numdup(34));
	ft_list_push_front(&list, ft_numdup(232));
	ft_list_push_front(&list, ft_numdup(-1));
	ft_list_push_front(&list, ft_numdup(1));
	ft_list_push_front(&list, ft_numdup(45));
	ft_list_push_front(&list, ft_numdup(12));
	printf("---pre---\n");
	print_list(list);
	printf("---print_end---\n");
	z = ft_list_sort(&list, compar_int);
	printf("rax : %d\n", z);
	printf("\n---sort---\n");
	print_list(list);
	lstclear(&list);
}
