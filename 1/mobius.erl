-module(mobius).
-export([is_square_multiple/1, find_square_multiplies/2, find_squares/5]).
-export([prime_dividers/1]).

% является ли число простым
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(3) -> true;
is_prime(Num) when Num > 3 -> 
	X = Num * Num - 1,
	X rem 24 == 0.
% -----------------------------------------------------------------------
% равен ли остаток от деления нулю
%
is_rem_null(N, D) when D =/= 0 -> N rem D == 0.
% -----------------------------------------------------------------------

% -----------------------------------------------------------------------
% можем ли находить простые множители
%
can_find_factor(N, Factor) -> 
	is_prime(Factor) and is_rem_null(N, Factor).
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% делится ли число на квадрат простого числа
%
is_square_multiple(N) -> 
	Primes = prime_dividers(N),
	io:format("~w,", [Primes]),
	io:format("~n~n"),
	is_divided_by_square(N, Primes).

is_divided_by_square(N, []) -> false;
is_divided_by_square(N, [H | Tail]) -> 
	case is_rem_null(N, H*H) of
		true -> true;
		false -> is_divided_by_square(N, Tail)
	end.
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% находим простые делители числа N
% -----------------------------------------------------------------------

prime_dividers(N) ->
    find_prime_dividers(N, N, 1, []).

find_prime_dividers(N, 0, _Factor, Res) -> lists:reverse(Res);
find_prime_dividers(X, N, Factor, Res) -> 
	case can_find_factor(X, Factor) of
		true -> find_prime_dividers(X, N - 1, Factor + 1, [Factor |Res]);
    	false -> find_prime_dividers(X, N - 1, Factor + 1, Res)
	end.
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% имеет ли число N делители в виде квадратов простых чисел
%
is_divided_by_prime_squares(N) -> 
	Primes = prime_dividers(N),
	is_divided_by_square(N, Primes).
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% ищем числа, которые делятся на квадрат простых чисел из диапазона
% [2, MaxN]
%
find_square_multiplies(Count, MaxN) ->
	find_squares(Count, MaxN, 0, -1, 2).
% -----------------------------------------------------------------------


% -----------------------------------------------------------------------
% находит предположительно начало подпоследовательности
% Count - длина подпоследовательности, 
% MaxN - правый край подпоследовательности, 
% SubSequenceLen - сколько чисел подряд(!!!) нашли, 
% LastN - первое число найденной подпоследовательности, 
% CurrentN - текущее число
%
find_squares(Count, MaxN, SubSequenceLen, LastN, CurrentN) when CurrentN > MaxN -> fail;
find_squares(Count, MaxN, SubSequenceLen, LastN, CurrentN) ->
	case is_divided_by_prime_squares(CurrentN) of
		true -> has_division_by_square(Count, MaxN, SubSequenceLen, LastN, CurrentN);
		false -> find_squares(Count, MaxN, 1, -1, CurrentN + 1)
	end.
% -----------------------------------------------------------------------
% обновляем число, которое стоит в начале подпоследовательности
% - если нашли требуемую длину, то отбой
% - иначе 
% 		записываем найденное число, если прошлое число было -1 
% 			(просто маркер, что мы еще ничего не нашли)
% 		либо просто увеличиваем длину подпоследовательности
% 
has_division_by_square(Count, MaxN, SubSequenceLen, LastN, CurrentN) when SubSequenceLen == Count -> LastN;
has_division_by_square(Count, MaxN, SubSequenceLen, LastN, CurrentN) -> 
	case  LastN == -1 of
		true -> find_squares(Count, MaxN, SubSequenceLen + 1, CurrentN, CurrentN + 1);
		false -> find_squares(Count, MaxN, SubSequenceLen + 1, LastN, CurrentN + 1)
	end.
% -----------------------------------------------------------------------