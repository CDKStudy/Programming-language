signature TESTING_FN = sig
    val test_to_squares : unit -> unit
end

signature TESTING_PARAMETER = sig
    val function : int list -> int list
    val function_name : string
end

functor SquaresTestingFn (SquaresParameter : TESTING_PARAMETER) : TESTING_FN = struct
    open SquaresParameter

    fun test_to_squares() =
        let
            fun assert_to_squares(expected, xs) = 
                IntTesting.assertListEvalEqualsWithMessage(
                    expected, 
                    fn() => function(xs), 
                    function_name ^ "(" ^ IntTesting.toStringFromList(xs) ^ ")")
        in
            ( UnitTesting.enter(function_name)
                ; assert_to_squares([], [])
                ; assert_to_squares([0], [0])
                ; assert_to_squares([1], [1])
                ; assert_to_squares([4], [2])
                ; assert_to_squares([9], [3])
                ; assert_to_squares([16], [4])
                ; assert_to_squares([53361], [231])
                ; assert_to_squares([180625], [425])
                ; assert_to_squares([53361, 180625], [231, 425])
                ; assert_to_squares([100, 400], [10, 20])
                ; assert_to_squares([16, 4, 25], [4, 2, 5])
                ; assert_to_squares([1, 1, 4, 9, 25, 64], [1, 1, 2, 3, 5, 8])
            ; UnitTesting.leave() )
        end
end
