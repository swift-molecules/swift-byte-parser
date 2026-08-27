import Byte_Parser_Test_Support
import Testing

@Suite
struct `Cursor Byte Tests` {
    @Suite struct Unit {
        @Suite struct `Starts With` {}
        @Suite struct `Copy To Owned` {}
    }
    @Suite struct `Edge Case` {
        @Suite struct `Starts With` {}
        @Suite struct `Copy To Owned` {}
    }
    @Suite struct Integration {}
}

extension `Cursor Byte Tests`.Unit.`Starts With` {

    @Test
    func `returns true for matching prefix`() {
        let bytes: [Byte] = [0x01, 0x02, 0x03, 0x04]

        let result = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            let view = Cursor<Byte>(span)
            return view.starts(with: [0x01, 0x02] as [Byte])
        }

        #expect(result)
    }

    @Test
    func `returns false for non-matching prefix`() {
        let bytes: [Byte] = [0x01, 0x02, 0x03]

        let result = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            let view = Cursor<Byte>(span)
            return view.starts(with: [0x01, 0x03] as [Byte])
        }

        #expect(!result)
    }
}

extension `Cursor Byte Tests`.`Edge Case`.`Starts With` {

    @Test
    func `returns true for empty prefix on any view`() {
        let bytes: [Byte] = [0x01, 0x02]

        let result = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            let view = Cursor<Byte>(span)
            return view.starts(with: [] as [Byte])
        }

        #expect(result)
    }

    @Test
    func `returns false when prefix exceeds remaining`() {
        let bytes: [Byte] = [0x01]

        let result = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            let view = Cursor<Byte>(span)
            return view.starts(with: [0x01, 0x02] as [Byte])
        }

        #expect(!result)
    }
}

extension `Cursor Byte Tests`.Unit.`Copy To Owned` {

    @Test
    func `creates independent owned input from fresh view`() {
        let bytes: [Byte] = [0x01, 0x02, 0x03, 0x04]

        let (ownedCount, ownedFirst) = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            let view = Cursor<Byte>(span)
            let owned = view.owned()
            return (owned.count, owned.first)
        }

        #expect(ownedCount == 4)
        #expect(ownedFirst == 0x01)
    }
}

extension `Cursor Byte Tests`.`Edge Case`.`Copy To Owned` {

    @Test
    func `copies only the remaining bytes after partial consumption`() {
        let bytes: [Byte] = [0x01, 0x02, 0x03, 0x04]

        let (ownedCount, ownedFirst) = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            var view = Cursor<Byte>(span)

            _ = view.consume()
            let owned = view.owned()

            return (owned.count, owned.first)
        }

        #expect(ownedCount == 3)
        #expect(ownedFirst == 0x02)
    }
}

extension `Cursor Byte Tests`.Integration {

    @Test
    func `parse fixed-width integer via Cursor`() {
        let bytes: [Byte] = [0xDE, 0xAD, 0xBE, 0xEF]

        let (value, isAtEnd) = unsafe bytes.withUnsafeBufferPointer { buffer in
            let span = unsafe Span(_unsafeElements: buffer)
            var view = Cursor<Byte>(span)

            let b0 = view.consume().underlying
            let b1 = view.consume().underlying
            let b2 = view.consume().underlying
            let b3 = view.consume().underlying

            let value =
                UInt32(b0) << 24
                | UInt32(b1) << 16
                | UInt32(b2) << 8
                | UInt32(b3)

            return (value, view.isAtEnd)
        }

        #expect(value == 0xDEAD_BEEF)
        #expect(isAtEnd)
    }
}
