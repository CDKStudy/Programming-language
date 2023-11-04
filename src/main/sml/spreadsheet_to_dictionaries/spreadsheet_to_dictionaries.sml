(* Dekang Cao *)
(* Dennis Cosgrove *)
structure SpreadsheetToDictionaries = struct
    open Spreadsheet
    open SingleChainedDictionary
    fun spreadsheet_to_dictionaries_using_headers_as_keys(s : sheet) : (cell,cell) SingleChainedDictionary.dictionary list =
        let
        val datas = tl s
        fun helper(row : cell list) : (cell, cell) dictionary =
        foldl (fn ((key, value), dict) =>  #1 (put(dict, key, value))) (create()) (ListPair.zip(hd s, row))
        in
        List.map helper datas
        end
end
