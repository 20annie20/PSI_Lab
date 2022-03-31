animals(dinosaurs, ducks).
animals(dinosaurs, dogs).
animals(ducks, rats).
animals(ducks, geese).
animals(geese, dragons).
animals(geese, mice).
animals(rats, cows).
animals(rats, dogs).
animals(dragons, mice).
animals(dragons, bugs).
animals(dogs, pigs).
animals(cows, pigs).
animals(pigs, frogs).
animals(mice, frogs).
animals(mice, bugs).
animals(bugs, cats).
animals(frogs, racoons).
animals(racoons, chickens).
animals(chickens, giraffes).
animals(giraffes, cats).

neighbornode(X, Y) :- animals(X,Y).
neighbornode(X, Y) :- animals(Y,X).

avoid([dinosaurs, dragons]).
go(Here,There) :- route(Here,There,[Here]).

route(I, I, VisitedNodes) :-
	member(frogs, VisitedNodes),
	reverse(VisitedNodes, VisitedNodesReversed),
	write(VisitedNodesReversed),
	nl.

route(Node, Way_out, VisitedNodes) :-
	neighbornode(Node, NextNode),
	avoid(DangerousNodes),
	\+ member(NextNode, DangerousNodes),
	\+ member(NextNode, VisitedNodes),
	route(NextNode, Way_out,[NextNode|VisitedNodes]).

member(X,[X|_]).
member(X,[_|H]) :- member(X,H).
