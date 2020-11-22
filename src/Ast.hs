module Ast where

import Data.Aeson.Types (Value)
import qualified Data.Text as T (Text)

newtype Attr = Attr Value

newtype Loc = Loc T.Text

data Doc = Doc [Block] (Maybe Attr)

data Block
  = Header Integer Block
  | Paragraph [Inline]
  | OrderedList [Block]
  | UnorderedList [Block]
  | Table [[Inline]]
  | Raw T.Text
  | Embed Loc
  | Math
  | Block Block (Maybe Attr)

data Inline
  = Plain T.Text
  | Bold [Inline]
  | Italic [Inline]
  | Underline [Inline]
  | Strikeout [Inline]
  | RawInline T.Text
  | Link Loc
  | EmbedInline Loc
  | MathInline
  | Space
  | Inline Inline (Maybe Attr)
