/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: syamashi <syamashi@student.42.tokyo>       +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2020/11/08 01:26:25 by syamashi          #+#    #+#             */
/*   Updated: 2020/11/09 17:14:37 by syamashi         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "./includes/libasm.h"

void	print_ft_strlen(char s[]){
	int n;
	printf("-----ft_strlen(%s)-----\n", s);
	n = ft_strlen(s);
	printf("ft_strlen:[%d]\n", n);
	n = strlen(s);
	printf("   strlen:[%d]\n\n", n);
}

void	print_ft_strcpy(char s1[], char s2[]){
	char *tmp = strdup(s1);
	char *s3;
	printf("-----ft_strcpy(%s, %s)-----\n", s1, s2);
	s3 = ft_strcpy(s1, s2);
	printf("ft_strcpy:[%s]\n", s3);
	ft_strcpy(s1, tmp);
	s3 = strcpy(s1, s2);
	printf("   strcpy:[%s]\n\n", s3);
	strcpy(s1, tmp);
	free(tmp);
}

void	print_ft_strcmp(char s1[], char s2[]){
	int n;
	printf("-----ft_strcmp(%s, %s)-----\n", s1, s2);
	n = ft_strcmp(s1, s2);
	printf("ft_strcmp:[%d]\n", n);
	n = strcmp(s1, s2);
	printf("   strcmp:[%d]\n\n", n);
}

void	print_ft_write(int fd, char s[], size_t byte){
	errno = 0;
	printf("-----ft_write(%d, %s, %zu)-----\n", fd, s, byte);
	printf("ft_write:[");
	int count = ft_write(fd, s, byte);
	printf("] count:[%d]", count);
	printf(" strerror:[%s]", strerror(errno));
	printf(" error:[%d]\n", errno);
	errno = 0;
	printf("   write:[");
	count = write(fd, s, byte);
	printf("] count:[%d]", count);
	printf(" strerror:[%s]", strerror(errno));
	printf(" error:[%d]\n\n", errno);
}

void	print_ft_read(char pass[], char buf[]){
	int fd;
	int n;
	int i = -1;
	while (++i < 1024)
		buf[i] = 0;
	errno = 0;
	fd = open(pass, O_RDONLY);
	n = ft_read(fd, buf, 1024);
	printf("-----ft_read(fd:[%d], pass:[%s])-----\n", fd, pass);
	printf("ft_read:[%s]\n", buf);
	printf("val:[%d], strerror:[%s], errno:[%d]\n", n, strerror(errno), errno);
	close(fd);
	i = 0;
	while (++i < 1024)
		buf[i] = 0;
	errno = 0;
	fd = open(pass, O_RDONLY);
	n = read(fd, buf, 1024);
	printf("   read:[%s]\n", buf);
	printf("val:[%d], strerror:[%s], errno:[%d]\n\n", n, strerror(errno), errno);
	close(fd);
}

void	print_ft_strdup(char s[]){
	char *dup;

	printf("-----ft_strdup(%s)-----\n", s);
	dup = ft_strdup(s);
	printf("ft_strdup:[%s]\n", dup);
	free(dup);
	dup = strdup(s);
	printf("   strdup:[%s]\n\n", dup);
	free(dup);
}

int main(){
	char buf[1024] = {};
	char s1[100] = "abcdefg";

	setbuf(stdout, NULL);
	print_ft_strlen("abc");
	print_ft_strlen("");

	print_ft_strcpy(s1, "123");
	print_ft_strcpy(s1, "123456789");
	print_ft_strcpy(s1, "1");

	print_ft_strcmp("abc", "abc");
	print_ft_strcmp("abc", "abcd");
	print_ft_strcmp("abcd", "abc");
	print_ft_strcmp("abc", "acd");
	print_ft_strcmp("", "");
	print_ft_strcmp("\xff\xff", "\xff");
	print_ft_strcmp("\xff", "");

	print_ft_write(1, "hello_world", 12);
	print_ft_write(2, "hello_world", 12);
	print_ft_write(-1, "hello_world", 12);
	print_ft_write(1, "hello_world", 10);
//	print_ft_write(1, "hello_world", 50);
	print_ft_write(1, "hello_world", 0);
	print_ft_write(1, "hello_world", -100);
	print_ft_write(1, NULL, 0);
	print_ft_write(1, NULL, 1);
	print_ft_write(1, NULL, -1);
	print_ft_write(1, NULL, 10);
	print_ft_write(42, NULL, 10);
	print_ft_write(1, "", 1);
	print_ft_write(OPEN_MAX + 1, "OPEN_MAX+1", 10);
	print_ft_write(98123, "", 1);
	print_ft_write(-1, "test", 5);
	print_ft_write(-1, "bonjour", 7);
	print_ft_write(42, "bonjour", 7);
	print_ft_write(9809, "bonjour", 7);
	print_ft_write(98123, "", 1);
//	print_ft_write(0, "hello_world", 12);

	int fd = open("newtext.txt", O_WRONLY);
	ft_write(fd, "are you drunk?", 14);
	close(fd);

	print_ft_read("sample.txt", buf);
	print_ft_read("404_error", buf);

	print_ft_strdup("abc");
	print_ft_strdup("");

	return (0);
}
