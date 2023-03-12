import Foundation
public protocol URLSessionType {
    func data(request: URLRequest) async throws -> (Data, URLResponse)
}
