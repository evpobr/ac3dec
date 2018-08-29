dnl AC_CHECK_GENERATE_INTTYPES_H (INCLUDE-DIRECTORY)
dnl generate a default inttypes.h if the header file does not exist already
AC_DEFUN([AC_CHECK_GENERATE_INTTYPES],
    [rm -f $1/inttypes.h
    AC_CHECK_HEADER([inttypes.h],[],
	[AC_CHECK_SIZEOF([char])
	AC_CHECK_SIZEOF([short])
	AC_CHECK_SIZEOF([int])
	if test x"$ac_cv_sizeof_char" != x"1" -o \
	    x"$ac_cv_sizeof_short" != x"2" -o \
	    x"$ac_cv_sizeof_int" != x"4"; then
	    AC_MSG_ERROR([can not build a default inttypes.h])
	fi
	cat >$1/inttypes.h << EOF
/* default inttypes.h for people who do not have it on their system */

#ifndef _INTTYPES_H
#define _INTTYPES_H
#if (!defined __int8_t_defined) && (!defined __BIT_TYPES_DEFINED__)
#define __int8_t_defined
typedef signed char int8_t;
typedef signed short int16_t;
typedef signed int int32_t;
#ifdef ARCH_X86
typedef signed long long int64_t;
#endif
#endif
#if (!defined _LINUX_TYPES_H)
typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
#ifdef ARCH_X86
typedef unsigned long long uint64_t;
#endif
#endif
#endif
EOF
	])])
