import Foundation
import PopularDisneyKit

final class MockUrlSession: URLSessionType {

    var data: Data
    var urlResponse: URLResponse

    init(responseObject: Data = Data(),
         responseStatusCode: Int = 200) {
        data = responseObject
        urlResponse = HTTPURLResponse(url: URL(string: "https://mock/response/path")!,
                                      statusCode: responseStatusCode,
                                      httpVersion: "1.0",
                                      headerFields: [:])!
    }

    func data(for request: URLRequest, delegate: URLSessionTaskDelegate?) async throws -> (Data, URLResponse) {
        (data, urlResponse)
    }

}
