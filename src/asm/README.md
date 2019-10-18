# Assembleur pour Eva

## Construction des Op-codes

|         | code instruction | reset | flag   | offset | opérandes |
|:------- | :--------------: | :---: | :----: | :----: | :-------- |
|         | 4 bits           | 1 bit | 1 bit  | 2 bits | 20 bits   |
| ADD   Rn Rm   | 0000 | 0 | 0 | .. | n[4 bits] m[4 bits]     |
| ADD   Rn Val  | 0001 | 0 | 0 | .. | n[4 bits] val[16 bits]  |
| ADDC  Rn Rm   | 0000 | 0 | 1 | .. | n[4 bits] m[4 bits]     |
| ADDC  Rn Val  | 0001 | 0 | 1 | .. | n[4 bits] val[16 bits]  |
| MOV   Rn Rm   | 0000 | 1 | 0 | .. | n[4 bits] m[4 bits]     |
| MOV   Rn Val  | 0001 | 1 | 0 | .. | n[4 bits] val[16 bits]  |

Les op-codes ont une taille fixée de 32 bits. Leur structure est toujours la même.

## Détail de la structure des opcodes


### Les 8 bits d'instruction

Les 8 premiers bits des op-codes permettent la distrinction entre les différentes instructions. Plus particulièrement :


+ Les 4 premiers bits sont déstinés au *code instruction*. C'est ce dernier qui permet de connaître la nature de l'instruction encodées. On constate que `ADD` et `MOV` ont le même code instruction. En effet ce sont des intructions de même nature, elles ont pour fonction de modifier le contenu d'un registre Rn avec une valeur ou le contenu d'un autre registre.

+ Le 5eme bit est un indicateur de réinitialisation. Les op-codes associés à des instructions d'initialisation de registre ont ce bit à 1 (instruction `MOV` par exemple).

+ Le 6eme bit est reservé aux op-codes d'instructions nécessitant l'usage d'un registre de *flag*. C'est le cas par exemple de l'addition avec retenue `ADDC`.

+ Le 7eme et 8 bit sont consacrés à l'*offset*. Les opérandes ne pouvant excéder 32 bits, ce décalage permet de préciser si l'opération courrante est à effectuer sur la partie haute ou la partie basse d'un registre (ou d'un emplacement mémoire).


| offset | écriture             |
| :----: | :------------------- |
| 00     | 16 premiers bits     |
| 01     | 16 derniers bits     |
| 10     | à partir du bit 0    |
| 10     | à partir du bit 16   |