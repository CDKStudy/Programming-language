(* Dennis Cosgrove *)
CM.make "../binary_search_tree/binary_search_tree.cm";

val bst = BinarySearchTree.create_empty(Int.compare, fn(v)=>v)
val (bst,_) = BinarySearchTree.insert(bst, 5)
val (bst,_) = BinarySearchTree.insert(bst, 6)
val (bst,_) = BinarySearchTree.insert(bst, 3)
val (bst,_) = BinarySearchTree.insert(bst, 1)
val (bst,_) = BinarySearchTree.insert(bst, 8)
val (bst,_) = BinarySearchTree.insert(bst, 7)
val (bst,_) = BinarySearchTree.insert(bst, 9)
val (bst,_) = BinarySearchTree.insert(bst, 4)
val (bst,_) = BinarySearchTree.insert(bst, 0)
val (bst,_) = BinarySearchTree.insert(bst, 2)
val (bst,_) = BinarySearchTree.remove(bst, 6)

val element_to_string = Int.toString
val key_to_string = Int.toString

val dot = BinarySearchTree.to_graphviz_dot(element_to_string, key_to_string, bst)
val _ = print(dot)

val ostream = TextIO.openOut "debug_bst_letters.dot"
val _ = TextIO.output (ostream, dot) handle e => (TextIO.closeOut ostream; raise e)
val _ = TextIO.closeOut ostream

val is_exit_desired = true
val _ = if is_exit_desired 
		then OS.Process.exit(OS.Process.success)
		else ()
