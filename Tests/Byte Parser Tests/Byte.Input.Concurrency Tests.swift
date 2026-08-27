import Byte_Parser_Test_Support
import Testing

private let basePattern: [Byte] = [0x41, 0x42, 0x43, 0x44]

private func makePattern(repeats: Int) -> [Byte] {
    var out: [Byte] = []
    out.reserveCapacity(repeats * basePattern.count)
    for _ in 0..<repeats { out.append(contentsOf: basePattern) }
    return out
}

private func mismatch(for expected: Byte) -> Byte {
    expected == 0x00 ? 0x01 : 0x00
}

@Suite
struct `Byte.Input Concurrency Tests` {
    @Suite struct Unit {}
    @Suite struct `Edge Case` {}
    @Suite struct Integration {}
}

extension `Byte.Input Concurrency Tests`.Integration {

    @Test(arguments: [4, 16])
    func `concurrent backtracking parses never disturb the shared source`(width: Int) async {
        let pattern = makePattern(repeats: 10)
        let source = Byte.Input(pattern)
        let outcomes = await withTaskGroup(of: Bool.self, returning: [Bool].self) { group in
            for _ in 0..<width {
                group.addTask {
                    var mine = source
                    var good = true
                    for expected in pattern {

                        var probe = mine
                        let failed: Bool
                        do throws(Byte.Parser<Byte.Input>.Failure) {
                            try Byte.Parser<Byte.Input>(mismatch(for: expected)).parse(&probe)
                            failed = false
                        } catch {
                            failed = true
                        }
                        good = good && failed
                        good = good && (mine.first == expected)
                        let advanced: Bool
                        do throws(Byte.Parser<Byte.Input>.Failure) {
                            try Byte.Parser<Byte.Input>(expected).parse(&mine)
                            advanced = true
                        } catch {
                            advanced = false
                        }
                        good = good && advanced
                    }
                    return good && mine.isEmpty
                }
            }
            var out: [Bool] = []
            for await ok in group { out.append(ok) }
            return out
        }
        #expect(outcomes.count == width)
        #expect(outcomes.allSatisfy { $0 })
        #expect(source.first == 0x41)
        #expect(!source.isEmpty)
    }

    @Test
    func `concurrent slices diverge by value at distinct depths`() async {
        let pattern = makePattern(repeats: 8)
        let source = Byte.Input(pattern)
        let outcomes = await withTaskGroup(of: Bool.self, returning: [Bool].self) { group in
            (0..<16).forEach { depth in
                group.addTask {
                    var mine = source
                    var good = true
                    (0..<depth).forEach { i in
                        let advanced: Bool
                        do throws(Byte.Parser<Byte.Input>.Failure) {
                            try Byte.Parser<Byte.Input>(pattern[i]).parse(&mine)
                            advanced = true
                        } catch {
                            advanced = false
                        }
                        good = good && advanced
                    }
                    good = good && (mine.first == pattern[depth])
                    return good
                }
            }
            var out: [Bool] = []
            for await ok in group { out.append(ok) }
            return out
        }
        #expect(outcomes.count == 16)
        #expect(outcomes.allSatisfy { $0 })
        #expect(source.first == 0x41)
    }
}
