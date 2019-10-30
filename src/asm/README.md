# Assembleur pour Eva

## Le langage Eva

La machine virtuelle eva (cf [description](../../README.md)) est fournie avec un langage d'assemblage permettant sa programmation. Ce document en propose une description synthétique. Une documentation complète du langage Eva est disponible à [cette adresse]().


### Aperçu de l'architecture Eva

Eva est une machine virtuelle à registres. Elle comporte précisément 16 registres de 32 bits chacuns dont les rôles sont donnés par la convention suivante :

+ R0 : général + _syscall_
+ R1 : _flags_
+ R2-11 : général
+ R12 : _frame pointer_   [fp]
+ R13 : _stack pointer_   [sp]
+ R14 : _link register_   [lp]
+ R15 : _program counter_ [pc]


En plus de ces registres, Eva dispose bien sûr d'une RAM de taille variable selon les besoins de l'utilisateur (par défaut 512 mo). Nottons qu'une partie de cette RAM est réservée pour servir de pile. La taille de la pile peut également varier selon les besoins de l'utilisateur.

Les programmes sont habituellement chargés en mémoire à l'adresse #0. Toutefois, dans le cas où il est explicitement demandé de charger les programmes utilitaires en mémoire (cf []()), les programmes sont alors chargés à l'adresse N?.


### Introduction

-> Tuto ?

### Sucres syntaxiques

-> Détails sur les variantes d'instructions

### Conseils pour l'optimisation des programmes

-> Détails sur la séparation des instructions en plusieurs Op-codes

## Construction des Op-codes

|                | code instruction | reset | flag  | offset | opérandes              |
| :------------- | :--------------: | :---: | :---: | :----: | :--------------------- |
|                |      4 bits      | 1 bit | 1 bit | 2 bits | 20 bits                |
| `ADD   Rn Rm`  |       0000       |   0   |   0   |   ..   | n[4 bits] m[4 bits]    |
| `ADD   Rn Val` |       0001       |   0   |   0   |   ..   | n[4 bits] val[16 bits] |
| `ADDC  Rn Rm`  |       0000       |   0   |   1   |   ..   | n[4 bits] m[4 bits]    |
| `ADDC  Rn Val` |       0001       |   0   |   1   |   ..   | n[4 bits] val[16 bits] |
| `MOV   Rn Rm`  |       0000       |   1   |   0   |   ..   | n[4 bits] m[4 bits]    |
| `MOV   Rn Val` |       0001       |   1   |   0   |   ..   | n[4 bits] val[16 bits] |
| `PUSH  Rn`     |       0010       |   0   |   0   |   00   | n[4 bits]              |
| `POP   Rn`     |       0010       |   1   |   0   |   00   | n[4 bits]              |
| `LDR   Rn [Rm]`|       0100       |   1   |   0   |   00   | n[4 bits] m[4 bits]    |
| `LDR   Rn Val` |       0101       |   1   |   0   |   00   | n[4 bits] val[16 bits] |
| `STR   Rn [Rm]`|       1000       |   1   |   0   |   00   | n[4 bits]              |
| `STR   Rn Val` |       1001       |   1   |   0   |   00   | n[4 bits] val[16 bits] |
| `CMP   Rn Rm`  |       1100       |   1   |   1   |   00   | n[4 bits] m[4 bits]    |
| `BEQ   Rn`     |       1011       |   1   |   0   |   00   | n[4 bits]              |
| `BNEQ  Rn`     |       1011       |   1   |   1   |   00   | n[4 bits]              |
| `BLT   Rn`     |       1011       |   1   |   1   |   01   | n[4 bits]              |
| `BLE   Rn`     |       1011       |   1   |   0   |   01   | n[4 bits]              |


Les op-codes ont une taille fixée de 32 bits. Leur structure est toujours la même.

## Détail de la structure des opcodes

### Les 8 bits d'instructions

Les 8 premiers bits des op-codes permettent la distrinction entre les différentes instructions. Plus particulièrement :


+ Les 4 premiers bits sont déstinés au *code instruction*. C'est ce dernier qui permet de connaître la nature de l'instruction encodées. On constate que `ADD` et `MOV` ont le même code instruction. En effet ce sont des intructions de même nature, elles ont pour fonction de modifier le contenu d'un registre Rn avec une valeur ou le contenu d'un autre registre.

+ Le 5eme bit est un indicateur de réinitialisation. Les op-codes associés à des instructions d'initialisation de registre ont ce bit à 1 (instruction `MOV` par exemple).

+ Le 6eme bit est reservé aux op-codes d'instructions nécessitant l'usage d'un registre de *flag*. C'est le cas par exemple de l'addition avec retenue `ADDC`.

+ Le 7eme et 8 bit sont consacrés à l'*offset*. Les opérandes ne pouvant excéder 32 bits, ce décalage permet de préciser si l'opération courrante est à effectuer sur la partie haute ou la partie basse d'un registre (ou d'un emplacement mémoire).


| offset | écriture à partir du |
| :----: | :------------------- |
|   00   | bit 0                |
|   01   | bit 4                |
|   10   | bit 8                |
|   11   | bit 12               |
