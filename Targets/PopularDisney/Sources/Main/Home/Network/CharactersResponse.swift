import Foundation
struct CharactersResponse: Codable, Equatable {
    let data: [CharactersResponse.Data]
    
    struct Data: Codable, Identifiable, Hashable {
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
        
#if DEBUG
        init(id: Int,
             films: [String],
             parkAttractions: [String],
             imageUrl: URL,
             name: String) {
            self.id = id
            self.films = films
            self.parkAttractions = parkAttractions
            self.imageUrl = imageUrl
            self.name = name
        }
#endif
    }
}
