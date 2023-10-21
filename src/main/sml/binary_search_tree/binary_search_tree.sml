(* Dekang Cao *)
(* Dennis Cosgrove *)

structure BinarySearchTree :> BINARY_SEARCH_TREE = struct
	type 'k compare_function = (('k * 'k) -> order)
	type ('e,'k) to_key_function = 'e -> 'k

	
	(* TODO: replace unit with the datatype(s) and/or type synonym(s) you decide upon *)
	(* datatype ('e,'k) tree = 
	Empty
	| Node of ('e * ('e, 'k) tree * ('e, 'k) tree) *)
datatype ('e, 'k) node = 
        Leaf | 
        TreeNode of { 
            data: 'e, 
            key: 'k, 
            left: ('e, 'k) node, 
            right: ('e, 'k) node 
        }
	type ('e,'k) tree = {
        root: ('e, 'k) node,
        cmp: 'k compare_function,
        to_key: ('e,'k) to_key_function
    }
    
	fun create_empty(cmp : 'k compare_function, to_key : ('e,'k) to_key_function) : ('e,'k) tree = { root = Leaf, cmp = cmp, to_key = to_key }

	fun find(t : ('e,'k) tree, key : 'k) : 'e option = 
    let
        fun helper(Leaf, _) = NONE
          | helper(TreeNode{data, key = k, left, right}, cmp) =
            case cmp(key, k) of
                LESS => helper(left, cmp)
              | GREATER => helper(right, cmp)
              | EQUAL => SOME data
    in
        helper(#root t, #cmp t)
    end

	fun insert(t : ('e,'k) tree, element : 'e) : (('e,'k) tree * 'e option) =
    let
        fun helper(Leaf, _, to_key, data) =
            (TreeNode{data = data, key = to_key data, left = Leaf, right = Leaf}, NONE)
          | helper(TreeNode{data = node, key = nodeKey, left, right}, cmp, to_key, data) =
            case cmp(to_key data, nodeKey) of
                LESS =>
                    let
                        val (newLeft, replaced) = helper(left, cmp, to_key, data)
                    in
                        (TreeNode{data = node, key = nodeKey, left = newLeft, right = right}, replaced)
                    end
                | GREATER =>
                    let
                        val (newRight, replaced) = helper(right, cmp, to_key, data)
                    in
                        (TreeNode{data = node, key = nodeKey, left = left, right = newRight}, replaced)
                    end
                | EQUAL => (TreeNode{data = data, key = nodeKey, left = left, right = right}, SOME node)
    in
        let
            val (newRoot, replaced) = helper(#root t, #cmp t, #to_key t, element)
        in
            ({root = newRoot, cmp = #cmp t, to_key = #to_key t}, replaced)
        end
    end

	fun remove(t : ('e,'k) tree, key : 'k) : (('e,'k) tree * 'e option) =
    let
        fun findMin(TreeNode{data, left = Leaf, ...}) = data
           | findMin(TreeNode{left, ...}) = findMin(left)

        fun helper(node: ('e, 'k) node, key: 'k, cmp: 'k compare_function, to_key: ('e, 'k) to_key_function): ('e, 'k) node * 'e option =
            case node of
                Leaf => (Leaf, NONE)
              | TreeNode{data, key = k, left, right} =>
                case cmp(key, k) of
                    LESS =>
                        let
                            val (nLeft, optData) = helper(left, key, cmp, to_key)
                        in
                            (TreeNode{data=data, key=k, left=nLeft, right=right}, optData)
                        end

                    | GREATER =>
                        let
                            val (nRight, optData) = helper(right, key, cmp, to_key)
                        in
                            (TreeNode{data=data, key=k, left=left, right=nRight}, optData)
                        end

                    | EQUAL => 
                        case (left, right) of
                            (Leaf, Leaf) => (Leaf, SOME data)
                          | (_, Leaf) => (left, SOME data)
                          | (Leaf, _) => (right, SOME data)
                          | _ => 
                              let
                                  val succData = findMin(right)
                                  val (newTree, _) = helper(right, to_key(succData), cmp, to_key)
                              in
                                  (TreeNode{data=succData, key=to_key succData, left=left, right=newTree}, SOME data)
                              end

    in
        let
            val (nRoot, opt) = helper(#root t, key, #cmp t, #to_key t)
        in
            ({root = nRoot, cmp = #cmp t, to_key = #to_key t}, opt)
        end
    end


	(*
	 * depth-first, in-order traversal
	 * https://en.wikipedia.org/wiki/Tree_traversal#In-order_(LNR)
	 *)
	fun fold_lnr(f, init, t: ('e, 'k) tree) = 
    let
        fun traverse(Leaf, acc) = acc
          | traverse(TreeNode{data, left, right, ...}, acc) =
            let
                val acc1 = traverse(left, acc)
                val acc2 = f(data, acc1)
                val acc3 = traverse(right, acc2)
            in
                acc3
            end
    in
        traverse(#root t, init)
    end

	(*
	 * depth-first, reverse in-order traversal
	 * https://en.wikipedia.org/wiki/Tree_traversal#Reverse_in-order_(RNL)
	 *)
	fun fold_rnl(f, init, t: ('e, 'k) tree) = 
    let
        fun traverse(Leaf, acc) = acc
          | traverse(TreeNode{data, left, right, ...}, acc) =
            let
                val rightAcc = traverse(right, acc)
                val newDataAcc = f(data, rightAcc)
                val leftAcc = traverse(left, newDataAcc)
            in
                leftAcc
            end
    in
        traverse(#root t, init)
    end

	fun to_graphviz_dot(element_to_string, key_to_string, t) =
		let
			
			(* TODO: bind root *)
			val root = raise Fail("NotYetImplemented")
			(* TODO: bind to_key *)
			val to_key = raise Fail("NotYetImplemented")
			

			fun nodes_to_dot(bst) =
				let
					fun empty_to_string() =
						""
					fun present_to_string(left, element, right) =
						let
							fun node_to_dot(element) =
								"\t" ^ key_to_string(to_key(element)) ^ " [label= \"{ " ^ element_to_string(element) ^ " | { <child_left> | <child_right> } }\"]"
						in 
							node_to_dot(element) ^ "\n" ^ nodes_to_dot(left) ^ nodes_to_dot(right)
						end
				in
						raise Fail("NotYetImplemented")
				end

			fun edges_to_dot(bst, parent_element_opt, tag) =
				let
					fun empty_to_string() =
						""
					fun present_to_string(left, element, right) =
						let
							fun edge_to_dot(parent_element_opt, tag, element) = 
								case parent_element_opt of
								NONE => ""
								| SOME(parent_element) => "\t" ^ key_to_string(to_key(parent_element)) ^ tag ^ " -> " ^ key_to_string(to_key(element))
						in 
							edge_to_dot(parent_element_opt, tag, element) ^ "\n" ^ edges_to_dot(left, SOME(element), ":child_left:center") ^ edges_to_dot(right, SOME(element), ":child_right:center")
						end
				in
						raise Fail("NotYetImplemented")
				end
		in
			"digraph g {\n\n\tnode [\n\t\tshape = record\n\t]\n\n\tedge [\n\t\ttailclip=false,\n\t\tarrowhead=vee,\n\t\tarrowtail=dot,\n\t\tdir=both\n\t]\n\n" ^ nodes_to_dot(root) ^ edges_to_dot(root, NONE, "") ^ "\n}\n"
		end

end (* struct *) 
