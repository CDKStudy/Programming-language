(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

val only_capitals =
List.filter (fn x => Char.isUpper (String.sub (x, 0)))

val longest_string1 = 
List.foldl (fn(x,y) => if String.size x > String.size y then x else y) ""
val longest_string2 = 
List.foldl (fn(x,y) => if String.size x >= String.size y then x else y) ""
val longest_string_helper = fn f => fn func =>
List.foldl (fn(x,y) => if f(String.size x, String.size y) then x else y) "" func

val longest_string3 = 
longest_string_helper (fn(x,y) => x > y)

val longest_string4 = 
longest_string_helper (fn(x,y) => x >= y)
val longest_capitalized = 
longest_string1 o only_capitals

val rev_string =
String.implode o List.rev o String.explode 
fun first_answer f li =
case li of
[] => raise NoAnswer
| x::xs' => case f x of
NONE => first_answer f xs'
| SOME r => r

fun all_answers f li =
let
	fun helper (s, li) =
	case li of
	[] => SOME s
	|x::xs' => case f x of
	 SOME x => helper (x @ s, xs')
	|NONE => NONE					
	in
		helper([], li)
	end

val count_wildcards =
g (fn _ => 1) (fn x => 0)
val count_wild_and_variable_lengths = 
g (fn _ => 1) (fn x => String.size x)

fun count_some_var (s ,s2) =
g (fn x => 0) (fn x => if x = s then 1 else 0) s2

val check_pat = fn li =>
let
fun get_variables (Variable x) = [x]
    | get_variables (TupleP li2) = List.concat (map get_variables li2)
    | get_variables (ConstructorP (_, li)) = get_variables li
    | get_variables _ = []

fun has_duplicates [] = false
    | has_duplicates (x::xs) =
    List.exists (fn y => x = y) xs orelse has_duplicates xs
in
    not (has_duplicates (get_variables li))
end

fun match valptrn =
  let
    fun matchPairs ([], [], y) = SOME y
      | matchPairs (l :: li, x :: xs, y) =
          (case match (l, x) of
             SOME bindings => matchPairs (li, xs, y @ bindings)
           | NONE => NONE)
      | matchPairs _ = NONE
  in
    case valptrn of
      (_, Wildcard) => SOME []
    | (l, Variable s) => SOME [(s, l)]
    | (Unit, UnitP) => SOME []
    | (Const l, ConstP x') => if l = x' then SOME [] else NONE
    | (Tuple li, TupleP xs) =>
        if length li = length xs
        then matchPairs (li, xs, [])
        else NONE
    | (Constructor (s2, l), ConstructorP (s1, x)) =>
        if s1 = s2
        then match (l, x)
        else NONE
    | _ => NONE
  end

fun first_match s st =
SOME (first_answer (fn x => match(s, x)) st)
handle NoAnswer => NONE

val typecheck_patterns = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function typecheck_patterns."

(* Dekang Cao *)

