module Main where

import qualified Lib as LibHgb

main :: IO ()
main = do
    input <- getContents
    print (LibHgb.lex input)
