:- dynamic(xnegative/2).
:- dynamic(xpositive/2).
 
 substance_is(vitaminA) :-
  it_is(vitamin) ,
  negative(does, dissolve_in_water),
  positive(does, improve_vision).

 substance_is(vitaminC) :-
  it_is(vitamin) ,
  positive(does, dissolve_in_water),
  positive(does, improve_immunity).

 substance_is(water) :-
  it_is(macronutrient) ,
  positive(does, regulate_temperature),
  negative(does, store_energy).

 substance_is(sodium) :-
    positive(has, simple_structure),
    negative(does, dissolve_in_water),
    positive(does, enable_nerve_transmission),
    it_is(mineral).

 substance_is(iron) :-
   positive(has, simple_structure),
   positive(does, carry_oxygen),
   it_is(mineral).
    
substance_is(hemoglobin) :-
 positive(does, carry_oxygen),
 negative(has, simple_structure),
 it_is(protein).

substance_is(keratin) :-
 it_is(protein),
 negative(does, carry_oxygen).

substance_is(glucose) :-
 positive(has, simple_structure),
 it_is(carbohydrate).

substance_is(fiber) :-
 negative(has, simple_structure),
 it_is(carbohydrate).

substance_is(phospholipid) :-
   it_is(lipid),
   positive(does, contain_glicerol),
   positive(does, contain_phosphoric_acid).
 
%2. Opis cech charakterystycznych dla klas obiektów
it_is(macronutrient) :-
    positive(does, occur_in_big_amounts).

it_is(micronutrient) :-
    negative(does, occur_in_big_amounts),
	negative(does, store_energy).

it_is(protein) :-
    it_is(macronutrient),
    positive(does, build_up_cells),
    positive(does, contain_amino_acids).
 
it_is(vitamin) :-
 	positive(does, regulate_body_processes).

it_is(carbohydrate) :-
    positive(does, build_up_cells),
    % rozpuszcza się w wodzie??
 	positive(does, store_energy).

it_is(mineral) :-
   positive(does, regulate_body_processes),
   positive(does, build_up_cells),
   it_is(micronutrient).

it_is(lipid) :-
    it_is(macronutrient),
    positive(does, store_energy),
    positive(does, regulate_temperature),
    negative(does, dissolve_in_water).
 
%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie
 
positive(X,Y) :-xpositive(X,Y),!.
positive(X,Y) :-
	\+ xnegative(X,Y) , ask(X,Y,yes).
negative(X,Y) :-xnegative(X,Y),!.
negative(X,Y) :-
	\+ xpositive(X,Y) ,
	ask(X,Y,no).
%4. Zadawanie pytań użytkownikowi
ask(X,Y,yes) :-
 (write(X), write(' it '),write(Y), write('\n'),
 read(Reply),
 sub_string(Reply, 0,1,_,'y'),!,
 remember(X,Y,yes)) ; (remember(X, Y, no), false).
 
ask(X,Y,no) :-
 (write(X), write(' it '),write(Y), write('\n'),
 read(Reply),
 sub_string(Reply,0,1,_, 'n'),!,
 remember(X,Y,no)) ; (remember(X, Y, yes), false).
 
%5. Zapamiętanie odpowiedzi w dynamicznej bazie
 remember(X,Y,yes) :-
 asserta(xpositive(X,Y)).
 remember(X,Y,no) :-
 asserta(xnegative(X,Y)).
%6. Uruchomienie programu
 run :-
 substance_is(X),!,
 write('\nYour substance may be a(n) '),write(X),
 nl,nl,clear_facts.
 run :-
 write('\nUnable to determine what'),
 write('your substance is.\n\n'),clear_facts.
 
%7. Wyczyszczenie zawartości dynamicznej bazy
 clear_facts :-
 retract(xpositive(_,_)),fail.
 clear_facts :-
 retract(xnegative(_,_)),fail.
 clear_facts :-
 write('\n\nPlease press the space bar to exit\n'). 