import Foundation

class MegaData {
    var smallArray: [Float]
    var bigArray: [Double]

    init() {
        smallArray = Array(repeating: 42.0, count: 1024)
        bigArray = Array(repeating: 42.0, count: 512 * 512)
    }

    func reset() {
        smallArray = Array(repeating: 42.0, count: 1024)
        bigArray = Array(repeating: 42.0, count: 512 * 512)
    }
}

class MegaDataPool {
    private var pool: [MegaData]
    private var usedObjects: Int = 0

    enum PoolError: Error {
        case poolIsFull
        case noObjectsToRelease
    }

    init(poolSize: Int) {
        pool = Array(repeating: MegaData(), count: poolSize)
    }

    func acquire() throws -> MegaData {
        if usedObjects < pool.count {
            usedObjects += 1
            return pool[usedObjects - 1]
        } else {
            throw PoolError.poolIsFull
        }
    }

    func release(data: MegaData) throws {
        if usedObjects > 0 {
            usedObjects -= 1
            data.reset()
        } else {
            throw PoolError.noObjectsToRelease
        }
    }

    var size: Int { return pool.count }

    var usedSize: Int { return usedObjects }
}

