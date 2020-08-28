% Prolog implementations of primitives of module BinaryFile

'BinaryFile.prim_openBinaryFile'(A,Mode,Stream) :-
	basics:string2Atom(A,FName),
	curryFileMode2plmode(Mode,PMode),
	open(FName,PMode,Stream,[type(binary)]).

curryFileMode2plmode('IO.ReadMode',read).
curryFileMode2plmode('IO.WriteMode',write).
curryFileMode2plmode('IO.AppendMode',append).

'BinaryFile.prim_hGetByte'('$stream'('$inoutstream'(In,_)),N) :-
        !, get_byte(In,N).
'BinaryFile.prim_hGetByte'(Stream,N) :- get_byte(Stream,N).


'BinaryFile.prim_hPutByte'('$stream'('$inoutstream'(_,Out)),N,'Prelude.()') :-
        !, put_byte(Out,N).
'BinaryFile.prim_hPutByte'(Stream,N,'Prelude.()') :- put_byte(Stream,N).
