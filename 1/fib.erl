%fibonacci

-module(fib).
-export([fib_g /1, fib_p/1, fib_rec/3]).

% recursive fib with compare
fib_p(0) -> 
	0;
fib_p(1) -> 
	1;
fib_p(X) -> 
	 (X >= 2), fib_p(X-1) + fib_p(X-2).


% using guard
fib_g (X) when X == 0 -> 
	0;
fib_g (X) when X =< 2 ->
    1;
fib_g (X) when X > 2 ->
    fib_g (X-1) + fib_g (X-2).

% tail recursive
fib_rec (1, _, Res) -> Res;

fib_rec (X, Prev, Res) when X > 1 -> 
    fib_rec(X - 1, Res, Res + Prev).