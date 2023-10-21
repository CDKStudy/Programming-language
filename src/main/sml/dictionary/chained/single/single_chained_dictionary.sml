(* Dekang Cao *)

structure SingleChainedDictionary = DictionaryFn(struct
    
    (* TODO: replace unit with the type you decide upon *)
    type (''k,'v) dictionary = (''k * 'v) list
    

    type ''k create_parameter_type = unit
    
    fun create() : (''k,'v) dictionary = []

    fun get(dict : (''k,'v) dictionary, key : ''k) : 'v option = 
    Chain.get(dict, key)

    fun put(dict : (''k,'v) dictionary, key : ''k , value : 'v) : (''k,'v) dictionary * 'v option =
    let
        val (new_chain, old_value) = Chain.put(dict, key, value) 
    in
        (new_chain, old_value)
    end
	
    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
    let
        val (new_chain, old_value) = Chain.remove(dict, key)
    in
        (new_chain, old_value)
    end

    fun entries(dict : (''k,'v) dictionary) : (''k*'v) list =
        dict
end)
