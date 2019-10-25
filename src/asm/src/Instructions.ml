

type oper = [
  | `Reg    of int
  | `Cst    of int
  | `Label  of string
  | `Adr    of int
]


type t =
  | LABEL     of [ `Label of string ]
  (* ADD Rn Rm *)
  | ADD_R_R   of [ `Reg of int ] * [ `Reg of int ]
  (* ADD Rn #? *)
  | ADD_R_C   of [ `Reg of int ] * [ `Cst of int ]
  (* ADDC Rn Rm *)
  | ADDC_R_R  of [ `Reg of int ] * [ `Reg of int ]
  (* ADDC Rn #? *)
  | ADDC_R_C  of [ `Reg of int ] * [ `Cst of int ]
  (* MOV R R *)
  | MOV_R_R   of [ `Reg of int ] * [ `Reg of int ]
  (* MOV R #? *)
  | MOV_R_C   of [ `Reg of int ] * [ `Cst of int ]
  (* LDR R [R] *)
  | LDR_R_AR  of [ `Reg of int ] * [ `Reg of int ]
  (* LDR R #? *)
  | LDR_R_AC  of [ `Reg of int ] * [ `Adr of int ]
  (* LDR R tag *)
  | LDR_R_AL  of [ `Reg of int ] * [ `Label of string ]
  (* STR R [R] *)
  | STR_R_AR  of [ `Reg of int ] * [ `Reg of int ]
  (* STR R #? *)
  | STR_R_AC  of [ `Reg of int ] * [ `Adr of int ]
  (* STR R tag *)
  | STR_R_AL  of [ `Reg of int ] * [ `Label of string ]
  (* PUSH R *)
  | PUSH_R    of [ `Reg of int ]
  (* POP R *)
  | POP_R     of [ `Reg of int ]


let pprint instr =
  match instr with
  | ADD_R_R   _ -> print_endline "ADD"
  | ADD_R_C   _ -> print_endline "ADD"
  | ADDC_R_R  _ -> print_endline "ADDC"
  | ADDC_R_C  _ -> print_endline "ADDC"
  | MOV_R_R   _ -> print_endline "MOV"
  | MOV_R_C   _ -> print_endline "MOV"
  | LDR_R_AR  _ -> print_endline "LDR"
  | LDR_R_AL  _ -> print_endline "LDR"
  | LDR_R_AC  _ -> print_endline "LDR"
  | STR_R_AR  _ -> print_endline "STR"
  | STR_R_AL  _ -> print_endline "STR"
  | STR_R_AC  _ -> print_endline "STR"
  | PUSH_R    _ -> print_endline "PUSH"
  | POP_R     _ -> print_endline "POP"
  | LABEL     _ -> print_endline "LABEL"