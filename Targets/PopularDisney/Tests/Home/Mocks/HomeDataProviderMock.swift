import Combine
import Foundation
@testable import PopularDisney

final class HomeDataProviderMock: HomeDataProviderType {
    var charactersPublisher: Published<[CharactersResponse.Data]>.Publisher {
        $fetchedCharacters
    }

    @Published var fetchedCharacters: [CharactersResponse.Data] = []

    // used to inject default values for testing
    private var characters: [CharactersResponse.Data]

    init(characters: [CharactersResponse.Data]) {
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
