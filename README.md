# Markdown in Elm

This package is for markdown parsing. It is based on the [marked][] project
which focuses on speed.

[marked]: https://github.com/chjj/marked

## Basic Usage

```haskell
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