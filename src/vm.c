#include "disassemble.h"
#include "eva.h"
#include <stdio.h>

int main() {
	opcode_t op;
	FILE *f = fopen("code.eva", "wb");

	printf("Create machine code:\n");
	printf("ADD\tR0, 4\n");
	op.instruction = 1;
	op.reinit = 0;
	op.flag = 0;
	op.offset = 0;
	op.operands = 0x00004;
	fwrite(&op, sizeof(opcode_t), 1, f);

	printf("ADD\tR1, 8\n");
	op.operands = 0x10008;
	fwrite(&op, sizeof(opcode_t), 1, f);

	printf("ADD\tR0, R1\n");
	op.instruction = 0;
	op.operands = 0x01000;
	fwrite(&op, sizeof(opcode_t), 1, f);

	printf("PUSH\tR0\n");
	op.instruction = 0b10;
	op.operands = 0x00000;
	fwrite(&op, sizeof(opcode_t), 1, f);

	fclose(f);
	f = fopen("code.eva", "rb");

	printf("======= Reading from file:\n");

	while (fread(&op, sizeof(opcode_t), 1, f)) {
		/* printf("========\n");
		printf("Instruction: %d\n", op.instruction);
		printf("Reset: %d, flag: %d\n", op.reinit, op.flag);
		printf("Offset: %d\n", op.offset);
		printf("Operand 1: %d, Operand 2: %d\n", op.operands >> 16,
		           op.operands & 0xFFFF);
		printf("==== Disassembly:\n"); */
		disassemble(op);
	}

	fclose(f);
	return 0;
}
