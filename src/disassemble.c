#include "disassemble.h"
#include <stdio.h>

void disassemble(opcode_t op) {
	switch (op.instruction) {
	case 0x0: {
		/* ADD,ADC, MOV between registers */
		unsigned short op1, op2;
		op1 = op.operands & 0xF0000 >> 16;
		op2 = op.operands & 0x0F000 >> 12;
		if (op.reinit)
			printf("MOV R%d R%d\n", op1, op2);
		else if (op.flag)
			printf("ADC R%d R%d\n", op1, op2);
		else
			printf("ADD R%d R%d\n", op1, op2);
		break;
	}
	case 0x1: {
		/* ADD, ADC, MOV with a register and a value */
		unsigned short op1;
		unsigned int op2;
		op1 = op.operands >> 16;
		op2 = op.operands & 0x0FFFF;
		if (op.reinit)
			printf("MOV R%d %04X\n", op1, op2);
		else if (op.flag)
			printf("ADC R%d %04X\n", op1, op2);
		else
			printf("ADD R%d %04X\n", op1, op2);
		break;
	}
	case 0x2: {
		/* PUSH or POP a register */
		unsigned short op1 = op.operands & 0xF0000 >> 16;
		if (op.flag)
			printf("POP R%d\n", op1);
		else
			printf("PUSH R%d\n", op1);
		break;
	}
	}
}
