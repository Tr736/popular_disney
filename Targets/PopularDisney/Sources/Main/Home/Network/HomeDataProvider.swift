import Foundation
import PopularDisneyKit

protocol HomeDataProviderType {
    var charactersPublisher: Published<[CharactersResponse.CharactersData]>.Publisher { get }
    func fetchCharacters(usingCache: Bool) async throws
}

final class HomeDataProvider: HomeDataProviderType {
    private enum Constants {
        static let cacheKey = "CharacterCacheKey"
    }

    private let api: APIType
    private let cache = Cache<String, [CharactersResponse.CharactersData]>()

    var charactersPublisher: Published<[CharactersResponse.CharactersData]>.Publisher {
        $characters
    }

    @Published private var characters = [CharactersResponse.CharactersData]()

    init(api: APIType = ConcreteAPI()) {
        self.api = api
    }

    func fetchCharacters(usingCache: Bool) async throws {
        // return cache first if it exists
        if usingCache,
           let cached = try? fetchFromCache()
        {
            await update(characters: cached)
        }

        // API Call
        let request = CharactersRequest()
        let characters = try await api.execute(apiRequest: request)
            .data
        await update(characters: characters)

        if usingCache {
            try saveToCache(characters)
        }
    }

    @MainActor
    private func update(characters: [CharactersResponse.CharactersData]) {
        self.characters = characters
            .sorted(by: {
                ($0.films.count + $0.parkAttractions.count) >
                    ($1.films.count + $1.parkAttractions.count)
            })
    }

    private func saveToCache(_ characters: [CharactersResponse.CharactersData]) throws {
        cache.removeValue(forKey: Constants.cacheKey)
        cache.insert(characters, forKey: Constants.cacheKey)
        try cache.saveToDisk(withName: Constants.cacheKey)
    }

    private func fetchFromCache() throws -> [CharactersResponse.CharactersData]? {
        let data = try cache.fetchFromDisk(withName: Constants.cacheKey)

        let decoder = JSONDecoder()
        let decodedObject = try decoder.decode(Cache<String,
            [CharactersResponse.CharactersData]>.self,
        from: data)
        return decodedObject.value(forKey: Constants.cacheKey)
    }
}
