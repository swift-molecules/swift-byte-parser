# swift-byte-parser

Absorbed. This package is a tombstone.

- `Byte.Input` was a hand-rolled array cursor. A standard-library slice is that cursor: `ArraySlice<Byte>` conforms to ``Cursor.`Protocol` `` through `Cursor Standard Library Integration` in swift-atoms/swift-cursor, with `next()` as `popFirst()` and the slice itself as the checkpoint.
- `Byte.Input(utf8:)` is `[Byte](utf8:)` and the string-literal sugar on `[Byte]` and `ArraySlice<Byte>`, both in `Byte Standard Library Integration` in swift-atoms/swift-byte.
- `Byte.Parser` was the length-one case of `[Byte].Parser` in swift-molecules/swift-iterator-parser.
- `Parseable.init(ascii:)` is `ASCII.Parseable` in swift-molecules/swift-ascii-parser.
- `String(decoding:as:)` over a collection of `Byte` lives in `Byte Standard Library Integration`.
