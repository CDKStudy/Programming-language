structure Chain : CHAIN = struct
    

    fun get(chain : (''k*'v) list, key:''k) : 'v option =
    let
        fun helper (k, v) = if k = key then SOME v else NONE
    in
        List.foldl (fn (kv, acc) => 
        case helper kv of
            SOME x => SOME x
            | NONE => acc) NONE chain
    end

    fun put(chain : (''k*'v) list, key:''k, value:'v) : (''k*'v) list * 'v option =
    let
        fun update ((k, v) : (''k * 'v)) =
            if k = key then (key, value) else (k, v)

        val (found, updated_chain) = List.partition (fn (k, _) => k = key) chain
        val newc = case found of
            [] => (key, value) :: updated_chain
          | (_, old_value) :: _ => (key, value) :: List.map update updated_chain
    in
        (newc, case found of [] => NONE | (_, old_value) :: _ => SOME old_value)
    end

    fun remove(chain : (''k*'v) list, key : ''k) : (''k*'v) list * 'v option =
    let
        fun removeKey (k, _) = k = key
        val (found, updated_chain) = List.partition removeKey chain
    in
        (updated_chain, case found of [] => NONE | (_, old_value) :: _ => SOME old_value)
    end
end