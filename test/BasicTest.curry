--- Testing reading/writing binary data

import IO
import System
import Test.Prop

import BinaryFile

-- Copies a binary file.
copyBinaryFile :: String -> String -> IO ()
copyBinaryFile f1 f2 = do
  h1 <- openBinaryFile f1 ReadMode
  h2 <- openBinaryFile f2 WriteMode
  copy h1 h2
 where
  copy h1 h2 = do
    eof1 <- hIsEOF h1
    if eof1
      then hClose h1 >> hClose h2
      else hGetByte h1 >>= hPutByte h2 >> copy h1 h2

-- Compares the contents of two binary files.
compareBinaryFiles :: String -> String -> IO Bool
compareBinaryFiles f1 f2 = do
  h1 <- openBinaryFile f1 ReadMode
  h2 <- openBinaryFile f2 ReadMode
  cmp h1 h2
 where
  cmp h1 h2 = do
    eof1 <- hIsEOF h1
    eof2 <- hIsEOF h2
    if eof1 && eof2
      then hClose h1 >> hClose h2 >> return True
      else if eof1 || eof2
             then return False
             else do b1 <- hGetByte h1
                     b2 <- hGetByte h2
                     if b1==b2 then cmp h1 h2
                               else return False


testGetBinaryContents = genFiles `returns` True
 where
  genFiles = do
    h1 <- openBinaryFile "XXX0" WriteMode
    mapIO_ (hPutByte h1) [0..255]
    hClose h1
    h2 <- openBinaryFile "XXX0" ReadMode
    bytes <- hGetBinaryContents h2
    return (bytes == [0..255])

testGenBinFile = genFiles `returns` True
 where
  genFiles = do
    h1 <- openBinaryFile "XXX1" WriteMode
    mapIO_ (hPutByte h1) [0..255]
    hClose h1
    copyBinaryFile     "XXX1" "XXX2"
    compareBinaryFiles "XXX1" "XXX2"

testCopyBinFiles = genFiles `returns` True
 where
  genFiles = do
    let file = "curry_logo.png"
    copyBinaryFile     file "XXX3"
    compareBinaryFiles file "XXX3"

cleanTestFiles = system "/bin/rm XXX?" `returns` 0
