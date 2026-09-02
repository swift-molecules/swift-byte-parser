public import Byte
public import Collection

extension Swift.String {

    @_disfavoredOverload
    @inlinable
    public init<C: Collection.`Protocol`>(
        decoding bytes: borrowing C,
        as encoding: Swift.UTF8.Type
    ) where C.Element == Byte {
        var raw: [UInt8] = []
        var index = bytes.startIndex
        while index < bytes.endIndex {
            raw.append(bytes[index].bitPattern)
            bytes.formIndex(after: &index)
        }
        self.init(decoding: raw, as: encoding)
    }
}
