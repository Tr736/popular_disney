@testable import PopularDisneyKit
import XCTest

final class CacheTests: XCTestCase {
    private enum Constants {
        static let name: String = "Homer"
        static let age: Int = 44
    }

    private var sut: Cache<String, User>!

    override func setUp() {
        sut = Cache()
        super.setUp()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_maximumEntryCount_expectTwo() {
        // Given
        let sut: Cache<String, User> = Cache(maximumEntryCount: 2)
        // Then
        XCTAssertEqual(sut.countLimit,
                       2)
    }

    func test_maximumEntryCountDefault_expectFifty() {
        XCTAssertEqual(sut.countLimit,
                       50)
    }

    func test_insertValue_expectOneKey() {
        // Given
        let id = UUID().uuidString
        let key = "SingleKey"
        // When
        sut.insert(User(id: id,
                        name: Constants.name,
                        age: Constants.age),
                   forKey: key)
        // Then
        XCTAssertEqual(sut.keys.count, 1)
    }

    func test_insertValue_expectFourKeys() {
        // Given
        let id = UUID().uuidString
        let keys: Set<String> = ["A",
                                 "B",
                                 "C", "C",
                                 "D"]
        keys.forEach {
            // When
            sut.insert(User(id: id,
                            name: Constants.name,
                            age: Constants.age),
                       forKey: $0)
        }
        // Then
        XCTAssertEqual(sut.keys.count, 4)
    }

    func test_removeKeys_expectTwo() {
        // Given
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
        // When
        sut.removeValue(forKey: "C")
        // Then
        XCTAssertEqual(sut.keys.count, 2)
    }

    func test_saveToDisk_expectNoErrors() {
        // Given
        let id = UUID().uuidString
        let user = User(id: id,
                        name: Constants.name,
                        age: Constants.age)
        let key = "SingleKey"

        sut.removeValue(forKey: key)
        sut.insert(user, forKey: key)
        do {
            // When
            try sut.saveToDisk(withName: key)
        } catch {
            XCTFail("test_saveToDisk_expectNoErrors failed with \(error.localizedDescription)")
        }
    }

    func test_FetchFromDisk_expectDataNotNil() {
        // TODO: Improve this test. We should mock filemanager to avoid writing to disk as this can lead to unintended behaviour and flaky tests.
        // Given
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
            // When
            let data = try sut.fetchFromDisk(withName: key)
            // Then
            XCTAssertNotNil(data)
        } catch {
            XCTFail("test_FetchFromDisk failed with \(error.localizedDescription)")
        }
    }
}
