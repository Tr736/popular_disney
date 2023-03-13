import Foundation

public protocol APIType {
    func execute<T: APIRequest>(apiRequest: T) async throws -> T.ResponseBody
    func executeRaw<T: APIRequest>(apiRequest: T) async throws -> (data: Data, response: URLResponse)
}
