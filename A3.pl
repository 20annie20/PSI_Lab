:-dynamic komputer/5.
wykPrg:-
	write('1 - biezacy stan bazy danych'), nl,
	write('2 - dopisanie nowego komputera'), nl,
	write('3 - usuniecie komputera'), nl,
	write('4 - obliczenie sredniej ceny'), nl,
	write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
	write('6 - zapisanie bazy w pliku'), nl,
	write('7 - wypisanie danych i liczby komputerów o podanej nazwie procesora'), nl,
	write('8 - wypisanie danych i liczby komputerów o cenie mniejszej ni¿ podana'), nl,
	write('0 - koniec programu'), nl, nl,
	read(I),
	I > 0,
	opcja(I),
	wykPrg.
wykPrg.
opcja(1) :- wyswietl.

opcja(2) :- write('Podaj nazwê procesora:'), read(Procesor),
	write('Podaj typ procesora:'), read(Typ),
	write('Podaj czêst. zegara:'), read(Czestotliwosc),
	write('Podaj rozmiar HDD:'), read(HDD),
	write('Podaj cenê:'), read(Cena),

assert(komputer(Procesor, Typ, Czestotliwosc, HDD, Cena)).

opcja(3) :- write('Podaj nazwe procesora usuwanego komputera:'), read(Procesor), nl,
	write('Podaj typ procesora usuwanego komputera:'), read(Typ), nl,
	retract(komputer(Procesor,Typ,_ , _, _)),! ;
	write('Brak takiego komputera').

opcja(4) :- sredniaCena.

opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
	exists_file(Nazwa), !, consult(Nazwa);
	write('Brak pliku o podanej nazwie'), nl.

opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
	open(Nazwa, write, X), zapis(X), close(X).

opcja(7) :- write('Podaj nazwe procesora:'), read(Nazwa),
	komputeryZProcesorem(Nazwa).

opcja(8) :- write('Podaj cene:'), read(Cena),
	komputeryZMniejszaCena(Cena).

opcja(_) :- write('Zly numer opcji'), nl.

wyswietl :- write('elementy bazy:'), nl,
	komputer(Procesor, Typ, Czestotliwosc, HDD, Cena),
	write(Procesor), write(' '), write(Typ), write(' '), write(Czestotliwosc), write(' '),
	write(HDD), write(' '), write(Cena), nl, fail.
wyswietl :- nl.

sredniaCena:- findall(Cena, komputer(_, _, _, _,Cena), Lista),
	suma(Lista, Suma, LiczbaKomputerów),
	SredniaCena is Suma / LiczbaKomputerów,
	write('Srednia cena:'), write(SredniaCena), nl, nl.

wypisz([]).
wypisz([Elem|X]) :-
	(Proc, Typ, Freq, HDD, Cena) = Elem,
	format('~w ~w ~1f ~0f ~0f~n', [Proc, Typ, Freq, HDD, Cena]),
	wypisz(X).

nElem([], 0).
nElem([_|X], N) :-
	nElem(X, I), N is I+1.

komputeryZProcesorem(Procesor):-
	findall((Proc, Typ, Freq, HDD, Cena),(komputer(Proc, Typ, Freq, HDD, Cena), Proc = Procesor), Lista),
	wypisz(Lista), nl,
	nElem(Lista, Len),
	write('Liczba komputerow:'), write(Len), nl.

komputeryZMniejszaCena(Cena):-
	findall((Proc, Typ, Freq, HDD, Price), (komputer(Proc, Typ, Freq, HDD, Price), Price < Cena), Lista),
	wypisz(Lista), nl,
	nElem(Lista, Len),
	write('Liczba komputerow:'), write(Len), nl.

zapis(X) :- komputer(Procesor, Typ, Czestotliwosc, HDD, Cena),
	write(X, 'komputer('), write(X, '"'),
	write(X, Procesor), write(X, '"'),
	write(X, ','), write(X, '"'),
	write(X, Typ), write(X, '"'),
	write(X, ','),
	write(X, Czestotliwosc), write(X, ','), write(X, HDD),
	write(X, ','), write(X, Cena), write(X, ').'), nl(X), fail.
zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
	Suma is G + S1,
	N is N1+1.


komputer("Intel", "Alderlake", 14, 500, 1200).
komputer("Intel", "Coffeelake", 15, 1000, 1600).
komputer("Intel", "Tigerlake", 14.5, 800, 1550).
