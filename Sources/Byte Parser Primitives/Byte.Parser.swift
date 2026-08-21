public import Byte_Primitives
public import Either_Primitives
public import Parser_EndOfInput_Primitives
public import Parser_Match_Primitives
public import Parser_Primitives

extension Byte {

    public struct Parser<Input: Input_Primitives.Input.Streaming>
    where Input.Element == Byte {
        @usableFromInline
        let expected: Byte

        @inlinable
        public init(_ expected: Byte) {
            self.expected = expected
        }
    }
}

extension Byte.Parser: Parser_Primitives.Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Either<
        Parser_Primitives.Parser.EndOfInput.Error, Parser_Primitives.Parser.Match.Error
    >

    public typealias Body = Never

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        guard !input.isEmpty else {
            throw .left(
                .unexpected(
                    expected: "byte 0x\(String(expected.underlying, radix: 16, uppercase: true))"
                )
            )
        }

        let actual = try! input.advance()
        guard actual == expected else {
            throw .right(.byteMismatch(expected: [expected.underlying], found: [actual.underlying]))
        }
    }
}
