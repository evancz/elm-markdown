module Markdown exposing
  ( toHtml
  , Options, defaultOptions, toHtmlWith
  )

{-| A library for markdown parsing. This is just an Elm API built on top of the
[markdown-it](https://github.com/markdown-it/markdown-it) project which focuses
on speed.

# Parsing Markdown
@docs toHtml

# Parsing with Custom Options
@docs Options, defaultOptions, toHtmlWith
-}

import Html exposing (Html, Attribute)
import Native.Markdown


{-| Turn a markdown string into an HTML element, using the `defaultOptions`.

    recipe : Html msg
    recipe =
       Markdown.toHtml [class "recipe"] """

    # Apple Pie Recipe

    First, invent the universe. Then bake an apple pie.

    """
-}
toHtml : List (Attribute msg) -> String -> Html msg
toHtml attrs string =
  Native.Markdown.toHtml defaultOptions attrs string


{-| Some parser options so you can tweak things for your particular case.

  * `githubFlavored` &mdash; overall reasonable improvements on the original
    markdown parser as described [here][gfm]. This includes stuff like [fenced
    code blocks][fenced] and [tables][].

  * `html` &mdash; this determines if raw HTML should be allowed. If you
    are parsing user markdown or user input can somehow reach the markdown
    parser, you should almost certainly turn off HTML. If it is just you
    writing markdown, turning HTML on is a nice way to do some tricks if
    it is needed.

  * `breaks` &mdash; This will automatically convert `\n` in paragraphs
    to `<br>`.

  * `langPrefix` &mdash; CSS language class prefix for fenced blocks. Can be
    useful for external highlighters.

  * `defaultHighlighting` &mdash; a default language to use for code blocks that do
    not have a language tag. So setting this to `Just "elm"` will treat all
    unlabeled code blocks as Elm code. (This relies on [highlight.js][highlight]
    as explained in the README [here](../#code-blocks).)

  * `linkify` &mdash; This will automatically convert URL-like text to links.

  * `typographer` &mdash; This will automatically upgrade quotes to the
    prettier versions and turn dashes into [em dashes or en dashes][dash]

  * `quotes` &mdash; replace the "smart" double/single quotes that typographer
    adds when it is enabled. Examples:

      ```elm
      -- Russian
      { doubleLeft = "«", doubleRight = "»", singleLeft = "„", singleRight = "“" }

      -- German
      { doubleLeft = "„", doubleRight = "“", singleLeft = "‚", singleRight = "‘" }

      -- French
      { doubleLeft = "«\xA0", doubleRight = "\xA0»", singleLeft = "‹\xA0", singleRight = "\xA0›" }
      ```

[gfm]: https://help.github.com/articles/github-flavored-markdown/
[fenced]: https://help.github.com/articles/github-flavored-markdown/#fenced-code-blocks
[tables]: https://help.github.com/articles/github-flavored-markdown/#tables
[highlight]: https://highlightjs.org/
[dash]: http://en.wikipedia.org/wiki/Dash
-}
type alias Options =
  { githubFlavored : Bool
  , html : Bool
  , breaks : Bool
  , langPrefix : Maybe String
  , defaultHighlighting : Maybe String
  , linkify : Bool
  , typographer : Bool
  , quotes :
      Maybe
        { doubleLeft : String
        , doubleRight : String
        , singleLeft : String
        , singleRight : String
        }
  }


{-| The `Options` used by the `toHtml` function.

    { githubFlavored = True
    , html = True
    , breaks = True
    , langPrefix = Just "custom-class-"
    , defaultHighlighting = Just "markdown"
    , linkify = True
    , typographer = True
    , quotes = Just { doubleLeft = "«", doubleRight = "»", singleLeft = "„", singleRight = "“" }
    }
-}
defaultOptions : Options
defaultOptions =
  { githubFlavored = False
  , html = False
  , breaks = False
  , langPrefix = Just "hljs "
  , defaultHighlighting = Nothing
  , linkify = False
  , typographer = False
  , quotes = Nothing
  }


{-| Maybe you want to enable HTML input in your markdown. To accomplish this,
you can use modified parsing options.

    options : Options
    options =
        { defaultOptions | html = True }

    toMarkdown : String -> Html
    toMarkdown userInput =
        Markdown.toHtmlWith options [] userInput
-}
toHtmlWith : Options -> List (Attribute msg) -> String -> Html msg
toHtmlWith =
  Native.Markdown.toHtml
