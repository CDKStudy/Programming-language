(* Dennis Cosgrove *)
CM.make "bst_testing.cm";
CM.make "../command_line_args/command_line_args.cm";

val is_remove_testing_desired = CommandLineArgs.getBoolOrDefault("remove", true)
val _ = ( MacroBstTesting.test_bst(is_remove_testing_desired)
        ; OS.Process.exit(OS.Process.success)
        )
