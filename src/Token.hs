module Token where

import Symbol (Symbol)
import Types (Span)

data Token =
  Token
    { symbol :: Symbol
    , content :: String
    , sourceSpan :: Span
    }
  deriving (Eq, Show)
