all: main
LIB=libConversions.o
CC=gcc
AS=as

main: main.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o: 
	$(AS) $(@:.o=.s) -g -o $@

