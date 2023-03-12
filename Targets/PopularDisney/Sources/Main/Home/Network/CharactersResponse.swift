import Foundation
struct CharactersResponse: Codable, Equatable {
    let data: [CharactersData]

    struct CharactersData: Codable, Identifiable, Hashable {
        let id: Int
        let films: [String]
        let parkAttractions: [String]
        let imageUrl: URL
        let name: String

        enum CodingKeys: String, CodingKey {
            case id = "_id"
            case films
            case parkAttractions
            case imageUrl
            case name
        }

        init(from decoder: Decoder) throws {
            let container: KeyedDecodingContainer<CharactersResponse.CharactersData.CodingKeys> = try decoder.container(keyedBy: CharactersResponse.CharactersData.CodingKeys.self)
            id = try container.decode(Int.self,
                                      forKey: CharactersResponse.CharactersData.CodingKeys.id)
            films = try container.decode([String].self,
                                         forKey: CharactersResponse.CharactersData.CodingKeys.films)
            parkAttractions = try container.decode([String].self,
                                                   forKey: CharactersResponse.CharactersData.CodingKeys.parkAttractions)
            imageUrl = try container.decode(URL.self,
                                            forKey: CharactersResponse.CharactersData.CodingKeys.imageUrl)
            name = try container.decode(String.self,
                                        forKey: CharactersResponse.CharactersData.CodingKeys.name)
        }

        #if DEBUG
            init(id: Int,
                 films: [String],
                 parkAttractions: [String],
                 imageUrl: URL,
                 name: String)
            {
                self.id = id
                self.films = films
                self.parkAttractions = parkAttractions
                self.imageUrl = imageUrl
                self.name = name
            }
        #endif
    }
}
