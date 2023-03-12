import Foundation
import PopularDisneyKit

struct CharactersRequest: APIRequest {
    typealias ResponseBody = CharactersResponse
    let method: RequestMethod = .get
    let path: String = Endpoints.Paths.characters
}
