fun is_older (d1 : int*int*int, d2 : int*int*int) =
  ((#1 d1 < #1 d2) orelse
   ((#1 d1 = #1 d2) andalso (#2 d1 < #2 d2)) orelse
   ((#1 d1 = #1 d2) andalso (#2 d1 = #2 d2) andalso (#3 d1 < #3 d2)))

fun number_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then 0
  else
      let val num = number_in_month (tl dates, month)
      in
	  if (#2 (hd dates)) = month
	  then 1 + num
	  else num
      end

fun number_in_months (dates : (int*int*int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then []
  else
      let val current_dates = dates_in_month(tl dates, month)
      in
	  if (#2 (hd dates)) = month
	  then (hd dates) :: current_dates
	  else current_dates
      end

fun dates_in_months (dates : (int*int*int) list, months : int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (list_string : string list, number : int) =
  if number = 1
  then hd list_string
  else get_nth(tl list_string, number - 1)

fun date_to_string (date : (int*int*int)) =
  let val months = ["January", "February", "March", "Apri", "May", "June", "July", "August", "September", "October", "November", "December"]
  in
      get_nth(months, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end

fun number_before_reaching_sum (sum : int, numbers : int list) =
  if (hd numbers) >= sum
  then 0
  else 1 + number_before_reaching_sum(sum - (hd numbers), (tl numbers))
		  
fun what_month (day : int) =
  let val months = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in number_before_reaching_sum(day, months) + 1
  end

fun month_range (day1 : int, day2 :int) =
  if day1 > day2
  then []
  else what_month(day1) :: month_range(day1 + 1, day2)

fun oldest (dates : (int*int*int) list) =
  if null dates
  then NONE
  else
      let fun oldest_fun (dates : (int*int*int) list) =
	    if null (tl dates)
	    then (hd dates)
	    else
		let val date = oldest_fun (tl dates)
		in
		    if is_older(hd dates, date)
		    then hd dates
		    else date
		end
      in
	  SOME (oldest_fun(dates))
      end

fun contains (_, []) = false
  | contains (target, n::ns') = if target = n then true else contains(target, ns') 
  
fun remove_duplicate ([]) = []
  | remove_duplicate (n::[]) = [n] 
  | remove_duplicate (numbers) = let fun helper ([], acc) = acc
				       | helper (n::ns', acc) = if contains(n, acc)
								then helper(ns', acc)
								else helper(ns', acc @ [n])
				 in
				     helper(numbers, [])
				 end

fun number_in_months_challenge (dates: (int*int*int) list, months: int list) =
    number_in_months(dates, remove_duplicate(months))

fun dates_in_months_challenge (dates: (int*int*int) list, months: int list) =
    dates_in_months(dates, remove_duplicate(months))

fun is_valid_day (year, month, day) =
  let val leapyear = (year mod 400 = 0 orelse year mod 4 = 0 andalso not (year mod 100 = 0))
  in 
      let val months = [31, (if leapyear then 29 else 28), 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
      in
	  let val days = List.nth(months, month - 1) in day > 0 andalso day <= days end
      end
  end

fun reasonable_date (date : int*int*int) =
  ((#1 date > 0) andalso
  (#2 date > 0 andalso #2 date <= 12) andalso
  (is_valid_day(#1 date, #2 date, #3 date)))
