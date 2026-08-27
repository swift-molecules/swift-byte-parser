public import Array_Primitive
public import Array
public import Buffer_Linear_Primitive
public import Buffer_Linear
import Byte
import Column
public import Input
public import Memory_Allocator_Primitive
public import Memory_Heap
public import Ownership_Shared_Primitive
public import Storage_Contiguous

extension Byte {

    public typealias Input = Input.Input.Slice<Array<Byte>.Shared>
}

extension Input.Input.Slice where Base == Array<Byte>.Shared {

    @inlinable
    public init(_ bytes: [Byte]) {

        var storage = Array<Byte>.Shared()
        for byte in bytes {
            storage.append(byte)
        }
        self = Input.Slice(storage)
    }

    @inlinable
    public init<Bytes: Swift.Collection>(_ bytes: Bytes) where Bytes.Element == Byte {
        self.init(Swift.Array(bytes))
    }

    @_disfavoredOverload
    @inlinable
    public init(_ bytes: [UInt8]) {

        var storage = Array<Byte>.Shared()
        for byte in bytes {
            storage.append(Byte(byte))
        }
        self = Input.Slice(storage)
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

    @inlinable
    public func starts<Prefix: Swift.Collection>(with prefix: Prefix) -> Bool
    where Prefix.Element == Byte {
        var copy = self
        return copy.access.starts(with: prefix)
    }
}
