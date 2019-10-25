(* small test *)

let _ =
  let l = ref [] in
  
  while true do
    try
      l := !l @ [ Lexer.instruction (Lexing.from_channel stdin) ]
    with 
      | Lexer.Eof     -> List.iter Instructions.pprint !l; exit 0
      | Lexer.Error e -> print_endline e
  done;

  


