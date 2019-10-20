#include "disassemble.h"
#include "eva.h"
#include <stdio.h>

int main() {
	opcode_t op;
	FILE *in;
	FILE *out = fopen("code.eva", "w");

	printf("Create machine code:\n");
	printf("ADD R0 4\n");
	op.instruction = 1;
	op.reinit = 0;
	op.flag = 0;
	op.offset = 0;
	op.operands = 0x00004;
	fwrite(&op, sizeof(opcode_t), 1, out);

	printf("ADD R1 8\n");
	op.operands = 0x10008;
	fwrite(&op, sizeof(opcode_t), 1, out);

	printf("ADD R0 R1\n");
	op.instruction = 0;
	op.operands = 0x01000;
	fwrite(&op, sizeof(opcode_t), 1, out);

	printf("PUSH R0\n");
	op.instruction = 0b10;
	op.operands = 0x00000;
	fwrite(&op, sizeof(opcode_t), 1, out);

	fclose(out);

	printf("======= Reading from file:\n");

	in = fopen("code.eva", "r");
	while (fread(&op, sizeof(opcode_t), 1, in)) {
		/* printf("========\n");
		printf("Instruction: %d\n", op.instruction);
		printf("Reset: %d, flag: %d\n", op.reinit, op.flag);
		printf("Offset: %d\n", op.offset);
		printf("Operand 1: %d, Operand 2: %d\n", op.operands >> 16,
		           op.operands & 0xFFFF);
		printf("==== Disassembly:\n"); */
		disassemble(op, NULL, 0);
	}

	fclose(in);
	return 0;
}
