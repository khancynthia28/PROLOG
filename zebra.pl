rightOf(R, L, [L,R,_,_,_]).
rightOf(R, L, [_,L,R,_,_]).
rightOf(R, L, [_,_,L,R,_]).
rightOf(R, L, [_,_,_,L,R]).

nextTo(A, B, [A,B,_,_,_]).
nextTo(A, B, [_,A,B,_,_]).
nextTo(A, B, [_,_,A,B,_]).
nextTo(A, B, [_,_,_,A,B]).
nextTo(A, B, [B,A,_,_,_]).
nextTo(A, B, [_,B,A,_,_]).
nextTo(A, B, [_,_,B,A,_]).
nextTo(A, B, [_,_,_,B,A]). 

first(A, [A|_]).
middle(A, [_,_,A,_,_]).

makeListOfHouses(0,[]).
makeListOfHouses(N, [house(_,_,_,_,_)|L]) :- M is N-1, makeListOfHouses(M,L).

answer(W,Z) :- makeListOfHouses(5, Houses),
member(house(red,english,_,_,_),Houses),
member(house(_,spain,_,_,dog),Houses),
member(house(green,_,coffee,_,_),Houses),
member(house(_,ukrainian,tea,_,_),Houses),
rightOf(house(green,_,_,_,_), house(ivory,_,_,_,_), Houses),
member(house(_,_,_,oldGold,snails), Houses),
member(house(yellow,_,_,kools,_), Houses),
middle(house(_,_,milk,_,_), Houses),
first(house(_,norwegian,_,_,_), Houses),
nextTo(house(_,_,_,chesterfields,_), house(_,_,_,_,fox), Houses),
nextTo(house(_,_,_,kools,_), house(_,_,_,_,horse), Houses),
member(house(_,_,orangeJuice,luckyStrike,_), Houses),
member(house(_,japanese,_,parliaments,_), Houses),
nextTo(house(_,norwegian,_,_,_), house(blue,_,_,_,_), Houses),
member(house(_,W,water,_,_), Houses),
member(house(_,Z,_,_,zebra), Houses).



