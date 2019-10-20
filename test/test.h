#ifndef _H_TEST
#define _H_TEST
#include <stdio.h>

#define GREEN "\x1b[1;32m"
#define RED "\x1b[1;31m"
#define NOCOLOR "\x1b[0m"

#define INIT_TEST                                                              \
	int err = 0, test = 0;                                                     \
	int errs[1000]

#define END_TEST                                                               \
	if (err == 0)                                                              \
		printf(GREEN "OK" NOCOLOR "\n");                                       \
	else {                                                                     \
		printf(RED "FAILED:" NOCOLOR " %d failed tests of %d.\n\t", err,       \
		       test);                                                          \
		for (int i = 0; i < err; i++)                                          \
			printf("[%d] ", errs[i]);                                          \
		printf("\n");                                                          \
	}

#define TEST(c)                                                                \
	{                                                                          \
		test++;                                                                \
		printf("[%d] test %s:%d: %s\n", test, __FILE__, __LINE__, #c);         \
		if (!(c)) {                                                            \
			printf(RED "\tFAILED" NOCOLOR "\n");                               \
			errs[err] = test;                                                  \
			err++;                                                             \
		} else                                                                 \
			printf(GREEN "\tOK" NOCOLOR "\n");                                 \
	}

#endif
