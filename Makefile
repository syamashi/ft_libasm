NAME = libasm.a
SRCFILE = ft_read.s\
	   ft_strcmp.s\
	   ft_strcpy.s\
	   ft_strdup.s\
	   ft_strlen.s\
	   ft_write.s
BONUSFILE = ft_atoi_base.s\
	   ft_list_push_front.s\
	   ft_list_size.s\
	   ft_list_sort.s\
	   ft_list_remove_if.s
SRCDIR = srcs/
SRCS = $(addprefix $(SRCDIR), $(SRCFILE))
BONUSES = $(addprefix $(SRCDIR), $(BONUSFILE))
HEADER = includes/libasm.h
OBJS = $(SRCS:.s=.o)
BOBJS = $(BONUSES:.s=.o)
CC = gcc
FLAGS = -Wall -Wextra -Werror

%.o : %.s
	nasm -f macho64 $< -o $@
$(NAME) : $(OBJS)
	ar rcs $(NAME) $^
all	: $(NAME)
grademe : all
	$(CC) $(FLAGS) -I./$(HEADER) $(NAME) main.c -o libasm -fsanitize=address
	./libasm
clean :
	rm -f $(OBJS) $(BOBJS)
fclean : clean
	rm -f $(NAME)
	rm -f libasm
re : fclean all
bonus : $(OBJS) $(BOBJS)
	ar rcs $(NAME) $^	
bgrademe : bonus
	$(CC) $(FLAGS) -I./$(HEADER) $(NAME) bonus.c -o libasm -fsanitize=address
	./libasm
.PHONY : all clean fclean re bonus bgrademe
