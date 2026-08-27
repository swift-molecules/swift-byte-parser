public import Byte
public import Parser

extension Parseable
where
    Parser.Input == Byte.Input,
    Parser.Output == Self
{

    @inlinable
    public init(ascii: [UInt8]) throws(Parser.Failure) {
        var input = Byte.Input(ascii)
        self = try Self.parser.parse(&input)
    }
}
