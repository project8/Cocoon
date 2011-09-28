%module monarch
%{
#include "monarch.h"
%}

%include "carrays.i"
%array_functions(unsigned char,char_p)

%include "monarch.h"

