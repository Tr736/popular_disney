@testable import PopularDisney
import PopularDisneyKit
import XCTest
final class ConcreteAPITests: XCTestCase {
    private enum Constants {
        static let timeout: TimeInterval = 10
        static let baseURL = "https://mock.com"
        static let getRequestExpectation = "Get request expectation"
        static let expectationDecoded = "Decodable expectation"
        static let expectationFailedToDecode = "Failed to decode expectation"
        static let responseStatusCode = 200
        static let name = "Homer"
        static let age = 26
    }

    private var sut: APIType!
    private var mockURLSession: MockUrlSession!
    private var baseURL: URL = .init(string: Constants.baseURL)!
    private var decodedData: TestResponseObject?

    override func tearDown() {
        sut = nil
        mockURLSession = nil
        decodedData = nil
        super.tearDown()
    }

    func test_expectResponse() async throws {
        // Given
        let responseObject = APIRequestEmptyObject()
        let json = try JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)
        let request = GetRequest()
        do {
            // When
            let response = try await sut.execute(apiRequest: request)
            // Then
            XCTAssertNotNil(response)
        } catch {
            XCTFail(String(describing: error))
        }
    }

    func test_IsDecodable_expectAgeAndName() async throws {
        // Given
        let responseObject = TestResponseObject(name: Constants.name,
                                                age: Constants.age)
        let json = try JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)

        let request = GetRequestWithObject()
        // When
        decodedData = try await sut.execute(apiRequest: request)
        // Then
        XCTAssertEqual(decodedData?.age, Constants.age)
        XCTAssertEqual(decodedData?.name, Constants.name)
    }

    func test_failedToDecode_expectDecodingErrorThrown() async throws {
        // Given
        let responseObject = APIRequestEmptyObject()
        let json = try JSONEncoder().encode(responseObject)
        mockURLSession = MockUrlSession(responseObject: json,
                                        responseStatusCode: Constants.responseStatusCode)
        sut = ConcreteAPI(baseURL: baseURL,
                          urlSession: mockURLSession)

        let request = GetRequestWithObject()
        do {
            // When
            decodedData = try await sut.execute(apiRequest: request)
            XCTAssertNil(decodedData)
        } catch let DecodingError.keyNotFound(key, context) {
            // Then
            XCTAssertNotNil(key)
            XCTAssertNotNil(context)
        }
    }
}
