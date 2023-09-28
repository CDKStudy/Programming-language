(* Dennis Cosgrove *)
CM.make "concat_length_list_testing.cm";

val _ = 
    ( ConcatLengthListTesting.test_concat_length_list()
    ; OS.Process.exit(OS.Process.success)
    )
