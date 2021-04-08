# Отчет по лабораторной работе №1
## Работа со списками и реляционным представлением данных
## по курсу "Логическое программирование"

### студент: Назарова А.И.

## Результат проверки

| Преподаватель     | Дата         |  Оценка       |
|-------------------|--------------|---------------|
| Сошников Д.В. |              |               |
| Левинская М.А.|              |       4       |

> *Комментарии проверяющих (обратите внимание, что более подробные комментарии возможны непосредственно в репозитории по тексту программы)*


## Введение

Опишите своими словами, чем списки в языке Пролог отличаются от принятых в императивных языках подходов к хранению данных. На какие структуры
данных в традиционных языках похожи списки в Прологе?



В Прологе очень компактно, по сравнению с императивными языками, описываются многие алгоритмы. Пролог-программу обычно очень легко писать, понимать и отлаживать. Это приводит к тому, что время разработки приложения на языке Пролог во многих случаях на порядок быстрее, чем на императивных языках. В Прологе легко описывать и обрабатывать сложные структуры данных. 

Списки в Прологе похожи на такую структуру храения данных, как деревья.

## Задание 1.1: Предикат обработки списка

Реализация стандартных предикатов обработки списка

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

1 вариант.del([X],Y).

2 вариант.remove1([X],[Y],L).

Примеры использования:
?- del([3,5,4,3,26,7,8,9,9],A). 
A = [3, 26, 7, 8, 9, 9].

?- remove1([2,4,5],[2,4,5,6,7,6,5,54,4,4,4],L).
L = [6, 7, 6, 5, 54, 4, 4, 4].

Реализация:
1 вариант.del([_, _, _, Y | T], [Y | T]).

2 вариант.remove1([X,Y,Z],[X,Y,Z|L],L)`


В Вашем варианте есть смысл реализации через append, иначе это дублирование первого варианта.

1 вариант.
  На вход получаем спискок, после чего в нем удалются первые 3 элемента, затем итоговый список без первых трех элементов выводится на экран.


2 вариант.
  На вход получаем список из трех первых элементов, которые нужно удалить, список, в котором нужно будет удалять элементы.Если список из трех элементов совпадает с первыми тремя
  элементами в основном списке, то они удаляются и выводится итоговый список.

## Задание 1.2: Предикат обработки числового списка



1 вариант. avg(X,A)
2 вариант. avg(L,A)

Примеры использования:
?- avg1([3,2,5,7,8,6,5],A). 
A = 5.142857142857143 

?- avg([5,4,33,3,2,22,3,2,5,7,8,6,5],A). 
A = 8.076923076923077 

Реализация:

1 вариант

sumn([],0,0).
sumn([H|T],N,S) :- sumn(T,N1,S1), N is N1+1, S is S1+H.
 
avg(X,A) :- sumn(X,N,S), A is S/N.


2 вариант(с использованием lenght)

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

1 вариант.
  Создается предикат sumn, который вычисляет сумму чисел в списке и ищет их кол-во.После предикат avg выводит среднее арифметическое, разделив сумму чисел в списке на их количество.



2 вариант.
  Создается предикат sum, который вычисляет сумму чисел в списке.Предикат lenght вычисляет длину списка. После чего предикат avg, в который передаются результаты вычисления предикатов sum и lenght, вычисляет среднее арифметическое списка.


  
## Задание 2: Реляционное представление данных

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


Достоинства реляционного представления:

1.Изложение информации в простой и понятной форме.
2.Для работы с таким представлением нет необходимости полностью знать организацию БД.




Недостатки реляционного представления:

1.Относительно медленный доступ к данным.
2.Трудность в составлении предикатов для сложных отношений.
3.Требуется относительно большой объем памяти.



Недостаток моего представления заключается в том, что сложно получить доступ к оценкам, преимущество-оценки каждого студента хранятся в однной строчке.
 
 1 пункт.
  В данном пункте необходимо для каждого студента найти средний балл и сдал ли он экзамены или нет.
  Создаем предикат srb(средний балл),внутри которого находятся список студентов и их оценки, сумма оценок каждого студента, поиск среднего балла и сдал ли студент экзамен или нет.

  Предикат dl вычисляет средний балл, sum_list- вычисляет сумму оценок каждого студента, member-смотрит принадлежность данному списку, sdal - выводит, сдал студент эказмены или нет.

  Пример работы:
   ?- srb(X,C).
    Sdal
    X = 'Petrov',
    C = 4 ;
    Ne
    X = 'Petrovsky',
    C = 3.6666666666666665 ;  
    Sdal
    X = 'Ivanov',
    C = 4
    
 2 пункт. 

  В данном пункте нужно для каждого предмета найти кол-во несдавших студентов.
  Предикат smth выводит нам предмет и кол-во несдавших студентов,  он состоит из subject(выводятся все предметы поочереди),findall (список списков оценок каждого студента),dods.
  В dods перебираем все элементы,поднимаемся наверх.dod вызывает себя рекурсивно до тех пор, пока не дойдет до "верха" списка студентов, передаем туда оценки студентов.
  В chk передаем оценки(голову), предмет, N1(из dod) и N, которое мы ищем.И дальше сотрим:если у нас оценка равна двойке и предмет, который мы "встретили", равен тому предмету, который мы ищем, то N равно значнию N1, которое увеличивается на 1.


  ?- smth(Y,X).
  Y = 'Logical Programming',
  X = 0 ;
  Y = 'Mathematical analysis',
  X = 3 ;
  Y = 'Functional programming',
  X = 3 ;
  Y = 'Information',
  X = 3 ;
  Y = 'English language',
  X = 2
  
 3 пункт.
 
 В предикате maxsrb() выводится список студентов каждой группы, у которых самый максимальный балл.
 С помощью setof получаем список номеров групп, который прокидываем дальше.Затем выделяем каждый номер группы и по одному номеру группы закидываем дальше.Дальше findallом находим список группы, чей номер мы получили.И там ищем людей с максимальным баллом этой группы.


   ?- maxsrb().
  101 [Gustobukennikova,Bezumnikov]
  102 [Azurin]
  103 [Vebservisov]
  104 [Full]
  true.
## Выводы

  В заключение этой лабораторной работы хотелось сказать, что как бы простым Пролог ни казался на первый взгляд, это мнение с высокой вероятностью развеется после первых 10 минут. Эта лабораторная работа научила меня работать со списками, выстраивать логические цепочки(что, где, как удаляется, куда что нужно написать, чтоб это правильно работало), работать с БД студентов.




