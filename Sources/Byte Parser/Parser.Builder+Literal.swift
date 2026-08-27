public import Byte
public import Parser
public import Parser_Take

extension Parser.Parser.Builder
where Input: Input.Input.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser.Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser.Parser.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}

extension Parser.Parser.Take.Builder
where Input: Input.Input.Streaming, Input.Element == Byte {

    @inlinable
    public static func buildExpression(
        _ literal: Byte.Literal.Parser<Input>
    ) -> Byte.Literal.Parser<Input> {
        literal
    }

    @inlinable
    public static func buildExpression<P: Parser.Parser.`Protocol`>(
        _ parser: P
    ) -> P where P.Input == Input {
        parser
    }
}

extension Parser.Parser.Take.Builder where Input == ArraySlice<Byte> {

    @inlinable
    public static func buildExpression(_ bytes: [Byte]) -> [Byte] {
        bytes
    }
}
