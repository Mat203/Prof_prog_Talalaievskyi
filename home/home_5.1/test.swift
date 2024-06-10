import XCTest

class MegaDataPoolTests: XCTestCase {
    
    func testAcquireReleaseNormal() {
        let pool = MegaDataPool(poolSize: 3)
        do {
            let obj1 = try pool.acquire()
            try pool.release(data: obj1)
            XCTAssertEqual(pool.usedSize, 0)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testAcquirePoolFull() {
        let pool = MegaDataPool(poolSize: 2)
        do {
            _ = try pool.acquire()
            _ = try pool.acquire()
            XCTAssertEqual(pool.usedSize, 2)
            _ = try pool.acquire()
            XCTFail("Acquire from a full pool error")
        } catch MegaDataPool.PoolError.poolIsFull {
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testReleaseTooMany() {
        let pool = MegaDataPool(poolSize: 2)
        do {
            let obj1 = try pool.acquire()
            try pool.release(data: obj1)
            try pool.release(data: obj1)
            XCTFail("Releasing more obj error")
        } catch MegaDataPool.PoolError.noObjectsToRelease {
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testDataPersistenceAfterRelease() {
        let pool = MegaDataPool(poolSize: 1)
        do {
            var obj1 = try pool.acquire()
            obj1.smallArray[0] = 12.34
            try pool.release(data: obj1)

            let obj2 = try pool.acquire()
            XCTAssertEqual(obj2.smallArray[0], 42.0)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }

    func testPoolSize() {
        let pool = MegaDataPool(poolSize: 10)
        XCTAssertEqual(pool.size, 10)
    }

    func testInitialUsedSize() {
        let pool = MegaDataPool(poolSize: 5)
        XCTAssertEqual(pool.usedSize, 0)
    }

    func testAcquireMultipleReleaseInOrder() {
        let pool = MegaDataPool(poolSize: 3)
        do {
            let obj1 = try pool.acquire()
            let obj2 = try pool.acquire()
            let obj3 = try pool.acquire()

            try pool.release(data: obj1)
            XCTAssertEqual(pool.usedSize, 2)

            try pool.release(data: obj2)
            XCTAssertEqual(pool.usedSize, 1)

            try pool.release(data: obj3)
            XCTAssertEqual(pool.usedSize, 0)
        } catch {
            XCTFail("Unexpected error thrown: \(error)")
        }
    }
}

