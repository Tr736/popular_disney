import Foundation
import PopularDisneyKit

final class MockUrlSession: URLSessionType {
    // Mocks
    var data: Data
    var urlResponse: URLResponse

    // Interrogation
    var previousRequest: URLRequest?

    init(responseObject: Data = Data(),
         responseStatusCode: Int = 200)
    {
        data = responseObject
        urlResponse = HTTPURLResponse(url: URL(string: "https://mock/response/path")!,
                                      statusCode: responseStatusCode,
                                      httpVersion: "1.0",
                                      headerFields: [:])!
    }

    func data(request: URLRequest) async throws -> (Data, URLResponse) {
        try await withCheckedThrowingContinuation { continuation in
            self.dataTask(with: request) { data, response, error in
                guard let data = data, let response = response else {
                    let error = error ?? URLError(.badServerResponse)
                    return continuation.resume(throwing: error)
                }
                continuation.resume(returning: (data, response))
            }
        }
    }

    func dataTask(with _: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        completionHandler(data, urlResponse, nil)
    }
}
