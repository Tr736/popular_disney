import Foundation
import PopularDisneyKit
struct GetRequest: APIRequest {
    typealias ResponseBody = APIRequestEmptyObject

    let method = RequestMethod.get
    let path = "testPath/foo/bar"
}
