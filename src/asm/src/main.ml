(* small test *)

let _ =
  let l = ref [] in
  
  while true do
    try
      l := !l @ [ Parser.instruction (Lexing.from_channel stdin) ]
    with 
      | Parser.Eof     -> List.iter Instructions_processing.to_bin !l; exit 0
      | Parser.Error e -> print_endline e
  done;

  


