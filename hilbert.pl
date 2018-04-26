goEast([Coord, C, R],[[[NewC,R]|Coord],NewC,R]):- NewC is C+20.
goWest([Coord, C, R],[[[NewC,R]|Coord],NewC,R]):- NewC is C-20.
goNorth([Coord, C, R],[[[C, NewR]|Coord],C,NewR]):- NewR is R-20.
goSouth([Coord, C, R],[[[C, NewR]|Coord],C,NewR]):- NewR is R+20.

aCurve(0, Board, Board).
aCurve(N, Board, NewBoard):-
  N > 0,
  M is N-1,
  hCurve(M, Board, B1),
  goEast(B1, B2),
  aCurve(M, B2, B3),
  goSouth(B3, B4),
  aCurve(M, B4, B5),
  goWest(B5, B6),
  cCurve(M, B6, NewBoard).

bCurve(0, Board, Board).
bCurve(N, Board, NewBoard):-
  N > 0,
  M is N-1,
  cCurve(M, Board, B1),
  goWest(B1,B2),
  bCurve(M, B2, B3),
  goNorth(B3, B4),
  bCurve(M, B4, B5),
  goEast(B5, B6),
  hCurve(M, B6, NewBoard).

cCurve(0, Board, Board).
cCurve(N, Board, NewBoard):-
  N > 0,
  M is N-1,
  bCurve(M, Board, B1),
  goNorth(B1, B2),
  cCurve(M, B2, B3),
  goWest(B3, B4),
  cCurve(M, B4, B5),
  goSouth(B5, B6),
  aCurve(M, B6, NewBoard).
hCurve(0, Board, Board).
hCurve(N, Board, NewBoard):-
  N > 0,
  M is N-1,
  aCurve(M, Board, B1),
  goSouth(B1, B2),
  hCurve(M, B2, B3),
  goEast(B3, B4),
  hCurve(M, B4, B5),
  goNorth(B5, B6),
  bCurve(M, B6, NewBoard).


hilbert(N):- hCurve(N, [[[0,0]],0,0], [Coord,_,_]), write(Coord), nl,reverse(Coord,Coordinates),
generateHTML(N), generateJS(N,Coordinates).

reverse(L,R):-reverse1(L,[],R).
reverse1([],P,P).
reverse1([X|T],P,S):- reverse1(T,[X|P],S).

generateHTML(N):-
  A = "/student/ckhan3/public_html/hilbert",
  B = ".html",
  C = " <!DOCTYPE html>
  <html>
    <head>
      <title>Hilbert Curves</title>
    </head>
    <body>
      <h3>Hilbert Curve Size = ",
  D = "</h3>
      <canvas width=\"1000\" height=\"1000\"></canvas>
      <script src=hilbert",
  E = ".js\"></script>
    </body>
  </html>",

   atom_concat(A,N,W1),
  atom_concat(W1,B,W2),
  atom_concat(C,N,W3),
  atom_concat(W3,D,W4),
  atom_concat(W4,N,W5),
  atom_concat(W5,E,W6),

  open(W2,write,Stream),
  write(Stream, W6),
  nl(Stream),
  close(Stream).

generateJS(N,Coordinates):-
  A = "/student/ckhan3/public_html/hilbert",
  B =".js",
  C = "var coordinates =",
  D = "let cx = document.querySelector(\"canvas\").getContext(\"2d\");
cx.beginPath();
cx.moveTo(0,0);
for (i=0; i<coordinates.length; i++) {
  cx.lineTo(coordinates[i][0],coordinates[i][1])
}
cx.stroke();",

  atom_concat(A,N,W1),
  atom_concat(W1,B,W2),

  open(W2,write,Stream),
  write(Stream, C),
  nl(Stream),
  write(Stream, Coordinates),
  write(Stream, ";"),
  nl(Stream),
  write(Stream, D),
  nl(Stream),
  close(Stream).
