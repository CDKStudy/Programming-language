structure Spreadsheet = struct
    (* Dekang Cao *)

    datatype cell = EMPTY | TEXT of string | INTEGER of int
    type sheet = cell list list

    fun create_sheet(word_lists : string list list) : sheet =
    let
        fun col(word: string) : cell =
            case word of
                "" => EMPTY
              | _ =>
                case Int.fromString(word) of
                    SOME n => INTEGER n
                  | NONE => TEXT word

        fun row(words: string list) : cell list =
            map col words
    in
        map row word_lists
    end
    fun row_count(s : sheet) : int =
        List.length s

    fun column_count(s : sheet) : int = 
    case s of
    [] => 0 
    | [] :: _ => 0 
    | (row :: _) => List.length row

    fun row_at(s : sheet, row_index : int) : cell list = 
     List.nth(s, row_index)

    fun cell_in_row_at_column_index( r : cell list, col_index : int) : cell = 
        List.nth(r, col_index)

    fun cell_at(s : sheet, row_index : int, col_index : int) : cell = 
        cell_in_row_at_column_index(row_at(s, row_index), col_index)

    fun column_at(s : sheet, col_index : int) : cell list =
        List.map (fn row => cell_in_row_at_column_index(row, col_index)) s

    fun sum_in_cell_list(cells : cell list) : int =
    List.foldl (fn (cell, sum) =>case cell of
    INTEGER n => n + sum
    | _ => sum
    ) 0 cells
    fun sum_in_row(s : sheet, row_index : int) : int =
        sum_in_cell_list(row_at(s, row_index))

    fun sum_in_column(s : sheet, column_index : int) : int =
        sum_in_cell_list(column_at(s, column_index))

    fun max_in_cell_list(cells : cell list) : int option =
    let
        fun helper(cell: cell) : int option =
            case cell of
                INTEGER n => SOME n
              | _ => NONE
        val integer_values = List.mapPartial helper cells
    in
        case List.foldl (fn (x, y) => if x > y then x else y) 0 integer_values of
            0 => NONE
          | maxInt => SOME maxInt
    end

    fun max_in_row(s : sheet, row_index : int) : int option =
        max_in_cell_list(row_at(s, row_index))

    fun max_in_column(s : sheet, column_index : int) : int option =
        max_in_cell_list(column_at(s, column_index))

    fun count_if_in_cell_list(cells : cell list, predicate : (cell -> bool)) : int = 
     let
    fun helper(cell, count) =
        if predicate(cell) then count + 1
        else count
    in
        List.foldl helper 0 cells
    end

    fun count_if_in_row(s : sheet, row_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(row_at(s, row_index), predicate)

    fun count_if_in_column(s : sheet, col_index : int, predicate : (cell -> bool)) : int = 
        count_if_in_cell_list(column_at(s, col_index), predicate)
end
