import Foundation
public protocol APIRequest {
    associatedtype ResponseBody: Decodable

    var method: RequestMethod { get }
    var path: String { get }
}
