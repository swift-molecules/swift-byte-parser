public import Byte
public import Byte_Protocol
public import Collection

extension Swift.String {

    @_disfavoredOverload
    @inlinable
    public init<C: Collection.`Protocol`>(
        decoding bytes: borrowing C,
        as encoding: Swift.UTF8.Type
    ) where C.Element: Byte.`Protocol` {
        var raw: [UInt8] = []
        var index = bytes.startIndex
        while index < bytes.endIndex {
            raw.append(bytes[index].byte.underlying)
            bytes.formIndex(after: &index)
        }
        self.init(decoding: raw, as: encoding)
    }
}
