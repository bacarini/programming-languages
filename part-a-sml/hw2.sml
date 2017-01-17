(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(str, list_str) =
  let fun remove_str(list_str) =
	case list_str of
	    [] => []
	  | x::xs' => if same_string(x, str)
		      then xs'
		      else x :: remove_str(xs')
      val list_filtered = remove_str(list_str)
  in
      if list_str = list_filtered
      then NONE
      else SOME list_filtered
  end

fun get_substitutions1 ([], str) = []
  | get_substitutions1 (list_str, str) = 
    case list_str of
	[] => []
      | x::xs' =>  let val opt = all_except_option(str, x)
		   in case opt of
			  NONE => get_substitutions1(xs', str)
			| SOME value => value @ get_substitutions1(xs', str) 
		   end

fun get_substitutions2 (list_str, str) =
  let fun helper (list_str, acc) =
	case list_str of
	    [] => acc
	  | x::xs' => let val opt = all_except_option(str,x)
		      in case opt of
			     NONE => helper(xs', acc)
			   | SOME value => helper(xs', acc @ value)
		      end
  in
      helper(list_str, [])
  end

fun similar_names (list_strs, { first = first_name, middle = middle_name, last = last_name}) =
  let val list_similar = first_name :: get_substitutions2(list_strs, first_name)
      fun helper (list_similar) =
	case list_similar of
	    [] => []
	  | x::xs' =>  { first = x, middle = middle_name, last = last_name } :: helper(xs')	
  in
      helper(list_similar)
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
