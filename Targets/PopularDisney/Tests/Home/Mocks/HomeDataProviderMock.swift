import Combine
import Foundation
@testable import PopularDisney

final class HomeDataProviderMock: HomeDataProviderType {
    var charactersPublisher: Published<[PopularDisney.CharactersResponse.CharactersData]>.Publisher {
        $fetchedCharacters
    }

    @Published var fetchedCharacters: [PopularDisney.CharactersResponse.CharactersData] = []

    // used to inject default values for testing
    var characters: [PopularDisney.CharactersResponse.CharactersData]

    init(characters: [PopularDisney.CharactersResponse.CharactersData]) {
        self.characters = characters
    }

    func fetchCharacters(usingCache _: Bool) async throws {
        Task {
            self.fetchedCharacters = characters
                .sorted(by: {
                    ($0.films.count + $0.parkAttractions.count) >
                        ($1.films.count + $1.parkAttractions.count)
                })
        }
    }
}
