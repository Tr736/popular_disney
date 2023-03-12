
import Foundation

extension URLSession: URLSessionType {
    public func data(request: URLRequest) async throws -> (Data, URLResponse) {
        try await data(for: request)
    }
}
