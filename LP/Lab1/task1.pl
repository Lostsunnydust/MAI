%Реализация своих версий стандартных предикатов

member(A, [A|_]).
member(A, [_|Z]) :- member(A, Z).

lenght([], 0).
lenght([_|Y], N) :- lenght(Y, N1), N is N1+1.

append([], X, X).
append([A|X], Y, [A|Z]) :- append(X,Y,Z).

remove(X, [X|T], T).
remove(X, [Y|T], [Y|T1]) :- remove(X, T, T1).

permute([], []).
permute(L, [X|T]) :- remove(X, L, R), permute(R, T).

sublist(S,L):-
append(_, L1,L),
append(S, _, L1).

%Удаление первых трех элементов

del([_, _, _, Y | T], [Y | T]).


remove1([X,Y,Z],[X,Y,Z|L],L).


% Вычисление среднего арифметического элементов

%Первый способ
sumn([],0,0).
sumn([H|T],N,S) :- sumn(T,N1,S1), N is N1+1, S is S1+H.
 
avg(X,A) :- sumn(X,N,S), A is S/N.

%Второй способ(с использованием lenght)

sum([], 0). 
sum([H|T], S) :-
   sum(T, S1),
   S is S1 + H.

length([], 0) . ​
length([_|T], L) :- 
   length(T, L1), L is L1 + 1.

avg(L,A):-
   sum(L,S),
   length(L,K),
   A is S/K.

%Предикат в котором удаляются первые три числа и после вычисляется среднее арифметическое оставшегося списка
   smth(P,A):-
      del(P,L),
      avg(L,A).

