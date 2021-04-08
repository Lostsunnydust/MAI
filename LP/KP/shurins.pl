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





