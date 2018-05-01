evalLISP(A, A):- number(A).
evalLISP(B, B):- atom(B).
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
evalLISP(cdr(A), N):- evalLISP(A, A1), evalLISP(cdr(A1),N).

evalBOOL(lt(A,B)):- evalLISP(A, A1) , evalLISP(B, B1), A1 < B1.
evalBOOL(gt(A,B)):- evalLISP(A, A1), evalLISP(B, B1),  A1 > B1.
evalBOOL(eq(A,B)):- evalLISP(A, A1), evalLISP(B, B1),  A1 = B1.
evalBOOL(lteq(A,B)):- evalLISP(A, A1), evalLISP(B, B1), A1 =< B1.
evalBOOL(gteq(A,B)):- evalLISP(A, A1), evalLISP(B, B1), A1 >= B1.

evalLISP(and(A,B), _):- evalBOOL(A),evalBOOL(B).
evalLISP(or(A,B), _):- evalBOOL(A); evalBOOL(B).
evalLISP(not(A),_):- evalBOOL(A) -> false; true.
evalLISP(f(A,B,C),N):- evalBOOL(A)-> N is B; N is C.

evalLISP(cons(A, [B|L]), [A1,B1|N]):- evalLISP(A, A1), evalLISP(B, B1), evalLISP(L, N).
evalLISP(list([A|L]),[A1|N]):- evalLISP(A, A1), evalLISP(L, N).

evalLISP(let([(A,B)|L]),C,N):- evalPair([(A,B)|L],_{}, P), evalLISP(C, P, N).

evalPair([],P1,P1).
evalPair([(A,B)|L],P1{}, P2):- evalLISP(B, X),M = P1{}.put(A,X), evalPair(L, M, P2).
evalPair([(A,B)|L],P1, P2):- evalLISP(B, X),M = P1.put(A,X), evalPair(L, M, P2).

evalLISP(B, P, N):- atom(B) -> N = P.get(B); number(B) -> N is B; B = (let([(X,Y)|Z]), C) ->
                                                           (evalPair([(X,Y)|Z],P,P1), evalLISP(C, P1, N)).
evalLISP(+(A,B),P,N):- (evalLISP(A,P,A1);evalLISP(A, A1)), (evalLISP(B,P,B1);evalLISP(B, B1)),
                        evalLISP(A1, P, A2), evalLISP(B1, P, B2), N is A2 + B2.
evalLISP(-(A,B),P,N):- (evalLISP(A,P,A1);evalLISP(A, A1)), (evalLISP(B,P,B1);evalLISP(B, B1)),
                        evalLISP(A1, P, A2), evalLISP(B1, P, B2), N is A2 - B2.
evalLISP(*(A,B),P,N):- (evalLISP(A,P,A1);evalLISP(A, A1)), (evalLISP(B,P,B1);evalLISP(B, B1)),
                        evalLISP(A1, P, A2), evalLISP(B1, P, B2), N is A2 * B2.
evalLISP(/(A,B),P,N):- (evalLISP(A,P,A1);evalLISP(A, A1)), (evalLISP(B,P,B1);evalLISP(B, B1)),
                        evalLISP(A1, P, A2), evalLISP(B1, P, B2), N is A2 / B2.

