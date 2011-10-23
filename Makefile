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
	MAKEFLAGS="CFLAGS=-Imonarch\ -include\ stdlib.h" PKG_LIBS="monarch.c" R CMD SHLIB -Imonarch  monarch_wrap.c