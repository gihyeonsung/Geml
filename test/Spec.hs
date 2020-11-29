{-# LANGUAGE OverloadedStrings #-}

module Main (main) where

import Ast
import Parser
import Test.Hspec
import Test.Hspec.Megaparsec
import Text.Megaparsec

main :: IO ()
main = hspec $ do
  specPlainParser
  specBoldParser
  specSpaceParser

specPlainParser :: Spec
specPlainParser =
  describe "plain parser" $ do
    it "parses text word" $
      parse pPlain "" "hello world" `shouldParse` Plain "hello"
    it "consumes up to spaces" $
      runParser' pPlain (initialState "123\t 456 ") `succeedsLeaving` "\t 456 "
    it "rejects empty word" $
      runParser' pPlain (initialState "") `failsLeaving` ""

specBoldParser :: Spec
specBoldParser =
  describe "bold parser" $ do
    it "parses bold words" $
      parse pBold "" "**bold word**" `shouldParse` Bold [Plain "bold", Space, Plain "word"]
    it "parses an empty range" $
      parse pBold "" "****" `shouldParse` Bold []
    it "parses bold ends with following multiple asterisks" $
      runParser' pBold (initialState "**bold***") `succeedsLeaving` "*"
    it "fails without closing asterisks" $
      parse pBold "" `shouldFailOn` "**time goes by"
    it "does not yields nested inlines" $
      runParser' pBold (initialState "** ** text ** **") `succeedsLeaving` " text ** **"

specSpaceParser :: Spec
specSpaceParser =
  describe "space parser" $ do
    it "consumes multiple horizontal spaces" $
      parse pSpace "" " \t" `shouldParse` Space
