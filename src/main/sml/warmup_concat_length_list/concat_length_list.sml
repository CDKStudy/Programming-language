structure ConcatLengthList = struct
	(* __STUDENT_NAME__ *)
	(* Dennis Cosgrove *)

	
	(* TODO: replace unit with the datatype/type synonym(s) you decide upon *)
	type 'a cllist = unit
	


	fun from_list(xs : 'a list) : 'a cllist = 
		raise Fail "NotYetImplemented"
	
	fun length(cll : 'a cllist) : int = 
		raise Fail "NotYetImplemented"

	fun cons(x : 'a, cll : 'a cllist) : 'a cllist =
		raise Fail "NotYetImplemented"

    fun concat(a_cll : 'a cllist, b_cll : 'a cllist) : 'a cllist=
		raise Fail "NotYetImplemented"

	fun foldl(f : ('a * 'b) -> 'b, init : 'b, cll : 'a cllist) : 'b = 
		raise Fail "NotYetImplemented"

    fun to_list(cll : 'a cllist) : 'a list =
		raise Fail "NotYetImplemented"
end