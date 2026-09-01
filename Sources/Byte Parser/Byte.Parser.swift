public import Byte
public import Byte_Protocol
public import Cursor_Parser_First
public import Either
public import Iterator
public import Iterator_Protocol
public import Parser
public import Parser_Match

extension Byte {

    public struct Parser<Input: Iterator.`Protocol`>
    where Input.Element == Byte, Input.Failure == Never {
        @usableFromInline
        let expected: Byte

        @inlinable
        public init(_ expected: Byte) {
            self.expected = expected
        }
    }
}

extension Byte.Parser: Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Either<
        Parser.EndOfInput.Error, Parser.Match.Error
    >

    public typealias Body = Never

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        guard let actual = input.next() else {
            throw .left(
                .unexpected(
                    expected: "byte 0x\(String(expected.underlying, radix: 16, uppercase: true))"
                )
            )
        }
        guard actual == expected else {
            throw .right(.byteMismatch(expected: [expected.underlying], found: [actual.underlying]))
        }
    }
}
