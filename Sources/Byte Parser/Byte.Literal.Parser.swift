internal import Array
public import Byte
public import Either
public import Parser_EndOfInput
public import Parser_Match
public import Parser

extension Byte.Literal {

    public struct Parser<Input: Input.Input.Streaming>
    where Input.Element == Byte {
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

extension Byte.Literal.Parser: Parser.Parser.`Protocol` {

    public typealias Output = Void

    public typealias Failure = Either<
        Parser.Parser.EndOfInput.Error, Parser.Parser.Match.Error
    >

    public typealias Body = Never

    @inlinable
    public func parse(_ input: inout Input) throws(Failure) {
        for expected in bytes {
            guard !input.isEmpty else {
                throw .left(
                    .unexpected(
                        expected:
                            "byte 0x\(String(expected.underlying, radix: 16, uppercase: true))"
                    )
                )
            }

            let actual = try! input.advance()
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
