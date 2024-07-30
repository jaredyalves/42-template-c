###################
#    Mandatory    #
###################

NAME			:=	template
IS_LIB			:=	$(shell echo $(NAME) | grep -E '\.a$$')

SRCDIR			:=	src
OBJDIR			:=	obj
LIBDIR			:=	lib
INCDIR			:=	include

SRCS			:=	$(SRCDIR)/main.c
SRCS			+=	$(SRCDIR)/helloworld.c
OBJS			:=	$(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS))
INCS			:=	$(INCDIR)/template.h

CC				:=	/bin/cc
INCLUDES		:=	-I$(INCDIR)
CFLAGS			:=	-O3 -Wall -Werror -Wextra $(INCLUDES)
LDFLAGS			:=

AR				:=	/bin/ar
ARFLAGS			:=	-rcs

RM				:=	/bin/rm
RMFLAGS			:=	-rf

COLOR_RESET		:=	\033[0m
COLOR_CLEAN		:=	\033[0;33m
COLOR_COMPILE	:=	\033[0;32m
COLOR_LINK		:=	\033[0;34m

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	@if [ -n "$(IS_LIB)" ]; then \
		printf "$(COLOR_LINK)Creating archive $@...$(COLOR_RESET)\n"; \
		$(AR) $(ARFLAGS) $@ $(OBJS); \
	else \
		printf "$(COLOR_LINK)Linking $@...$(COLOR_RESET)\n"; \
		$(CC) -o $@ $(OBJS) $(LDFLAGS); \
	fi

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(INCS)
	@mkdir -p $(dir $@)
	@printf "$(COLOR_COMPILE)Compiling $<...$(COLOR_RESET)\n"
	@$(CC) $(CFLAGS) -o $@ -c $<

clean:
	@printf "$(COLOR_CLEAN)Cleaning up...$(COLOR_RESET)\n"
	@$(RM) $(RMFLAGS) $(OBJDIR)

fclean:: clean
	@printf "$(COLOR_CLEAN)Removing $(NAME)...$(COLOR_RESET)\n"
	@$(RM) $(RMFLAGS) $(NAME)

re: fclean all

###################
#      Bonus      #
###################

NAME_BONUS		:=	template_bonus
IS_LIB_BONUS	:=	$(shell echo $(NAME_BONUS) | grep -E '\.a$$')

SRCS_BONUS		:= $(SRCDIR)/main_bonus.c
SRCS_BONUS		+= $(SRCDIR)/helloworld_bonus.c
OBJS_BONUS		:= $(patsubst $(SRCDIR)/%.c,$(OBJDIR)/%.o,$(SRCS_BONUS))
INCS_BONUS		:= $(INCDIR)/template_bonus.h

.PHONY: bonus

bonus: $(NAME_BONUS)

$(NAME_BONUS): $(OBJS_BONUS)
	@if [ -n "$(IS_LIB_BONUS)" ]; then \
		printf "$(COLOR_LINK)Creating bonus archive $@...$(COLOR_RESET)\n"; \
		$(AR) $(ARFLAGS) $@ $(OBJS_BONUS); \
		printf "$(COLOR_LINK)Adding bonus to $(NAME)...$(COLOR_RESET)\n"; \
		$(AR) $(ARFLAGS) $(NAME) $(OBJS_BONUS); \
	else \
		printf "$(COLOR_LINK)Linking bonus $@...$(COLOR_RESET)\n"; \
		$(CC) -o $@ $(OBJS_BONUS) $(LDFLAGS); \
	fi

$(OBJDIR)/%.o: $(SRCDIR)/%.c $(INCS) $(INCS_BONUS)
	@mkdir -p $(dir $@)
	@printf "$(COLOR_COMPILE)Compiling $<...$(COLOR_RESET)\n"
	@$(CC) $(CFLAGS) -o $@ -c $<

fclean::
	@printf "$(COLOR_CLEAN)Removing $(NAME_BONUS)...$(COLOR_RESET)\n"
	@$(RM) $(RMFLAGS) $(NAME_BONUS)
