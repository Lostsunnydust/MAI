parents('Anastasiia Nazarova','Igor Nazarov','Nadezhda Filatova').
parents('Svetlana Nazarova','Igor Nazarov','Nadezhda Filatova').
parents('Igor Nazarov','Michail Nazarov','Ludmila Safonova').
parents('Oksana Nazarova','Michail Nazarov','Ludmila Safonova').
parents('Nadezhda Filatova','Vladimir Filatov','Valentina Chivileva').
parents('Nikolay Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Zinaida Chivileva','Egor Chivilev','Pelageya Chermoshenceva').
parents('Valentina Chivileva','Egor Chivilev','Pelageya Chermoshenceva').
parents('Alexander Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Alexey Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Ivan Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Anatoly Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Victor Chivilev','Egor Chivilev','Pelageya Chermoshenceva').
parents('Vladimir Filatov','Andrey Filatov','Anisya Belova').
parents('Michail Nazarov','Alexander Nazarov','Natalya Koroleva').
parents('Ludmila Safonova','Evgeny Safonov','Xenia Tarakanova').
parents('Victorya Tkacheva','Nikolay Tkachev','Oksana Nazarova').
parents('Alexander Tkachev','Nikolay Tkachev','Oksana Nazarova').
parents('Matvey Tkachev','Nikolay Tkachev','Oksana Nazarova').
parents('Natalya Tokareva','Boris Tokarev','Zinaida Chivileva').
parents('Alexey Stepanenko','Ivan Stepanenko','Natalya Tokareva').

doughter(['Anastasiia Nazarova','Svetlana Nazarova','Oksana Nazarova','Nadezhda Filatova','Zinaida Chivileva','Valentina Chivileva',
'Ludmila Safonova','Victorya Tkacheva','Natalya Tokareva']).

find([First|_], First).
find([_|End_list], First):- find(End_list, First).

wife(W, M) :- 
    parents(_, M, W).

brother(X,Y):-
    parents(X,M,W), 
    parents(Y,M,W),
    X\=Y, 
    doughter(Doughter_list),
    not(find(Doughter_list, Y)).

shurin(S,M) :-
    wife(W,M),
    brother(W,S).


% четвертое задание 
child(Person,Y) :- % "Person" - ребенок у "Y"
    parents(Person, Y, Z);
    parents(Person, Z, Y).

subling(Person,Y) :- % Брат или сестра
    parents(Person, U, V),
    parents(Y, U, V),
    Person \= Y.

check_link(husband, Husband, Wife):-
    parents(Person, Husband, Wife).

check_link(wife, Wife, Husband):-
    parents(Person, Husband, Wife).

check_link(father, Father, Child):-
    parents(Child, Father, Mother).

check_link(mother, Mother, Child):-
    parents(Child, Father, Mother).

check_link(parent, Parent, Child):-
    child(Child, Parent).

check_link(child, Child, Parent):-
    child(Child, Parent).

check_link(subling, Brother, Y):-
    subling(Brother, Y).

check_relation(X):-
    member(X, [father, mother, subling, child, husband, wife]).


/*          Степень родства          */
relative_thread(X, Y, Res):- % цепочка людей, через которых связаны 2 человека
    search_bdth(X, Y, Res).

ask_relative(X, Y, Res):- % цепочка родства, через которую связаны 2 человека
    check_relation(Res), !,
    check_link(Res, X, Y).

relative(X, Y, Res):-
    search_bdth(X, Y, Res1), !,
    transform(Res1, Res).

transform([_],[]):-!. % переделать цепочку родственников в цепочку родства
transform([First,Second|Tail],ResList):-
    check_link(Relation,First,Second),
    ResList = [Relation|Tmp],
    transform([Second|Tail],Tmp),!.

prolong([X|T],[Y,X|T]):-
   move(X,Y),
   \+ member(Y,[X|T]).

move(X,Y):-
   check_link(_,X,Y).

search_bdth(X,Y,P):-
    bdth([[X]],Y,L),
    reverse(L,P).

bdth([[X|T]|_],X,[X|T]).
bdth([P|QI],X,R):-
    findall(Z,prolong(P,Z),T),
    append(QI,T,Q0),
    bdth(Q0,X,R),!.

bdth([_|T],Y,L):-
    bdth(T,Y,L).

% пятое задание
question_word(X):-
    member(X, [how, who, "How", "Who"]).

quantity(X):-
    member(X, [much, many]).

purals(X):-
    member(X, [sublings, children]).
pural(subling, sublings).
pural(child, children).

help_word(X):-
    member(X, [do, does]).

have_has(X):-
    member(X, [have, has]).

is(X):-
    member(X,[is]).

particle(X):-
    member(X, ["'s"]).

question_mark(X):-
    member(X, ['?']).

his_her(X):-
    member(X, [his, her, he, she]).

%how many sublings does *name* have ?
ask_question(List):-
    List = [A,B,C,D,E,F,H],
    question_word(A),
    quantity(B),
    purals(C),
    help_word(D),
    nb_setval(lastName,E),
    have_has(F),
    question_mark(H),

    pural(C1,C),
    setof(X,ask_relative(X,E,C1),T),
    length(T,Res),!,
    write(E),
    write(" has "),
    ((Res =:= 1,write(Res),write(" "),write( C1));(\+(Res =:= 1),write(Res),write(" "),write( C))),!.

% who is *name* subling?
ask_question(List):-
    List = [A,B,C,D,E,F],
    question_word(A),
    is(B),
    nb_setval(lastName,C),
    particle(D),
    check_relation(E),
    question_mark(F), !,
    check_link(E,Res,C),
    write(Res),write(" is "), write(C),write("'s "),write(E).

% who is her subling
ask_question(List):-
    List = [A,B,C1,D,E],
    question_word(A),
    is(B),
    his_her(C1),
    nb_getval(lastName,C),
    check_relation(D),
    question_mark(E),!,
    check_link(D,Res,C),
    write(Res),write(" is "), write(C),write("'s "),write(D).

% is *name* *name* s child?
ask_question(List):-
    List = [A,B,C,D,E,F],
    nb_setval(lastName,C),
    is(A),
    particle(D),
    check_relation(E),
    question_mark(F),
    check_link(E,B,C),
    !.

% is *name* his/her child?
ask_question(List):-
    List = [A,B,C1,D,E],
    is(A),
    his_her(C1),
    check_relation(D),
    question_mark(E),

    nb_getval(lastName,C),
    check_link(D,B,C),
    !.

/*          Анализ предложений          */

% who is *name* s subling?
% is *name* *name* s child ?
analysis(List,Res):-
    append(L1,L2,List),
    questionType(L1,Q),
    append(M1,M2,L2),
    name(M1,Q1),
    append(N1,N2,M2),
    relationship(N1,Q2),
    questionsign(N2,Q3),
    Res = sentence(Q,Q1,Q2,Q3).

% how many sublings does *name* have ?
analysis(List,Res):-
    List = [A,B,C,D,E,F,G],
    questionType([A,B],Q),
    relationship([C],Q1),
    helpword([D],Q2),
    name([E],Q3),
    have_Has([F],Q4),
    questionsign([G],Q5),
    Res = sentence(Q,Q1,Q2,Q3,Q4,Q5).

relationship([X],Res):-
    check_relation(X),
    Res = relationship_(X).

relationship([X],Res):-
    purals(X),
    Res = relationship_(X).

helpword([X],Res):-
    help_word(X),
    Res = helpWord(X).

have_Has([X],Res):-
    have_has(X),
    Res = haveHas(X).

questionType(L,question_type(X,Y)):-
    question_word(X1),
    is(Y1),
    L = [X1,Y1],
    X = questionWord(X1),
    Y = auxiliaryVerb(Y1).

questionType(L,question_type(X,Y)):-
    question_word(X1),
    quantity(Y1),
    L = [X1,Y1],
    X = questionWord(X1),
    Y = much_many(Y1).

questionType(L,question_type(X)):-
    is(X1),
    L = [X1],
    X = auxiliaryVerb(X1).

name(L,names(X)):-
    L = [X1,Y1],
    particle(Y1),
    X = person(X1,Y1).

name(L,names(X)):-
    L = [X1],
    X = person(X1).

name(L,names(X,Y)):-
    L = [X1,Y1,Z],
    particle(Z),
    X = person(X1),
    Y = relative_(Y1,Z).

questionsign([X],Res):-
    question_mark(X),
    Res = questionMark(X).
