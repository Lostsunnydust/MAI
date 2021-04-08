% Task 2: Relational Data

subject('LP','Logical Programming').
subject('MTH','Mathematical analysis').
subject('FP','Functional programming').
subject('INF','Information').
subject('ENG','English language').
subject('PSY','Psyhology').

student(102,'Petrov',[grade('LP',3),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(101,'Petrovsky',[grade('LP',5),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(104,'Ivanov',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',4),grade('ENG',3),grade('PSY',3)]).
student(102,'Ivanovsky',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',3),grade('ENG',3),grade('PSY',5)]).
student(104,'Zaporozchev',[grade('LP',3),grade('MTH',3),grade('FP',3),grade('INF',5),grade('ENG',5),grade('PSY',2)]).
student(101,'Sidorov',[grade('LP',5),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',2)]).
student(103,'Sidorkin',[grade('LP',4),grade('MTH',4),grade('FP',2),grade('INF',3),grade('ENG',4),grade('PSY',3)]).
student(102,'Bitkoinov',[grade('LP',4),grade('MTH',5),grade('FP',5),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(103,'Efirkina',[grade('LP',4),grade('MTH',5),grade('FP',3),grade('INF',3),grade('ENG',4),grade('PSY',4)]).
student(103,'Siplusplusov',[grade('LP',3),grade('MTH',5),grade('FP',3),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(103,'Programmiro',[grade('LP',3),grade('MTH',5),grade('FP',4),grade('INF',3),grade('ENG',5),grade('PSY',4)]).
student(104,'Javo',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',5),grade('ENG',3),grade('PSY',4)]).
student(103,'Klaviaturnikova',[grade('LP',3),grade('MTH',2),grade('FP',3),grade('INF',2),grade('ENG',5),grade('PSY',4)]).
student(101,'Mishin',[grade('LP',5),grade('MTH',5),grade('FP',2),grade('INF',4),grade('ENG',4),grade('PSY',2)]).
student(104,'Full',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Bezumnikov',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Sharpin',[grade('LP',4),grade('MTH',3),grade('FP',2),grade('INF',3),grade('ENG',3),grade('PSY',4)]).
student(104,'Crugloschitalkin',[grade('LP',5),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',2),grade('PSY',4)]).
student(103,'Reshetnikov',[grade('LP',3),grade('MTH',3),grade('FP',5),grade('INF',5),grade('ENG',5),grade('PSY',4)]).
student(102,'Excel',[grade('LP',4),grade('MTH',4),grade('FP',4),grade('INF',4),grade('ENG',4),grade('PSY',3)]).
student(102,'Tekstopisov',[grade('LP',5),grade('MTH',4),grade('FP',5),grade('INF',2),grade('ENG',3),grade('PSY',4)]).
student(103,'Tekstopisova',[grade('LP',3),grade('MTH',4),grade('FP',3),grade('INF',4),grade('ENG',4),grade('PSY',4)]).
student(101,'Gustobukennikova',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',4),grade('ENG',5),grade('PSY',4)]).
student(102,'Kriptovalutnikov',[grade('LP',4),grade('MTH',3),grade('FP',4),grade('INF',4),grade('ENG',3),grade('PSY',4)]).
student(104,'Blockcheinis',[grade('LP',4),grade('MTH',2),grade('FP',5),grade('INF',2),grade('ENG',5),grade('PSY',3)]).
student(102,'Azurin',[grade('LP',5),grade('MTH',2),grade('FP',5),grade('INF',5),grade('ENG',4),grade('PSY',5)]).
student(103,'Vebservisov',[grade('LP',4),grade('MTH',5),grade('FP',4),grade('INF',5),grade('ENG',4),grade('PSY',4)]).
student(102,'Cruglootlichnikov',[grade('LP',3),grade('MTH',4),grade('FP',5),grade('INF',3),grade('ENG',4),grade('PSY',5)]).



% для каждого студента найти средний балл и сдал ли он экзамены или нет

srb(X,C) :-
   student(_,X,L), 
   sum_list(L,B),
   dl(B,C),
   sdal(X).
   
dl(B,C) :- 
   C is B/6.
   
sum_list([], 0):-!.
sum_list([grade(_,Head)|Tail], Sum):-
   sum_list(Tail, TailSum),
   Sum is TailSum + Head.

member(E, [grade(_,E)|_Tail]).
member(E, [_Head|Tail]):-
   member(E, Tail).


sdal(X) :-
   student(_,X,L), (member(2, L) -> write('Ne'); write('Sdal')).


% Для каждого предмета, найти количество не сдавших студентов

chk(grade(E,M), X, N1, N):- M == 2, E == X, N is N1 + 1, !.
chk(_M, _X, N1, N1).

dod(_X, [], 0):-!.
dod(X, [H|T], N):-
dod(X, T, N1), chk(H, X, N1, N).

dods(_X, [], 0):-!.
dods(X, [H|T], N):-
dods(X, T, N1), dod(X, H, G), N is N1 + G.

smth(Y, N):-
subject(X,Y), findall(L, student(_, _, L), R), dods(X, R, N).


% для каждой группы найти студента с максимальным средним баллом

prv(Sr, N1, N, R1, R, H):- Sr == N1, N is N1, append(R1, [H], R), !.
prv(Sr, N1, N, _R1, R, H):- Sr > N1, N is Sr, append([], [H], R), !.
prv(_Sr, N1, N1, R1, R1, _H).

sps([], 0):-!.
sps([grade(_,X)|T], S):-
sps(T, S1), S is S1 + X.

iskat(H, R, R1, N, N1):-
student(_, H, L), sps(L, S), Sr is S/6, prv(Sr, N1, N, R1, R, H).

naydi([], [], 0):-!.
naydi([H|T], R, N):-
naydi(T, R1, N1), iskat(H, R, R1, N, N1).


nahoi(H):-
findall(X, student(H, X, _), R), naydi(R, G, _N), write(H), write(" "), write(G), nl.

tr([]).
tr([H|T]):-
nahoi(H), tr(T).

maxsrb():-
setof(A, B^C^student(A,B,C), L), tr(L).
