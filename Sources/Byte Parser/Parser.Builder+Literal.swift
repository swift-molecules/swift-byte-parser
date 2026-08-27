public import Byte
public import Parser

extension Parser.Builder
where Input: __ParserInput.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}

extension Parser.Take.Builder
where Input: __ParserInput.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser.Take.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}
