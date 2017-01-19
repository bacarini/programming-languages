fun same_string(s1 : string, s2 : string) =
    s1 = s2

fun all_except_option(str, list_str) =
  let fun remove_str ([]) = []
	| remove_str (x::xs') = if same_string(x, str)
				then xs'
				else x :: remove_str(xs')
      val list_filtered = remove_str(list_str)
  in
      if list_str = list_filtered
      then NONE
      else SOME list_filtered
  end

fun get_substitutions1 ([], str) = []
  | get_substitutions1 (x::xs', str) = let val opt = all_except_option(str, x)
				       in case opt of
					      NONE => get_substitutions1(xs', str)
					    | SOME value => value @ get_substitutions1(xs', str) 
				       end

fun get_substitutions2 (list_str, str) =
  let fun helper ([], acc) = acc
	| helper (x::xs', acc) = let val opt = all_except_option(str,x)
				 in case opt of
					NONE => helper(xs', acc)
				      | SOME value => helper(xs', acc @ value)
				 end
  in
      helper(list_str, [])
  end

fun similar_names (list_strs, { first = first_name, middle = middle_name, last = last_name}) =
  let val list_similar = first_name :: get_substitutions2(list_strs, first_name)
      fun helper ([]) = []
	| helper (x::xs') = { first = x, middle = middle_name, last = last_name } :: helper(xs')	
  in
      helper(list_similar)
  end

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

fun card_color (Clubs, _) = Black
  | card_color (Spades, _) = Black
  | card_color (_, _) = Red

fun card_value (_, Ace) = 11
  | card_value (_, Num n) = n
  | card_value (_, _) = 10 

fun remove_card (cards, card, ex) =
  let fun helper([]) = []
	| helper(c::cs') = if c = card
			   then cs'
			   else c :: helper(cs')
      val new_list = helper(cards)
  in
      if new_list = cards
      then raise ex
      else new_list
  end    

fun all_same_color ([]) = true
  | all_same_color (_::[]) = true 
  | all_same_color (head::(neck::rest)) = (card_color(head) = card_color(neck) andalso all_same_color(neck::rest))

fun sum_cards (cards) =
  let fun helper ([], acc) = acc
	| helper (c::cs', acc) = helper(cs', card_value(c)+acc)
  in
      helper(cards, 0)
  end

fun score (cards, goal) =
  let val sum = sum_cards(cards)
      val preliminary = if sum > goal then (sum - goal) * 3 else (goal - sum)
  in
      if all_same_color(cards)
      then preliminary div 2
      else preliminary
  end

fun officiate (cards, moves, goal) =
  let fun play(cards, moves, held_cards) =
	case moves of
	    [] => score(held_cards, goal)
	  | m::ms' => case m of
			  Discard card => play(cards, ms', remove_card(held_cards, card, IllegalMove))
			| Draw => case cards of
				      [] => score(held_cards, goal)
				    | c::cs' => if  sum_cards(c::held_cards) > goal
						then score(c::held_cards, goal)
						else play(cs', ms', c::held_cards) 
  in
      play(cards, moves, [])
  end
