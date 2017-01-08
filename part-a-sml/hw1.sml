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

      
      
