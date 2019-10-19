#include <stdio.h>

typedef struct opcode_s {
	unsigned instruction:4;
	unsigned reinit:1;
	unsigned flag:1;
	unsigned offset:2;
	unsigned operands:20;
} opcode_t;

