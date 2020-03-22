module Types where

data Span =
  Span
    { start :: Int -- index of the first character of a source code span
    , end :: Int -- index of the character after the last of a source code span
    }
  deriving (Eq)

instance Show Span where
  show (Span start end) = show start ++ ":" ++ show end
