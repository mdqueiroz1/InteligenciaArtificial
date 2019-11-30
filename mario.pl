peach( [2,5] ).
dk( [2,4] ).
martelo( [2,3] ).
escada([ [1,2],[2,2] ]).
parede( [3,2] ).
%barril([ [2,3],[3,3],[0,0],[1,1],[1,2] ]).
barrilduplo([ [1,2],[1,3] ]).

caminha([X,Y],[X2,Y]):- Y<6, Y>0, X < 5, X>0, X2 is X+1.
caminha([X,Y],[X2,Y]):- Y<6, Y>0, X >=2, X<6, X2 is X-1.
caminha([X,Y],[X,Y2]):- X<6, X>0, Y < 5, Y>0, Y2 is Y+1.
caminha([X,Y],[X,Y2]):- X<6, X>0, Y >=2, Y<6, Y2 is Y-1.

viavel(Sucessor,Estado,Caminho) :- not(dk(Sucessor)),
								   not(barrilduplo(Sucessor)),
								   not(parede(Sucessor));
								   pertence(M,Caminho),martelo(M);martelo(Estado).

%conta([X|Y],N):-pokemon(X), conta(Y,N1),N1 is N+1. 
%conta([_|Y],N):-conta(Y,N). 

mov(X,Y) :- caminha(X,Y).

concatena([ ],L,L).
concatena([Cab|Cauda],L2,[Cab|Resultado]):- concatena(Cauda,L2,Resultado).

pertence(X,[X|_]).
pertence(X,[_|Cauda]):-pertence(X,Cauda).

inv(L,[],L).             		
inv(L,[X|Y],Z):-inv([X|L],Y,Z).

mario(Inicial,Solucao) :- bl([[Inicial]],Solucao),inv([],Solucao,Y),write(Y),!.

bl([[Estado|Caminho]|_],[Estado|Caminho]) :- peach(Estado),
											 pertence(M,Caminho),martelo(M),
											 pertence(DK,Caminho),dk(DK).

bl([Primeiro|Outros], Solucao) :- estende(Primeiro,Sucessores),
								  concatena(Outros,Sucessores,NovaFronteira),
								  bl(NovaFronteira,Solucao).

estende([Estado|Caminho],ListaSucessores):- bagof([Sucessor,Estado|Caminho],
											(mov(Estado,Sucessor),
											not(pertence(Sucessor,
											[Estado|Caminho])),
											viavel(Sucessor,Estado,Caminho)),
											ListaSucessores),!.
estende(_,[]).