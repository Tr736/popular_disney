import Combine
import Foundation
protocol HomeViewModelType: ObservableObject {
    var itemsPublisher: Published<[CharactersResponse.CharactersData]>.Publisher { get }

    func fetchCharacters() async
    func popularity(_ item: CharactersResponse.CharactersData) -> Int
}

final class HomeViewModel: HomeViewModelType {
    private let dataProvider: HomeDataProviderType
    private var cancellable = [AnyCancellable]()

    var itemsPublisher: Published<[CharactersResponse.CharactersData]>.Publisher {
        dataProvider.charactersPublisher
    }

    init(dataProvider: HomeDataProviderType) {
        self.dataProvider = dataProvider
    }

    func fetchCharacters() async {
        do {
            try await self.dataProvider.fetchCharacters(usingCache: true)
        } catch {
            // TODO: Error Handling
        }
    }

    func popularity(_ item: CharactersResponse.CharactersData) -> Int {
        item.films
            .filter { !$0.isEmpty }
            .count +
            item.parkAttractions
            .filter { !$0.isEmpty }
            .count
    }
}
