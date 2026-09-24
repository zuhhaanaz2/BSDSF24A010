CC = gcc
CFLAGS = -Wall -Iinclude
PICFLAGS = -Wall -Iinclude -fPIC
STATIC_LIBFLAGS = -Llib -lmyutils
DYNAMIC_LIBFLAGS = -Llib -lmyutils

STATIC_TARGET = bin/client_static
DYNAMIC_TARGET = bin/client_dynamic
STATIC_LIB = lib/libmyutils.a
DYNAMIC_LIB = lib/libmyutils.so

all: $(STATIC_TARGET) $(DYNAMIC_TARGET)

$(STATIC_TARGET): obj/main.o $(STATIC_LIB)
	$(CC) obj/main.o -o $(STATIC_TARGET) $(STATIC_LIBFLAGS)

$(DYNAMIC_TARGET): obj/main.o $(DYNAMIC_LIB)
	$(CC) obj/main.o -o $(DYNAMIC_TARGET) -Llib -lmyutils

$(STATIC_LIB): obj/mystrfunctions.o obj/myfilefunctions.o
	ar rcs $(STATIC_LIB) obj/mystrfunctions.o obj/myfilefunctions.o

$(DYNAMIC_LIB): obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o
	$(CC) --shared -o $(DYNAMIC_LIB) obj/mystrfunctions_pic.o obj/myfilefunctions_pic.o

obj/main.o: src/main.c
	$(CC) $(CFLAGS) -c src/main.c -o obj/main.o

obj/mystrfunctions.o: src/mystrfunctions.c
	$(CC) $(CFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	$(CC) $(CFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions.o

obj/mystrfunctions_pic.o: src/mystrfunctions.c
	$(CC) $(PICFLAGS) -c src/mystrfunctions.c -o obj/mystrfunctions_pic.o

obj/myfilefunctions_pic.o: src/myfilefunctions.c
	$(CC) $(PICFLAGS) -c src/myfilefunctions.c -o obj/myfilefunctions_pic.o

clean:
	rm -f obj/*.o bin/client_static bin/client_dynamic lib/*.a lib/*.so
