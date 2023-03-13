import Combine
import Foundation
protocol HomeViewModelType: ObservableObject {
    var itemsPublisher: Published<[CharactersResponse.Data]>.Publisher { get }

    func fetchCharacters() async
    func popularity(_ item: CharactersResponse.Data) -> Int
}

final class HomeViewModel: HomeViewModelType {
    private let dataProvider: HomeDataProviderType

    var itemsPublisher: Published<[CharactersResponse.Data]>.Publisher {
        dataProvider.charactersPublisher
    }

    init(dataProvider: HomeDataProviderType) {
        self.dataProvider = dataProvider
    }

    func fetchCharacters() async {
        do {
            try await dataProvider.fetchCharacters(usingCache: true)
        } catch {
            // TODO: Error Handling
        }
    }

    func popularity(_ item: CharactersResponse.Data) -> Int {
        item.films
            .filter { !$0.isEmpty }
            .count +
        item.parkAttractions
            .filter { !$0.isEmpty }
            .count
    }
}
