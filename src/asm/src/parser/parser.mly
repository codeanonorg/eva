%{
  open Instructions
%}

%token<string>  SYMBOL
%token          OBRA
%token          CBRA
%token          COMMA
%token<string>  LABEL
%token<int>     REG
%token<int>     CST
%start          main
%type           <Instructions.t list> main
%%


main:
  | instr
    { [$1] }
  | instr main
    { [$1] @ $2 }
;

isntr:
  | SYMBOL REG REG
    { handle_Reg_Reg $1 $2 $3 }
  | SYMBOL REG SYMBOL
    { handle_Reg_Sym $1 $2 $3 }
  | SYMBOL REG CST
    { handlee_Reg_Cst $1 $2 $3}
  | SYMBOL REG OBRA CST CBRA
    { handle_Reg_Adr_at $1 $2 $3 }
  | SYMBOL REG
    { handle_Reg $1 $2 }
