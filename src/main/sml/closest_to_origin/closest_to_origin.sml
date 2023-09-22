structure ClosestToOrigin = struct

    (* Dekang Cao *)
    fun closest_to_origin(xys : (real*real) list) : (real*real) option =
    let
    fun distance((x, y) : real * real) = Math.sqrt(x * x + y * y)
    fun helper([],NONE) = NONE
      | helper([],SOME(x,y)) = SOME(x,y)
      | helper((x, y):: tail , NONE) = helper(tail, SOME(x, y))
      | helper((x, y) :: tail, SOME(x2, y2)) =
        if distance(x, y) < distance(x2, y2)
        then
        helper(tail, SOME(x, y))
        else
        helper(tail, SOME(x2, y2))      
    in
        helper(xys,NONE)
    end

end
