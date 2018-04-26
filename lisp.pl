evalLISP(A, A):- number(A).
evalLISP(+(A,B), N):- evalLISP(A, A1), evalLISP(B, B1), N is A1 + B1.
evalLISP(-(A,B), N):- evalLISP(A, A1), evalLISP(B, B1), N is A1 - B1.
evalLISP(*(A,B), N):- evalLISP(A, A1), evalLISP(B, B1), N is A1 * B1.
evalLISP(/(A,B), N):- evalLISP(A, A1), evalLISP(B, B1), N is A1 / B1.

evalLISP(car([A|_]), N):- evalLISP(A, N).
evalLISP(car(cdr(A)), N):- evalLISP(A, [_,N|_]).

evalLISP([],[]).
evalLISP([A|L], [N|M]):- evalLISP(A, N), evalLISP(L, M).

evalLISP(cdr([_|L]),N):- evalLISP(L, N).
evalLISP(cdr(cdr(A)), N):- evalLISP(A, [_,_|N]).
