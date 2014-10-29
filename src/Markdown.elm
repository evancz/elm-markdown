module Markdown where
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.
-}

import Html (Html)
import Native.Markdown
import Text


toHtml : String -> Html
toHtml =
    Native.Markdown.toHtml


toElement : String -> Element
toElement =
    Native.Markdown.toElement