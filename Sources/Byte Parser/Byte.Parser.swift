public import Byte
public import Either
public import Parser_EndOfInput
public import Parser_Match
public import Parser

extension Byte {

    public struct Parser<Input: Input.Input.Streaming>
    where Input.Element == Byte {
        @usableFromInline
        let expected: Byte

        @inlinable
        public init(_ expected: Byte) {
            self.expected = expected
        }
    }
}

extension Byte.Parser: Parser.Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Either<
        Parser.Parser.EndOfInput.Error, Parser.Parser.Match.Error
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
