structure Hearts = struct
  datatype suit = Clubs | Diamonds | Hearts | Spades
  datatype rank = Jack | Queen | King | Ace | Num of int 
  type card = suit * rank
  type player = card list

  (* Dekang Cao *)
  fun is_card_valid(c : card) : bool =
  case c of
  (suit,Num rank) => 
  if (rank >=2 andalso rank <= 10)
  then true
  else false
  |(suit) => true

  fun are_all_cards_valid(taken_cards : card list) : bool =
  case taken_cards of
  [] => true
  |(x::x') => is_card_valid(x) andalso are_all_cards_valid(x') 


  fun card_score(c : card) : int =
  case c of
  (Spades, Queen) => 13
  | (Hearts, _) => 1
  | (Diamonds, Jack) => ~10
  | _ => 0; 

  fun total_score_of_card_list(cards : card list) : int =
  case cards of
  [] => 0
  | card::card' => card_score(card) + total_score_of_card_list(card')

  fun total_score_of_player_list(players : player list) : int =
  case players of
  [] => 0
  | players::players' => total_score_of_card_list(players) + total_score_of_player_list(players')

  fun total_card_count_for_all_players(players : player list) : int =
  List.length (List.concat players)

  fun is_correct_total_of_cards(players : player list) : bool =
  	total_card_count_for_all_players(players) = 52

  fun is_shenanigans_detected(players : player list) =
  	total_score_of_player_list(players) <> 16

end
