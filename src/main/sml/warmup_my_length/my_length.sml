(* SML comes with a length function *)
(* http://sml-family.org/Basis/list.html#SIG:LIST.length:VAL *)
val length = "shadow built-in length function to prevent mistakenly calling it"

structure MyLength = struct
	(* Dekang Cao *)

	(* define a function my_length which returns the length of the specified list *)
	fun my_length(values) =
		raise Fail "NotYetImplemented"
end
