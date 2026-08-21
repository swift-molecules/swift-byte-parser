public import Byte_Primitives
public import Parser_Primitives
public import Parser_Take_Primitives

extension Parser_Primitives.Parser.Builder
where Input: Input_Primitives.Input.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser_Primitives.Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser_Primitives.Parser.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}

extension Parser_Primitives.Parser.Take.Builder
where Input: Input_Primitives.Input.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser_Primitives.Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser_Primitives.Parser.Take.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}
