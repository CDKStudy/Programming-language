(* Dekang Cao *)

functor DictionaryFn(DictionaryParameter : DICTIONARY_FUNCTOR_PARAMETER) : DICTIONARY = struct

	open DictionaryParameter

    fun keys(dict : (''k,'v) dictionary) : ''k list = 
    List.map (fn (k, _) => k) (entries dict)

    fun values(dict : (''k,'v) dictionary) : 'v list = 
    List.map (fn (_, v) => v) (entries dict)
end
