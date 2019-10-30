

let write_to_file oc i =
  output_char oc (char_of_int ((i lsr 24) land 0xFF));
  output_char oc (char_of_int ((i lsr 16) land 0xFF));
  output_char oc (char_of_int ((i lsr 8)  land 0xFF));
  output_char oc (char_of_int (i land 0xFF))


(* test *)
let _ =
  let l = ref [] in
  let oc = open_out "test.evasm" in
  
  while true do
    try
      l := !l @ [ Parser.instruction (Lexing.from_channel stdin) ]
    with 
      | Parser.Eof     -> 
        List.iter (fun x -> Instructions_processing.to_bin x |> write_to_file oc) !l;
        exit 0
      | Parser.Error e -> print_endline e
  done



  


