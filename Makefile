CC = gcc
CFLAGS = -Wall -Iinclude
LIBFLAGS = -Llib -lmyutils
TARGET = bin/client_static
LIB = lib/libmyutils.a

all: $(TARGET)

$(TARGET): obj/main.o $(LIB)
	$(CC) obj/main.o -o $(TARGET) $(LIBFLAGS)

$(LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	ar rcs $(LIB) obj/mystrfunctions.o obj/myfilefunctions.o

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

clean:
	rm -f obj/*.o bin/client_static lib/*.a
