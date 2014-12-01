module Markdown where
{-| A library for markdown parsing. This is just an Elm API built on top of the
[marked](https://github.com/chjj/marked) project which focuses on speed.

# Parsing Markdown
@docs toElement, toHtml
-}

import Graphics.Element (Element)
import Html (Html)
import Native.Markdown
import Text


{-| Turn a markdown string into an HTML element.

    bodyParagraph : Html
    bodyParagraph =
        Markdown.toHtml """
    
    # Changing History

    In addition to time travel, Elm Reactor lets you change history...

    """
-}
toHtml : String -> Html
toHtml =
    Native.Markdown.toHtml


{-| Turn a markdown string into an HTML element.


    intro : Element    
    intro =
        Markdown.toElement """
    
    # Time Travel Made Easy

    Elm Reactor grew out of my internship working on Elm at Prezi this summer...

    """
-}
toElement : String -> Element
toElement =
    Native.Markdown.toElement