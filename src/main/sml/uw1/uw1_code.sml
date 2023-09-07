(*1*)
fun is_older(date1 : int * int * int, date2 : int * int * int) =
if (#1 date1) < (#1 date2)
  then true
  else
   if (#1 date1) = (#1 date2)
   then 
    if (#2 date1) < (#2 date2)
      then true
      else
      if (#2 date1) = (#2 date2)
      then
       if(#3 date1) < (#3 date2)
       then true
       else false
    else false
else false

(*2*)
fun number_in_month(date : (int * int * int) list, month : int) = 
if null date
then 0
else
    if #2 (hd date) = month
    then number_in_month(tl date,month) + 1
    else  number_in_month(tl date,month)

(*3*)
fun number_in_months(date : (int * int * int) list, month : int list) =
if null date
then 0
else 
   if null month
   then 0
   else
       number_in_month(date, (hd month)) + number_in_months(date, (tl month))

(*4*)
fun dates_in_month(date : (int * int * int) list, month : int) = 
if null date
then []
else
    if #2 (hd date) = month
    then hd date :: dates_in_month(tl date,month)
    else  dates_in_month(tl date,month)

(*5*)
fun dates_in_months(date : (int * int * int) list, month : int list) =
if null date
then []
else 
   if null month
   then []
   else
       dates_in_month(date, (hd month))@dates_in_months(date, (tl month))

(*6*)
fun get_nth(strings: string list, n: int) = 
if null strings
then ""
else
  if n = 1
    then (hd strings)
    else get_nth((tl strings), n - 1)

(*7*)
fun date_to_string(date: int*int*int) = 
let
val months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
in
get_nth(months, (#2 date)) ^ " " ^ Int.toString((#3 date)) ^ ", " ^ Int.toString((#1 date))
end

(*8*)
fun number_before_reaching_sum(sum: int, list: int list) = 
let
  fun getsum(s : int, arr : int list, count : int) =
  let
  val s1 = s + hd arr
  val count1 = count + 1
  in
  if s1 >= sum
  then count1 - 1
  else
  getsum(s1,(tl arr),count1)
  end
in
if null list
then 0
else
   if (hd list) >= sum
   then 0
   else
      getsum(0,list,0)
end

(*9*)
fun what_month(day) = 
let
    val every = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
in
    number_before_reaching_sum(day, every) + 1
end
(*10*)

fun month_range(day1: int, day2: int) = 
if day1 > day2
then []
else
    what_month(day1)::month_range(day1 + 1, day2)

(*11*)

fun oldest(dates: (int*int*int) list) =
  let
  fun compare(date1: int*int*int, date2 : (int*int*int) list) =
    if null date2
    then date1
    else
      if is_older(date1, hd date2)
      then compare(date1, tl date2)
      else compare(hd date2, tl date2)
  in
     if null dates
     then NONE
     else
        (* if null (tl dates)
        then SOME(hd dates)
        else *)
        SOME (compare(hd dates, tl dates))
  end

(*12*)

(*13*)