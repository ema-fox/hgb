module Error
  ( Error(..)
  , ErrorType(..)
  , Expectation(..)
  ) where

import Symbol (Symbol(..), symbolToStr)
import Token (Token(..))
import Types (Span)

displayOptions :: Show a => [a] -> String
displayOptions [one] = show one -- Option
displayOptions [first, second] = show first ++ " or " ++ show second -- Option or AnotherOption
displayOptions all = concat all -- Option, AnotherOption, ..., or YetAnotherOption
  where
    concat :: Show a => [a] -> String
    concat lst =
      case lst
      -- ..., AnotherOption, or YetAnotherOption
            of
        [slast, last] -> show slast ++ ", or " ++ show last
      -- Option, ...
        (first:rest) -> show first ++ ", " ++ concat rest

data Expectation
  = Expression
  | ExpressionTerminator
  | ExpressionOrDelimiter
  | EnumerationListDelimiter Symbol
  | CloseToken Symbol

instance Show Expectation where
  show Expression = "an expression"
  show ExpressionTerminator = "\"!\""
  show ExpressionOrDelimiter = show Expression ++ " or delimiter"
  show (EnumerationListDelimiter closer) =
    "\",\" or " ++ show (symbolToStr closer)
  show (CloseToken closer) = show (symbolToStr closer)

data ErrorType =
  Expected Expectation Token

instance Show ErrorType where
  show (Expected expectation token) =
    "expected " ++ show expectation ++ "; got " ++ show (content token)

data Error =
  Error ErrorType Span

instance Show Error where
  show (Error errorType span) =
    "Error: " ++ show errorType ++ " at " ++ show span
