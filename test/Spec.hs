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
  specSpaceParser

specPlainParser :: Spec
specPlainParser =
  describe "plain parser" $ do
    it "parses text word" $
      parse pPlain "" "hello world" `shouldParse` Plain "hello"
    it "consumes up to spaces" $
      runParser' pPlain (initialState "123\t 456 ") `succeedsLeaving` "\t 456 "

specSpaceParser :: Spec
specSpaceParser =
  describe "space parser" $ do
    it "consumes multiple horizontal spaces" $
      parse pSpace "" " \t" `shouldParse` Space
