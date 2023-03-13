@testable import PopularDisney
import XCTest

final class HomeViewModelTests: XCTestCase {
    private var sut: HomeViewModel!
    private var dataProvider: HomeDataProviderMock!
    
    override func tearDown() {
        dataProvider = nil
        sut = nil
        super.tearDown()
    }
    
    func test_FetchCharacters_expectOne() async throws {
        // Given
        let character = CharactersResponse.Data(id: 1,
                                                films: [],
                                                parkAttractions: [],
                                                imageUrl: URL(string: "https://www.google.com")!,
                                                name: "Mickey")
        dataProvider = HomeDataProviderMock(characters: [character])
        // When
        sut = HomeViewModel(dataProvider: dataProvider)
        await sut.fetchCharacters()
        
        try await MainActor.run {
            let items = try awaitPublisher(
                sut.itemsPublisher.first()
            )
            // Then
            XCTAssertEqual(items.count, 1)
        }
    }
    
    func test_popularity_expectFour() {
        // Given
        let mickey = CharactersResponse.Data(id: 1,
                                             films: ["Fantasia"],
                                             parkAttractions: ["DLP", "DWA", "DLJ"],
                                             imageUrl: URL(string: "https://www.google.com")!,
                                             name: "Mickey")
        dataProvider = HomeDataProviderMock(characters: [mickey])
        sut = HomeViewModel(dataProvider: dataProvider)
        // Then
        XCTAssertEqual(4, sut.popularity(mickey))
    }
    
    func test_popularity_expectZero() {
        // Given
        let mickey = CharactersResponse.Data(id: 1,
                                             films: [""],
                                             parkAttractions: [""],
                                             imageUrl: URL(string: "https://www.google.com")!,
                                             name: "Mickey")
        dataProvider = HomeDataProviderMock(characters: [mickey])
        sut = HomeViewModel(dataProvider: dataProvider)
        // Then
        XCTAssertEqual(0, sut.popularity(mickey))
    }
}
