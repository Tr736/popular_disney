@testable import PopularDisney
import XCTest
final class HomeDataProviderTests: XCTestCase {
    private var sut: HomeDataProvider!
    private var mockAPI: MockAPI!
    let mickey = CharactersResponse.CharactersData(id: 1,
                                                   films: ["Fantasia"],
                                                   parkAttractions: ["DLP", "DWA", "DLJ"],
                                                   imageUrl: URL(string: "https://www.google.com")!,
                                                   name: "Mickey")

    let goofy = CharactersResponse.CharactersData(id: 2,
                                                  films: [],
                                                  parkAttractions: [],
                                                  imageUrl: URL(string: "https://www.google.com")!,
                                                  name: "Goofy")

    let donald = CharactersResponse.CharactersData(id: 3,
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
        mockAPI = MockAPI(data: encodedData(),
                          statusCode: 200)
        sut = HomeDataProvider(api: mockAPI)

        try! await sut.fetchCharacters(usingCache: false)

        try await MainActor.run(body: {
            let items = try awaitPublisher(
                sut.charactersPublisher
                    .first()
            )
            XCTAssertEqual(items.count, 3)
            XCTAssertEqual(items.first, mickey)
            XCTAssertEqual(items.last, goofy)
        })
    }

    private func encodedData() -> Data {
        let characters = CharactersResponse(data: [
            goofy,
            mickey,
            donald,
        ])

        let jsonEncoder = JSONEncoder()

        return try! jsonEncoder.encode(characters)
    }
}
