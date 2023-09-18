CM.make "squares_using_hof_testing.cm";

val _ = ( SquaresUsingHigherOrderFunctionsTesting.test_to_squares()
        ; OS.Process.exit(OS.Process.success)
        )
