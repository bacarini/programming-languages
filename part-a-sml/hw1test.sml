(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

val test11 = is_older ((1,2,3),(2,3,4)) = true
val test12 = is_older ((2008,10,11),(2008,10,11)) = false (* equal *)
val test13 = is_older ((2008,10,11),(2008,11,11)) = true (* month *)
val test14 = is_older ((2008,10,09),(2008,10,11)) = true (* day *)
val test15 = is_older ((2001,10,11),(2008,10,11)) = true (* year *)
val test16 = is_older ((2009,10,11),(2008,12,14)) = false (* year with date bigger *)
val test17 = is_older ((2008,12,30),(2008,11,20)) = false (* month bigger *)
							
val test2 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
								
val test31 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3

											       
val test41 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test42 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28), (2013,2,1)]
val test43 = dates_in_month ([(2012,2,28),(2013,12,1)],3) = []
	       
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test81 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test82 = number_before_reaching_sum (3, [1,2,3,4]) = 1

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)

				
val test12 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,2,2]) = 1
