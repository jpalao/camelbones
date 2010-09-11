/*
 * Generated by dtrace(1M).
 */

#ifndef	_PLDTRACE_H
#define	_PLDTRACE_H

#include <unistd.h>

#ifdef	__cplusplus
extern "C" {
#endif

#define PERL_STABILITY "___dtrace_stability$perl$v1$4_4_5_4_4_5_4_4_5_4_4_5_4_4_5"

#define PERL_TYPEDEFS "___dtrace_typedefs$perl$v1"

#define	PERL_ENTRY(arg0, arg1, arg2) \
{ \
	__asm__ volatile(".reference " PERL_TYPEDEFS); \
	__dtrace_probe$perl$entry$v1$63686172202a$63686172202a$696e74(arg0, arg1, arg2); \
	__asm__ volatile(".reference " PERL_STABILITY); \
} 
#define	PERL_ENTRY_ENABLED() \
	__dtrace_isenabled$perl$entry$v1()
#define	PERL_EXIT(arg0, arg1, arg2) \
{ \
	__asm__ volatile(".reference " PERL_TYPEDEFS); \
	__dtrace_probe$perl$exit$v1$63686172202a$63686172202a$696e74(arg0, arg1, arg2); \
	__asm__ volatile(".reference " PERL_STABILITY); \
} 
#define	PERL_EXIT_ENABLED() \
	__dtrace_isenabled$perl$exit$v1()


extern void __dtrace_probe$perl$entry$v1$63686172202a$63686172202a$696e74(char *, char *, int);
extern int __dtrace_isenabled$perl$entry$v1(void);
extern void __dtrace_probe$perl$exit$v1$63686172202a$63686172202a$696e74(char *, char *, int);
extern int __dtrace_isenabled$perl$exit$v1(void);

#ifdef	__cplusplus
}
#endif

#endif	/* _PLDTRACE_H */
