public import Byte
public import Byte_Protocol
public import Cursor_Parser_First
public import Either
public import Iterator
public import Iterator_Protocol
public import Parser
public import Parser_Match

extension Byte.Literal {

    public struct Parser<Input: Iterator.`Protocol`>
    where Input.Element == Byte, Input.Failure == Never {
        @usableFromInline
        let bytes: [Byte]

        @inlinable
        public init(_ bytes: [Byte]) {
            self.bytes = bytes
        }

        @inlinable
        public init(_ string: StaticString) {
            unsafe (self.bytes = string.utf8Start.withMemoryRebound(
                to: UInt8.self,
                capacity: string.utf8CodeUnitCount
            ) { ptr in
                let buf = unsafe UnsafeBufferPointer(start: ptr, count: string.utf8CodeUnitCount)
                var typed: [Byte] = []
                typed.reserveCapacity(buf.count)

                for unsafe byte in unsafe buf { typed.append(Byte(byte)) }
                return typed
            })
        }
    }
}

extension Byte.Literal.Parser: Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Either<
        Parser.EndOfInput.Error, Parser.Match.Error
    >

    public typealias Body = Never

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        for expected in bytes {
            guard let actual = input.next() else {
                throw .left(
                    .unexpected(
                        expected:
                            "byte 0x\(String(expected.underlying, radix: 16, uppercase: true))"
                    )
                )
            }
            guard actual == expected else {
                throw .right(
                    .byteMismatch(expected: [expected.underlying], found: [actual.underlying])
                )
            }
        }
    }
}

extension Byte.Literal.Parser: ExpressibleByStringLiteral {

    @inlinable
    public init(stringLiteral value: String) {
        var typed: [Byte] = []
        for byte in value.utf8 { typed.append(Byte(byte)) }
        self.bytes = typed
    }
}

extension Byte.Literal.Parser: ExpressibleByUnicodeScalarLiteral {

    @inlinable
    public init(unicodeScalarLiteral value: Unicode.Scalar) {
        var typed: [Byte] = []
        for byte in String(value).utf8 { typed.append(Byte(byte)) }
        self.bytes = typed
    }
}

extension Byte.Literal.Parser: ExpressibleByExtendedGraphemeClusterLiteral {

    @inlinable
    public init(extendedGraphemeClusterLiteral value: Character) {
        var typed: [Byte] = []
        for byte in String(value).utf8 { typed.append(Byte(byte)) }
        self.bytes = typed
    }
}
