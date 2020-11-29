module Parser where

import Ast
import Data.Text as T
import Data.Void
import Text.Megaparsec
import Text.Megaparsec.Char

type Parser = Parsec Void Text

parser :: Parser Doc
parser = undefined

pDoc :: Parser Doc
pDoc = undefined

pBlock :: Parser Block
pBlock = undefined

pHeader :: Parser Block
pHeader = undefined

pParagraph :: Parser Block
pParagraph = undefined

pOrderedList :: Parser Block
pOrderedList = undefined

pUnorderedList :: Parser Block
pUnorderedList = undefined

pTable :: Parser Block
pTable = undefined

pRaw :: Parser Block
pRaw = undefined

pEmbed :: Parser Block
pEmbed = undefined

pMath :: Parser Block
pMath = undefined

pInline :: Parser Inline
pInline = choice [pPlain, pBold, pSpace]

pPlain :: Parser Inline
pPlain = Plain . pack <$> some alphaNumChar

pBold :: Parser Inline
pBold = try (Bold <$> between (chunk $ pack "**") (chunk $ pack "**") (many pInline))

pItalic :: Parser Inline
pItalic = undefined

pUnderline :: Parser Inline
pUnderline = undefined

pStrikeout :: Parser Inline
pStrikeout = undefined

pRawInline :: Parser Inline
pRawInline = undefined

pLink :: Parser Inline
pLink = undefined

pEmbedInline :: Parser Inline
pEmbedInline = undefined

pMathInline :: Parser Inline
pMathInline = undefined

-- TODO: Use hspace1 when stack lts support megaparsec 9.0
pSpace :: Parser Inline
pSpace = Space <$ some (char ' ' <|> tab)
