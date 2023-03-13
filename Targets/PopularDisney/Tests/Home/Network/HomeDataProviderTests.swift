@testable import PopularDisney
import XCTest
final class HomeDataProviderTests: XCTestCase {
    private var sut: HomeDataProvider!
    private var mockAPI: MockAPI!
    let mickey = CharactersResponse.Data(id: 1,
                                         films: ["Fantasia"],
                                         parkAttractions: ["DLP", "DWA", "DLJ"],
                                         imageUrl: URL(string: "https://www.google.com")!,
                                         name: "Mickey")

    let goofy = CharactersResponse.Data(id: 2,
                                        films: [],
                                        parkAttractions: [],
                                        imageUrl: URL(string: "https://www.google.com")!,
                                        name: "Goofy")

    let donald = CharactersResponse.Data(id: 3,
                                         films: ["Rescue Rangers"],
                                         parkAttractions: [],
                                         imageUrl: URL(string: "https://www.google.com")!,
                                         name: "Donald")

    override func tearDown() {
        mockAPI = nil
        sut = nil
        super.tearDown()
    }

    func test_FetchCharacters_expectMickeyFirstGoofyLast() async throws {
        // Given
        let data = try encodedData()
        mockAPI = MockAPI(data: data,
                          statusCode: 200)
        sut = HomeDataProvider(api: mockAPI)
        // When
        try await sut.fetchCharacters(usingCache: false)

        try await MainActor.run {
            let items = try awaitPublisher(
                sut.charactersPublisher
                    .first()
            )
            // Then
            XCTAssertEqual(items.count, 3)
            XCTAssertEqual(items.first, mickey)
            XCTAssertEqual(items.last, goofy)
        }
    }

    private func encodedData() throws -> Data {
        let characters = CharactersResponse(data: [
            goofy,
            mickey,
            donald,
        ])

        let jsonEncoder = JSONEncoder()
        return try jsonEncoder.encode(characters)
    }
}
