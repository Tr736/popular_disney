@testable import PopularDisney
import XCTest
final class EndpointTests: XCTestCase {
    private enum Constants {
        static let baseURL = "https://api.disneyapi.dev/"
        static let characters = "characters"
    }

    func test_baseURL_expectMatching() {
        XCTAssertEqual(Endpoints.baseURL, Constants.baseURL)
    }

    func test_charactersPath_expectMatching() {
        XCTAssertEqual(Endpoints.Paths.characters, Constants.characters)
    }
}
