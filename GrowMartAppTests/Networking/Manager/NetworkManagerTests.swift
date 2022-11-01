//
//  NetworkManagerTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import XCTest
@testable import GrowMartApp

class NetworkManagerTests: BaseTests {
    typealias SUT = NetworkManager
    
    var routerMock: NetworkRouterMock?
    
    func testCallExecuteShouldCallNetworkRequest() throws {
        let sut = try makeSUT()
        let routerMock = try XCTUnwrap(routerMock)

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in }
        
        XCTAssertTrue(routerMock.requestCalled)
    }
    
    func testCallExecuteWithSuccessShouldReturnData() throws {
        let jsonData = try XCTUnwrap(CategoriesJsonData)
        let sut = try makeSUT(mockedData: jsonData)
        let expected = try JSONDecoder().decode(CategoriesResponse.self, from: jsonData)

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in
            XCTAssertEqual(response, .success(expected))
        }
    }
    
    func testCallExecuteWithFailureShouldReturnFailure() throws {
        let sut = try makeSUT()

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in
            XCTAssertEqual(response, .failure(.errorDecoder))
        }
    }
    
    func testCallExecuteWithSuccessAndDataNilShouldReturnFailure() throws {
        let sut = try makeSUT(mockedData: nil)

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in
            XCTAssertEqual(response, .failure(.invalidData))
        }
    }
    
    func testCallExecuteWithSuccessAndInvalidResponseShouldReturnFailure() throws {
        let sut = try makeSUT(mockedURLResponse: HTTPURLResponse(url: .init(string: "http://test.com")!,
                                                                 statusCode: 500,
                                                                 httpVersion: nil,
                                                                 headerFields: [:]))

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in
            XCTAssertEqual(response, .failure(.invalidResponse))
        }
    }
    
    func testCallExecuteWithErrorShouldReturnFailure() throws {
        let sut = try makeSUT(mockedError: NSError(domain: "Error scenario test", code: 500))

        sut.execute(endpoint: CategoriesApi.list) { (response: Result<CategoriesResponse, NetworkResponse>) in
            XCTAssertEqual(response, .failure(.errorGeneric(description: "The operation couldn’t be completed. (Error scenario test error 500.)")))
        }
    }
}

// MARK: - Private Methods
extension NetworkManagerTests {
    private func makeSUT(mockedData: Data? = Data(),
                         mockedURLResponse: URLResponse? = URLResponse(),
                         mockedError: Error? = nil) throws -> SUT {
        
        routerMock = NetworkRouterMock()
        let routerMock = try XCTUnwrap(routerMock)
        
        routerMock.mockedData = mockedData
        routerMock.mockedURLResponse = mockedURLResponse
        routerMock.mockedError = mockedError

        return SUT(router: routerMock)
    }
}

// MARK: - Mock Classes
class NetworkRouterMock: NetworkRouter {
    var mockedData: Data?
    var mockedURLResponse: URLResponse?
    var mockedError: Error?
    
    var requestCalled = false
    func request(_ endpoint: EndpointType, completion: @escaping NetworkRouterCompletion) {
        requestCalled = true
        completion(mockedData, mockedURLResponse, mockedError)
    }
    
    var cancelCalled = false
    func cancel() {
        cancelCalled = true
    }
}
