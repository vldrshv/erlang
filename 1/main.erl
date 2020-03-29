% Your program must have a 'main' function.

-module(main).
-export([main/1, main_m/1, main_s/1]).

-import(fib, [fib_g /1, fib_p/1, fib_rec/3]).
-import(mobius, [prime_factors/1, is_square_multiple/1]).

main(Num) -> io:format("fib_g = ~w~nfib_p = ~w~nfib_rec = ~w~n", [fib_g (Num), fib_p(Num), fib_rec(Num, 0, 1)]).

main_m(Num) -> 
	io:format("p_f = ~w~n", [prime_factors(Num)]).

main_s(Num) -> io:format("is_square_multiple = ~w~n", [is_square_multiple(Num)]).
