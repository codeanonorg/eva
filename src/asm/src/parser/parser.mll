
{
  exception Eof
  exception Error of string
  open Instructions
  open Printf
  
  let get_reg s =
    String.sub s 1 ((String.length s)-1) |> int_of_string |> fun x -> `Reg x
  
  let get_cst s =
    String.sub s 1 ((String.length s)-1) |> int_of_string |> fun x -> `Cst x

  let get_adr s =
    String.sub s 1 ((String.length s)-1) |> int_of_string |> fun x -> `Adr x

  let incr_linenum lexbuf = 
    let pos = lexbuf.Lexing.lex_curr_p in
    lexbuf.lex_curr_p <- { pos with
      pos_lnum  = pos.pos_lnum + 1;
      pos_bol   = pos.pos_cnum;
    }

  let print_position lexbuf =
    let pos = lexbuf.Lexing.lex_curr_p in
    sprintf "%s:%d:%d" pos.pos_fname
      pos.pos_lnum (pos.pos_cnum - pos.pos_bol + 1)
}


let reg   = ('R' | 'r') ['0'-'9']+
let blank = (('\t')+ | (' ')+)
let cst   = '#' ['0'-'9']+
let label = ['a'-'z' 'A'-'Z' '_']+ ['0'-'9']* ['a'-'z' 'A'-'Z' '_']*


rule instruction = parse
  | '\n'
    { incr_linenum lexbuf; instruction lexbuf }

  | blank
    { instruction lexbuf }

  | (label as l) blank* ':'
    { LABEL (`Label l) }
  
  | "ADD" blank (reg as r1) ',' blank (reg as r2)
    { 
      ADD_R_R (get_reg r1, get_reg r2)
    }
  

  | "ADD" blank (reg as r1) ',' blank (cst as c)
    {
      ADD_R_C (get_reg r1, get_cst c)
    }


  | "ADDC" blank (reg as r1) ',' blank (reg as r2)
    {
      ADDC_R_R (get_reg r1, get_reg r2)
    }


  | "ADDC" blank (reg as r1) ',' blank (cst as c)
    { 
      ADDC_R_C (get_reg r1, get_cst c)
    }


  | "MOV" blank (reg as r1) ',' blank (reg as r2)
    { 
      MOV_R_R (get_reg r1, get_reg r2)
    }

  
  | "MOV" blank (reg as r1) ',' blank (cst as c)
    { 
      MOV_R_C (get_reg r1, get_cst c)
    }


  | "LDR" blank (reg as r1) ',' blank '[' (reg as r2) ']'
    { 
      LDR_R_AR (get_reg r1, get_reg r2)
    }

  
  | "LDR" blank (reg as r1) ',' blank (label as l)
    { 
      LDR_R_AL (get_reg r1, `Label l)
    }

  
  | "LDR" blank (reg as r1) ',' blank (cst as c)
    { 
      LDR_R_AC (get_reg r1, get_adr c)
    }

  
  | "STR" blank (reg as r1) ',' blank '[' (reg as r2) ']'
    { 
      STR_R_AR (get_reg r1, get_reg r2)
    }

  
  | "STR" blank (reg as r1) ',' blank (label as l)
    { 
      STR_R_AL (get_reg r1, `Label l)
    }

  
  | "STR" blank (reg as r1) ',' blank (cst as c)
    { 
      STR_R_AC (get_reg r1, get_adr c)
    }

  
  | "PUSH" blank (reg as r1)
    {
      PUSH_R (get_reg r1)
    }
  
  
  | "POP"  blank (reg as r1)
    {
      POP_R (get_reg r1)
    }


  | "CMP"  blank (reg as r1) ',' blank (reg as r2)
    {
      CMP_R_R (get_reg r1, get_reg r2)
    }


  | "CMP"  blank (reg as r1) ',' blank (cst as c)
    {
      CMP_R_C (get_reg r1, get_cst c)
    }

  | "BEQ"  blank (reg as r1)
    {
      BEQ_R (get_reg r1)
    }

  | "BNEQ"  blank (reg as r1)
    {
      BNEQ_R (get_reg r1)
    }

  | "BLT"  blank (reg as r1)
    {
      BLT_R (get_reg r1)
    }

  | "BLE"  blank (reg as r1)
    {
      BLE_R (get_reg r1)
    }

  | eof
    { raise Eof }
  | _ as t
    { raise ( Error ("Invalid token " ^ (String.make 1 t) ^ " " ^ (print_position lexbuf)) ) }

