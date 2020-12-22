% Prolog implementations of primitives of module System.IO.BinaryFile

'System.IO.BinaryFile.prim_openBinaryFile'(A,Mode,Stream) :-
	basics:string2Atom(A,FName),
	curryFileMode2plmode(Mode,PMode),
	open(FName,PMode,Stream,[type(binary)]).

curryFileMode2plmode('System.IO.ReadMode',read).
curryFileMode2plmode('System.IO.WriteMode',write).
curryFileMode2plmode('System.IO.AppendMode',append).

'System.IO.BinaryFile.prim_hGetByte'('$stream'('$inoutstream'(In,_)),N) :-
        !, get_byte(In,N).
'System.IO.BinaryFile.prim_hGetByte'(Stream,N) :- get_byte(Stream,N).


'System.IO.BinaryFile.prim_hPutByte'('$stream'('$inoutstream'(_,Out)),N,
                                     'Prelude.()') :-
        !, put_byte(Out,N).
'System.IO.BinaryFile.prim_hPutByte'(Stream,N,'Prelude.()') :-
        put_byte(Stream,N).
