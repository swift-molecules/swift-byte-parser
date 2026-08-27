import Byte
public import Input

public typealias __ByteParserInput = Input

extension Byte {

    public struct Input {

        @usableFromInline
        let storage: ContiguousArray<Byte>

        @usableFromInline
        var position: Int

        @inlinable
        public init(_ bytes: [Byte]) {
            self.storage = ContiguousArray(bytes)
            self.position = 0
        }

        @inlinable
        public init<Bytes: Swift.Collection>(_ bytes: Bytes) where Bytes.Element == Byte {
            self.init(Swift.Array(bytes))
        }

        @_disfavoredOverload
        @inlinable
        public init(_ bytes: [UInt8]) {
            self.storage = ContiguousArray(bytes.lazy.map(Byte.init))
            self.position = 0
        }

        @inlinable
        public init(utf8 string: Swift.String) {
            self.init([UInt8](string.utf8))
        }

        @_disfavoredOverload
        @inlinable
        public init<Bytes: Swift.Collection>(_ bytes: Bytes) where Bytes.Element == UInt8 {
            self.init(Swift.Array(bytes))
        }

        @_disfavoredOverload
        @inlinable
        public init(_ bytes: ArraySlice<UInt8>) {
            self.init(Swift.Array(bytes))
        }
    }
}

extension Byte.Input: __ByteParserInput.`Protocol` {

    public typealias Checkpoint = Int

    public typealias Element = Byte

    @inlinable
    public var count: Int { storage.count - position }

    @inlinable
    public var isEmpty: Bool { position >= storage.count }

    @inlinable
    public var first: Byte? { isEmpty ? nil : storage[position] }

    @inlinable
    public var checkpoint: Checkpoint { position }

    @inlinable
    public var bounds: ClosedRange<Checkpoint> { 0...storage.count }

    @inlinable
    @discardableResult
    public mutating func advance() throws(__ByteParserInput.Stream.Error) -> Byte {
        guard !isEmpty else { throw .empty }
        let byte = storage[position]
        position += 1
        return byte
    }

    @inlinable
    public mutating func advance(by count: Int) {
        precondition(count >= 0 && count <= self.count)
        position += count
    }

    @inlinable
    public mutating func seek(to checkpoint: Checkpoint) {
        precondition(bounds.contains(checkpoint))
        position = checkpoint
    }
}

extension Byte.Input: __ByteParserInput.Access.Random {

    @inlinable
    public subscript(offset offset: Int) -> Byte {
        storage[position + offset]
    }
}

extension Byte.Input: Sendable {}
