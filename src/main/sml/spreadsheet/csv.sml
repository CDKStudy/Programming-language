(* Dekang Cao *)
(* Dennis Cosgrove *)
structure Csv = struct
    fun is_new_line(c : char) : bool =
        c = #"\n"

    fun is_comma(c : char) : bool =
        c = #","

    fun read_csv(csv:string) : string list list =
    let
        val lines = String.fields is_new_line
        val fields = String.fields is_comma
    in
        List.map fields (lines csv)
    end
end