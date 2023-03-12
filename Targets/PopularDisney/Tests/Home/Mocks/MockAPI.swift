import Combine
import Foundation
import PopularDisneyKit
struct MockAPI: APIType {
    let session: MockUrlSession

    init(data: Data, statusCode: Int) {
        session = MockUrlSession(responseObject: data,
                                 responseStatusCode: statusCode)
    }

    let baseURL = URL(string: "https://www.apple.com")
    func execute<T>(apiRequest: T) async throws -> T.ResponseBody where T: PopularDisneyKit.APIRequest {
        let data = try await executeRaw(apiRequest: apiRequest).data
        let decoded: T.ResponseBody = try decode(from: data)
        return decoded
    }

    func executeRaw<T>(apiRequest: T) async throws -> (data: Data, response: URLResponse) where T: PopularDisneyKit.APIRequest {
        guard let url = try? buildUrl(for: apiRequest) else { throw APIError.invalidUrl(urlString: apiRequest.path) }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = apiRequest.method.rawValue
        urlRequest.setValue(Headers.contentTypeJson,
                            forHTTPHeaderField: Headers.contentType)
        return try await session.data(request: urlRequest)
    }

    private func decode<T>(from data: Data) throws -> T where T: Decodable {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }

    private func buildUrl<T: APIRequest>(for apiRequest: T) throws -> URL {
        guard let components = URLComponents(string: apiRequest.path),
              let url = components.url(relativeTo: baseURL)
        else {
            throw APIError.invalidUrl(urlString: apiRequest.path)
        }
        return url
    }
}
