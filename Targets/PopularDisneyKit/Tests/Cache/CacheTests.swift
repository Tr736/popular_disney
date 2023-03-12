@testable import PopularDisneyKit
import XCTest

final class CacheTests: XCTestCase {
    private enum Constants {
        static let name: String = "Homer"
        static let age: Int = 44
    }

    private var sut: Cache<String, User>!

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_maximumEntryCount_expectTwo() {
        sut = Cache(maximumEntryCount: 2)
        XCTAssertEqual(sut.countLimit,
                       2)
    }

    func test_maximumEntryCountDefault_expectFifty() {
        sut = Cache()
        XCTAssertEqual(sut.countLimit,
                       50)
    }

    func test_insertValue_expectOneKey() {
        sut = Cache()
        let id = UUID().uuidString
        let key = "SingleKey"
        sut.insert(User(id: id,
                        name: Constants.name,
                        age: Constants.age),
                   forKey: key)

        XCTAssertEqual(sut.keys.count, 1)
    }

    func test_insertValue_expectFourKeys() {
        sut = Cache()
        let id = UUID().uuidString
        let keys: Set<String> = ["A",
                                 "B",
                                 "C", "C",
                                 "D"]
        keys.forEach {
            sut.insert(User(id: id,
                            name: Constants.name,
                            age: Constants.age),
                       forKey: $0)
        }

        XCTAssertEqual(sut.keys.count, 4)
    }

    func test_removeKeys_expectTwo() {
        sut = Cache()
        let id = UUID().uuidString
        let keys: Set<String> = ["A",
                                 "B",
                                 "C"]
        keys.forEach {
            sut.insert(User(id: id,
                            name: Constants.name,
                            age: Constants.age),
                       forKey: $0)
        }

        sut.removeValue(forKey: "C")
        XCTAssertEqual(sut.keys.count, 2)
    }

    func test_saveToDisk_expectNoErrors() {
        sut = Cache()
        let id = UUID().uuidString
        let user = User(id: id,
                        name: Constants.name,
                        age: Constants.age)
        let key = "SingleKey"

        sut.removeValue(forKey: key)
        sut.insert(user, forKey: key)
        do {
            try sut.saveToDisk(withName: key)
        } catch {
            XCTFail("test_saveToDisk_expectNoErrors failed with \(error.localizedDescription)")
        }
    }

    func test_FetchFromDisk_expectToDecodeUser() {
        sut = Cache()
        let id = UUID().uuidString
        let user = User(id: id,
                        name: "Bart",
                        age: 12)
        let key = "LoadingKey"

        // First save user to cache and disk
        sut.removeValue(forKey: key)
        sut.insert(user, forKey: key)
        do {
            try sut.saveToDisk(withName: key)
        } catch {
            XCTFail("test_saveToDisk_expectNoErrors failed with \(error.localizedDescription)")
        }
        // Fetch saved user from disk
        do {
            let data = try sut.fetchFromDisk(withName: key)
            let decoder = JSONDecoder()
            let cache = try decoder.decode(Cache<String, User>.self,
                                           from: data)

            let user = cache.value(forKey: key)

            XCTAssertNotNil(user)
            XCTAssertEqual(user?.name, "Bart")
            XCTAssertEqual(user?.age, 12)
            XCTAssertEqual(user?.id, id)

        } catch {
            XCTFail("test_FetchFromDisk failed with \(error.localizedDescription)")
        }
    }
}
