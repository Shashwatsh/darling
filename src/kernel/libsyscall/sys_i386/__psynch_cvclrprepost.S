#define __SYSCALL_32BIT_ARG_BYTES 28
#include "SYS.h"

#ifndef SYS_psynch_cvclrprepost
#error "SYS_psynch_cvclrprepost not defined. The header files libsyscall is building against do not match syscalls.master."
#endif

#if defined(__i386__)
__SYSCALL2(__psynch_cvclrprepost, psynch_cvclrprepost, 7, cerror_nocancel)
#endif

