%:- module(prim_BinaryFile_external,
%          [prim_openBinaryFile/3, prim_hGetByte/3, prim_hPutByte/3]).

%:- (current_module(basics)       -> true ; use_module('../basics')).

prim_openBinaryFile(A,Mode,Stream) :-
	basics:string2Atom(A,FName),
	curryFileMode2plmode(Mode,PMode),
	open(FName,PMode,Stream,[type(binary)]).

curryFileMode2plmode('IO.ReadMode',read).
curryFileMode2plmode('IO.WriteMode',write).
curryFileMode2plmode('IO.AppendMode',append).

prim_hGetByte('$stream'('$inoutstream'(In,_)),N) :- !, get_byte(In,N).
prim_hGetByte(Stream,N) :- get_byte(Stream,N).


prim_hPutByte('$stream'('$inoutstream'(_,Out)),N,'Prelude.()') :- !,
	put_byte(Out,N).
prim_hPutByte(Stream,N,'Prelude.()') :- put_byte(Stream,N).
