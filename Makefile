all: deps

deps:
	@echo getting latest monarch sources...
	@git clone git@github.com:project8/monarch.git

pymonarch:
	swig -python -Imonarch monarch.i
	gcc -fpic -c monarch_wrap.c monarch/monarch.c -I/System/Library/Frameworks/Python.framework/Versions/2.7/include/python2.7 -Imonarch
	gcc -shared -o _monarch.so monarch.o monarch_wrap.o -lmxml -lpython2.7

Rmonarch:
	swig -r -Imonarch monarch.i
	gcc -shared -o libmonarch.so monarch/monarch.o -lmxml
#	gcc -fpic -I/Users/mcbrie2/Downloads/R-2.13.1/include  -I/usr/local/include -Imonarch -include stdlib.h -c monarch_wrap.c -o monarch_wrap.o
#	gcc -shared -Imonarch -lmxml -o _monarch.so monarch_wrap.o

	MAKEFLAGS='CFLAGS=-Imonarch\ -include\ stdlib.h' PKG_LIBS="monarch/monarch.c" R CMD SHLIB monarch_wrap.c -lmxml -lmonarch -L.