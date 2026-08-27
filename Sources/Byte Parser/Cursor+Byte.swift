public import Byte
public import Cursor
public import Memory_Cursor
public import Span_Protocol

extension Cursor where DomainTag == Byte {

    @inlinable
    public func starts(with prefix: some Swift.Sequence<some Byte.`Protocol`>) -> Bool {
        var offset: Tagged<Byte, Cardinal> = .zero
        for byte in prefix {
            guard let observed = peek(at: offset), observed == byte.byte else { return false }
            offset += .one
        }
        return true
    }
}

extension Cursor where DomainTag == Byte {

    @inlinable
    public func owned() -> Byte.Input {
        var bytes: [Byte] = []
        bytes.reserveCapacity(count)
        var offset: Tagged<Byte, Cardinal> = .zero
        while offset < count {
            guard let byte = peek(at: offset) else { break }
            bytes.append(byte)
            offset += .one
        }
        return Byte.Input(bytes.map(\.underlying))
    }
}
