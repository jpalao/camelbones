#if defined(__cplusplus) && !defined(PERL_OBJECT)
#define is_cplusplus
#endif

#ifdef is_cplusplus
extern "C" {
#endif

#include "EXTERN.h"
#ifndef PERL_LEOPARD
#undef bool
#endif
#include "perl.h"
#ifdef PERL_OBJECT
#define NO_XSLOCKS
#include "XSUB.h"
#include "win32iop.h"
#include <fcntl.h>
#include "perlhost.h"
#endif
#ifdef is_cplusplus
}
#  ifndef EXTERN_C
#    define EXTERN_C extern "C"
#  endif
#else
#  ifndef EXTERN_C
#    define EXTERN_C extern
#  endif
#endif

