(**
 * Instructions processing module
 *)

open Instructions


let make_code_4_4 i r f o a b =
  ((i land 0xF) lsl 28)
  lor ((r land 0b1) lsl 27)
  lor ((f land 0b1) lsl 26)
  lor ((o land 0b11) lsl 24)
  lor ((a land 0xF) lsl 16)
  lor ((b land 0xF) lsl 12)

let make_code_4_16 i r f o a b =
  ((i land 0xF) lsl 28)
  lor ((r land 0b1) lsl 27)
  lor ((f land 0b1) lsl 26)
  lor ((o land 0b11) lsl 24)
  lor ((a land 0xF) lsl 16)
  lor (b land 0xFFFF)


let debug opcode =
  Printf.printf "opcode : %#08x \n" opcode


let to_bin instr =
  match instr with
  | ADD_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0000
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2
    |> debug

  | ADD_R_C (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c
    |> debug

  | ADDC_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0000
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2
    |> debug

  | ADDC_R_C (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c
    |> debug


  | MOV_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0000
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2
    |> debug

  | MOV_R_C   (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c
    |> debug    

  | LDR_R_AR  _ -> print_endline "not yet impl"
  | LDR_R_AL  _ -> print_endline "not yet impl"
  | LDR_R_AC  _ -> print_endline "not yet impl"
  | STR_R_AR  _ -> print_endline "not yet impl"
  | STR_R_AL  _ -> print_endline "not yet impl"
  | STR_R_AC  _ -> print_endline "not yet impl"
  
  | PUSH_R (`Reg r1) ->
    let instr_code  = 0b0010
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 0
    |> debug

  | POP_R  (`Reg r1) ->
    let instr_code  = 0b0010
    and reset_code  = 0b1
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 0
    |> debug

  | LABEL     _ -> print_endline "LABEL"