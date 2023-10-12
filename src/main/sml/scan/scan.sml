structure ScanHof = struct
	(* Dekang Cao *)
    fun scan operation values =
    let
        fun helper [] _ = []
          | helper (x::x') pre =
            let
                val result = operation (x, pre)
            in
                result :: helper x' result
            end
    in
        case values of
            [] => []
          | x::x' => x :: helper x' x
    end;
end
