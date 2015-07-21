# Markdown in Elm

This package is for markdown parsing and rendering. It is based on the [marked][] project
which focuses on speed.

[marked]: https://github.com/chjj/marked

## Basic Usage

```elm
content : Element
content = Markdown.toElement """

# Apple Pie Recipe

  1. Invent the universe.
  2. Bake an apple pie.

"""
```

**Warning:** Calling the `Markdown.toElement` function actually parses the
whole block, so try not to call it for no reason. In the `content` example
above we only have to parse the text once, but if we put it in a function we
may be doing a lot of unnecessary parsing.

## Code Blocks

For highlighting any code blocks, the package relies on the
[highlight.js](https://highlightjs.org/) project. So if you want to
see highlighting of code blocks in the rendering result, you need to
make sure that your page/app binds a version of that library
(supporting the languages you want to handle) to `window.hljs` in
Javascript. [This is how package.elm-lang.org does
that.](https://github.com/elm-lang/package.elm-lang.org/blob/e0b7aa4282038475612722ff7a57195866f8645b/backend/ServeFile.hs#L54)

For code blocks without a language tag, highlight.js's auto detection
will be used, based on the language set you have included in the
version of that library bound in your app.
