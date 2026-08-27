public import Byte
public import Byte_Ownership
public import struct Cardinal.Cardinal
public import Cursor
public import Memory_Cursor
public import Span
public import struct Tagged.Tagged

extension Cursor where DomainTag == Byte {

    @inlinable
    public func starts(with prefix: some Swift.Sequence<some Byte.`Protocol`>) -> Bool {
        var rawOffset: UInt = 0
        for byte in prefix {
            let offset = Tagged<Byte, Cardinal>(_unchecked: Cardinal(rawOffset))
            guard let observed = peek(at: offset), observed == byte.byte else { return false }
            rawOffset += 1
        }
        return true
    }
}

extension Cursor where DomainTag == Byte {

    @inlinable
    public func owned() -> Byte.Input {
        var bytes: [Byte] = []
        let remaining = count.underlying.rawValue
        bytes.reserveCapacity(Int(bitPattern: remaining))
        var rawOffset: UInt = 0
        while rawOffset < remaining {
            let offset = Tagged<Byte, Cardinal>(_unchecked: Cardinal(rawOffset))
            guard let byte = peek(at: offset) else { break }
            bytes.append(byte)
            rawOffset += 1
        }
        return Byte.Input(bytes)
    }
}
