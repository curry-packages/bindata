------------------------------------------------------------------------------
--- Library to support reading/writing binary files.
---
--- @author Michael Hanus
--- @version December 2020
------------------------------------------------------------------------------

module System.IO.BinaryFile
  ( IOMode, Handle -- from IO
  , openBinaryFile, hGetByte, hPutByte, hGetBinaryContents
  )
 where

import System.IO ( IOMode, Handle, hIsEOF, hClose )

--- `Byte` is an alias for `Int`. Could be changed for a more
--- space efficient representation.
type Byte = Int

--- Like 'System.IO.openFile', but open the file in binary mode.
--- Thus, no translation of character is performed when reading
--- or writing a file.
--- Returns a handle to read and write the binary stream
--- (e.g., with operations 'hGetByte' and 'hPutByte').
openBinaryFile :: String -> IOMode -> IO Handle
openBinaryFile filename mode = (prim_openBinaryFile $## filename) $# mode

prim_openBinaryFile :: String -> IOMode -> IO Handle
prim_openBinaryFile external

--- Reads a byte from an input handle associated to a _binary_ stream
--- and returns it.
--- Throws an error if the end of file has been reached or the stream
--- is not binary.
hGetByte    :: Handle -> IO Byte
hGetByte h = prim_hGetByte $# h

prim_hGetByte :: Handle -> IO Byte
prim_hGetByte external

--- Puts a byte to an output handle associated to a _binary_ stream.
hPutByte    :: Handle -> Byte -> IO ()
hPutByte h c = (prim_hPutByte $# h)  $## c

prim_hPutByte :: Handle -> Byte -> IO ()
prim_hPutByte external

--- Reads the complete contents from an input handle and closes the input handle
--- before returning the contents.
hGetBinaryContents  :: Handle -> IO [Byte]
hGetBinaryContents h = do
  eof <- hIsEOF h
  if eof then hClose h >> return []
         else do b <- hGetByte h
                 bs <- hGetBinaryContents h
                 return (b:bs)

