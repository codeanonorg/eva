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

  | ADD_R_C (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c

  | ADDC_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0000
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | ADDC_R_C (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c

  | MOV_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0000
    and reset_code  = 0b0
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | MOV_R_C   (`Reg r1, `Cst c) ->
    let instr_code  = 0b0001
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c
  
  | PUSH_R (`Reg r1) ->
    let instr_code  = 0b0010
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 0

  | POP_R  (`Reg r1) ->
    let instr_code  = 0b0010
    and reset_code  = 0b1
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 0

  | LDR_R_AR  (`Reg r1, `Reg r2) ->
    let instr_code  = 0b0100
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | LDR_R_AC  (`Reg r1, `Adr c) ->
    let instr_code  = 0b0101
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c

  | STR_R_AR  (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1000
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | STR_R_AC  (`Reg r1, `Adr c) ->
    let instr_code  = 0b1001
    and reset_code  = 0b0
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c

  | CMP_R_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1100
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | CMP_R_C (`Reg r1, `Cst c) ->
    let instr_code  = 0b1100
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b01
    in
    make_code_4_16 instr_code reset_code flag_code offset_code r1 c

  | BEQ_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1011
    and reset_code  = 0b1
    and flag_code   = 0b0
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2
 
  | BNEQ_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1011
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b00
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | BLT_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1011
    and reset_code  = 0b1
    and flag_code   = 0b0
    and offset_code = 0b01
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2

  | BLE_R (`Reg r1, `Reg r2) ->
    let instr_code  = 0b1011
    and reset_code  = 0b1
    and flag_code   = 0b1
    and offset_code = 0b01
    in
    make_code_4_4 instr_code reset_code flag_code offset_code r1 r2
  
  | _ -> failwith "Non compilable instruction"
