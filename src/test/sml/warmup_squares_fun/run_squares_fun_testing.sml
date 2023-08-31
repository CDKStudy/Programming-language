CM.make "squares_fun_testing.cm";

val _ = ( SquaresFunTesting.test_to_squares()
        ; OS.Process.exit(OS.Process.success)
        )
