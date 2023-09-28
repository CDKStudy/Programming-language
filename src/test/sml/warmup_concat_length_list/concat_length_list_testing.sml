structure ConcatLengthListTesting :> sig
    val test_concat_length_list : unit -> unit
end = struct

	datatype 'a concat_node = FROM of 'a list | CONCAT of ('a concat_node * 'a concat_node) | CONS of ('a  * 'a concat_node)

	fun concat_node_to_string (to_string, to_string_from_list) concat_node = 
		let
			fun prefix(true) = ""
			|   prefix(false) = "( "
			fun postfix(true) = ""
			|   postfix(false) = " )"
			fun helper(is_root, FROM(xs)) = "from_list(" ^ to_string_from_list(xs) ^ ")"
			|   helper(is_root, CONCAT(a, b)) = prefix(is_root) ^ helper(false, a) ^ " @ " ^ helper(false, b) ^ postfix(is_root)
			|   helper(is_root, CONS(head, tail)) = prefix(is_root) ^ to_string(head) ^ " :: " ^ helper(false, tail) ^ postfix(is_root)
		in
			helper(true, concat_node)
		end

	fun concat_node_to_cll(FROM(xs)) = ConcatLengthList.from_list(xs)
	|   concat_node_to_cll(CONCAT(a, b)) = ConcatLengthList.concat(concat_node_to_cll(a), concat_node_to_cll(b))
	|   concat_node_to_cll(CONS(head, tail)) = ConcatLengthList.cons(head, concat_node_to_cll(tail))

	fun all_lists(node) =
		let
			fun helper(init, FROM(xs)) = xs :: init
			|   helper(init, CONCAT(a, b)) = helper(helper(init, b), a)
			|   helper(init, CONS(head, tail)) = helper(init, CONCAT(FROM([head]), tail))
		in
			helper([], node)
		end
	

	fun concat_froms(xs, ys) = CONCAT(FROM(xs), FROM(ys))

	val int_test_cases = [
			FROM([]),
			FROM([425]),
			FROM([231, 425]),
			concat_froms([], []),
			concat_froms([425], []),
			concat_froms([], [231]),
			concat_froms([425], [231]),

			CONCAT(CONCAT(FROM([1,2,3]), FROM([4,5,6,7])), FROM([8,9,10,11,12])),
			CONS(1, FROM([])),
			CONS(425, CONCAT(CONCAT(FROM([1,2,3]), FROM([4,5,6,7])), FROM([8,9,10,11,12])))
	]

	val string_test_cases = [
			FROM(["a"]),
			FROM(["a", "b"]),
			FROM(["a", "b", "c"]),
			FROM(["a", "b", "c", "d"]),
			FROM(["a", "b", "c", "d", "e"]),
			FROM(["a", "b", "c", "d", "e", "f"]),
			FROM(["a", "b", "c", "d", "e", "f", "g"]),
			FROM(["a", "b", "c", "d", "e", "f", "g", "h"]),
			concat_froms(["a", "b"], []),
			concat_froms([], ["c", "d"]),
			concat_froms(["a", "b"], ["c", "d"])
	]

	fun each_test_case(to_string_functions, [], f) = ()
	|   each_test_case(to_string_functions, node::nodes', f) = ( f(node, to_string_functions) ; each_test_case(to_string_functions, nodes', f) )

	val int_to_string_functions = (IntTesting.toString, IntTesting.toStringFromList)
	fun each_int_test_case(f) = 
		each_test_case(int_to_string_functions, int_test_cases, f)
	val string_to_string_functions = (StringTesting.toString, StringTesting.toStringFromList)
	fun each_string_test_case(f) = 
		each_test_case(string_to_string_functions, string_test_cases, f)

	fun test_length() =
		let
			fun length_of_all_lists(node) =
				List.foldl (fn(x, acc)=>List.length(x)+acc) 0 (all_lists(node))
			fun assert_length(node, to_string_functions) =
				IntTesting.assertEvalEqualsWithMessage(
					length_of_all_lists(node), 
					fn()=> ConcatLengthList.length(concat_node_to_cll(node)), 
					"length( " ^ (concat_node_to_string to_string_functions node) ^ " )")
		in
			( UnitTesting.enter("length")
			; each_int_test_case(assert_length)
			; each_string_test_case(assert_length)
			; UnitTesting.leave() 
			)
		end

    fun test_foldl() =
        let
			fun sum_of_all_lists(node) =
				let
					val sum = List.foldl op+ 0
					
					fun helper(xs, acc) =
						acc + sum(xs)
				in 
					List.foldl helper 0 (all_lists(node))
				end
			fun assert_sum(node, to_string_functions) =
				IntTesting.assertEvalEqualsWithMessage(
					sum_of_all_lists(node), 
					fn()=> ConcatLengthList.foldl(op+, 0, concat_node_to_cll(node)), 
					"foldl( " ^ (concat_node_to_string to_string_functions node) ^ " )")

        in
			( UnitTesting.enter("foldl")
			; each_int_test_case(assert_sum)
			; UnitTesting.leave() 
			)
        end

    fun test_to_list() =
        let
			fun copy_of_all_lists(node) =
				let
					val copy = List.foldr op:: []
					
					fun helper(xs, acc) =
						acc @ copy(xs)
				in 
					List.foldl helper [] (all_lists(node))
				end
			fun assert_to_list assert_list_eval_equals (node, to_string_functions) =
				assert_list_eval_equals(
					copy_of_all_lists(node), 
					fn()=> ConcatLengthList.to_list(concat_node_to_cll(node)), 
					"to_list( " ^ (concat_node_to_string to_string_functions node) ^ " )")

			val assert_to_list_int = assert_to_list IntTesting.assertListEvalEqualsWithMessage
			val assert_to_list_string = assert_to_list StringTesting.assertListEvalEqualsWithMessage

        in
			( UnitTesting.enter("to_list")
			; each_int_test_case(assert_to_list_int)
			; each_string_test_case(assert_to_list_string)
			; UnitTesting.leave() 
			)
        end

    fun test_concat_length_list() =
		( ()
		; test_length()
		; test_foldl()
		; test_to_list()
		)
end
