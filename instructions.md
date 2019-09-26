# jeu d'instruction minimal pour EVA

| Instruction |  |
| :------ | :----- |
| **ADD** | addition
| **ADC** | addition avec retenue |
| **BIC** | _Bit Clear_ |
| **CMP** | Comparaison | 
| **MOV** | _Registre <- valeur_ |
| **B** | _Branch/Jump_ |
| **BL** | _Branch and link_ |
| **PUSH** | empiler |
| **POP** | dépiler |
| **SUB** | soustraction |
| **SUBC** | soustraction avec retenue |

# paramètres par défaut

+ **mémoire**   : 512 mo
+ **opcodes**   : 32 bits
+ **registres** : 17
  + R0 : général + _syscall_
  + R1 - R11 : général
  + R12 : _frame pointer_ [fp]
  + R13 : _stack pointer_ [sp]
  + R14 : _link register_ [lp]
  + R15 : _program counter_ [pc]
  + R16 : _flags_

