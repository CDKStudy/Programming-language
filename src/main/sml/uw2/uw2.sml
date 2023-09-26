(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* Dekang Cao *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

val all_except_option = fn (str,list) =>
let 
fun helper (str,[]) = NONE
| helper (str,x::x') = 
case (same_string(str,x), helper(str, x'))
   of (true, _) => SOME(x')
   | (false, NONE) => NONE
   | (false, SOME(remain)) => SOME(x::remain)
in
helper(str,list)
end

val get_substitutions1 = fn (list,str) =>
let
fun helper([],str) = []
| helper(x::x',str) =
case all_except_option(str, x) of 
   SOME s  => s @ helper(x', str)
	|NONE => helper(x', str)
in
helper(list,str)
end
 

val get_substitutions2 = fn(list,str) =>
let
fun helper (cur, res) = 
case cur of
	[] => res
	| x :: x' => case all_except_option (str, x) of
   NONE => helper (x', res)
   |SOME(s) => helper (x', res @ s)
   in
	helper (list, [])
   end

val similar_names = fn(sub, {first = f, middle = m, last = l})=> 
let
fun helper(list,lists) = 
case list of 
[] => lists
|x :: x' => helper(x', {first = f, middle = m, last = l} :: lists)
in
helper(get_substitutions2 (sub, f),[{first = f, middle = m, last = l}])
end


(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

val card_color = fn(color) => 
case color
    of (Clubs, _) => Black
     | (Diamonds, _) => Red
     | (Hearts, _) => Red
     | (Spades, _) => Black


val card_value = fn(value) => 
case value of 
       (_, Num x) => x
     | (_, Jack) => 10
     | (_, Queen) => 10
     | (_, King) => 10
     | (_,Ace) => 11

val remove_card = fn (ls, l, e) =>
let
fun helper([], _, e) =
 raise e
 | helper(x::x', card, e) =
 case x = card
 of true => x'
 | false => x::helper(x', card, e)
in
helper(ls,l,e)
end


val all_same_color = fn (list) => 
let
fun helper([]) = true
 | helper(x::[]) = true
 | helper(x::x'::x'') = card_color(x) = card_color(x') andalso helper(x'::x'')
in
helper(list)
end

val sum_cards = fn(card) => 
let
fun helper([]) = 0
| helper(x::xs) = card_value(x) + helper(xs)
in
helper(card)
end

val score = fn(card, tar)=> 
let
   val sum = sum_cards(card)
   val c = if sum > tar 
   then 3 * (sum - tar) 
   else tar - sum
in
   if all_same_color(card) 
   then c div 2 
   else c
end

val officiate = fn (card,move,goal) => 
let
	fun helper(Cards, nextm, nextc) = 
	    if sum_cards Cards > goal
	    then score (Cards, goal)
	    else
		case nextm of
		    [] => score (Cards, goal)
		  | x :: x' => case x of
				   Discard i => helper (remove_card (Cards, i, IllegalMove), x', nextc)
				 | Draw => case nextc of 
					       [] => score (Cards, goal)
					     | y :: y' => helper(y :: Cards, x', y')
in
	helper ([], move, card)
end

val score_challenge = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function score_challenge."

val officiate_challenge = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function officiate_challenge."

val careful_player = fn _ => raise Fail "Not Yet Implemented.  Delete this line and implement function careful_player."

