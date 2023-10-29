(* Dekang Cao *)

structure SortedDictionary = DictionaryFn(struct
    type ''k compare_function = (''k*''k) -> order
    
    (* TODO: replace unit with the type you decide upon *)
    type (''k,'v) dictionary = {bst: ((''k * (''k * 'v) list), ''k) BinarySearchTree.tree}
    

    type ''k create_parameter_type = ''k compare_function

    fun create(cmp : ''k compare_function) : (''k,'v) dictionary = 
     {    bst = BinarySearchTree.create_empty(cmp, #1)}
    fun get(dict : (''k,'v) dictionary, key:''k) : 'v option =
    let
        val {bst, ...} = dict
        fun helper([], _) = NONE
          | helper((k, v)::kvs, key) = 
                if k = key 
                then 
                SOME v
                else 
                helper(kvs, key)
    in
        case BinarySearchTree.find(bst, key) of
            NONE => NONE
            | SOME (_, li) => helper(li, key)
    end

    fun put(dict : (''k,'v) dictionary, key:''k, value:'v) : (''k,'v) dictionary * 'v option =
    let
        val {bst, ...} = dict
        fun helper([], _) = ([(key, value)], NONE)
          | helper((k, v)::kvs, key) = 
                if k = key then ((key, value)::kvs, SOME v)
                else 
                let 
                val (newli, oldValue) = helper(kvs, key) 
                in 
                ((k, v)::newli, oldValue) 
                end
        val kvList = case BinarySearchTree.find(bst, key) of
        SOME (_, li) => li
        | NONE => []
     val (newChain, oldValue) = helper(kvList, key)
        val (newBST, _) = BinarySearchTree.insert(bst, (key, newChain))
    in
        ({bst = newBST}, oldValue)
    end

    fun remove(dict : (''k,'v) dictionary, key : ''k) : (''k,'v) dictionary * 'v option =
    let
        val {bst, ...} = dict
        fun helper([], _) = ([], NONE)
          | helper((k, v)::kvs, key) = 
                if k = key then (kvs, SOME v)
                else 
                let 
                val (newli, oldValue) = helper(kvs, key)
                in 
                ((k, v)::newli, oldValue) 
                end
        val kvList = case BinarySearchTree.find(bst, key) of
        SOME (_, li) => li
        | NONE => []
        val (newChain, oldValue) = helper(kvList, key)

        val newBST = if null newChain
        then let val (remove, _) = 
        BinarySearchTree.remove(bst, key)
        in remove 
        end
        else 
        let 
        val (update, _) = BinarySearchTree.insert(bst, (key, newChain))
        in 
        update
        end
    in
        ({bst = newBST}, oldValue)
    end

    fun entries(dict : (''k,'v) dictionary) : (''k*'v) list = 
    let
        val {bst, ...} = dict
        fun helper([], acc) = acc
          | helper((k, kvList)::r, acc) = helper(r, List.foldl (fn (kv, a) => kv::a) acc kvList)
        val all = BinarySearchTree.fold_lnr (fn ((k, kvList), acc) => (k, kvList)::acc, [], bst)
    in
    
        helper(all, [])
    end

end)
