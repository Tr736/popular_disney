import Foundation
public protocol URLSessionType {
    func data(for request: URLRequest,
              delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse)
}
