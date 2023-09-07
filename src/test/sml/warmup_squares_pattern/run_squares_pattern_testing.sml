CM.make "squares_pattern_testing.cm";

val _ = ( SquaresPatternTesting.test_to_squares()
        ; OS.Process.exit(OS.Process.success)
        )
