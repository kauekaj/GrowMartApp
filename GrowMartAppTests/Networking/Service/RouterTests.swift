//
//  RouterTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import XCTest
@testable import GrowMartApp

class RouterTests: BaseTests {
    
    var sut: Router!
    let session = URLSessionMock()
    
    override func setUp() {
        super.setUp()
        session.nextDataTask.resetFlags()
        sut = Router(session: session)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testGetRequestWithURL() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        XCTAssertEqual(session.lastURL, CategoriesApi.list.getFullURL())
    }
    
    func testGetResumeCalled() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        XCTAssertTrue(session.nextDataTask.resumeCalled)
    }
    
    func testGetShouldReturnData() {
        session.nextData = CategoriesJsonData
        
        sut.request(CategoriesApi.list) { data, response, error in
            XCTAssertEqual(self.session.nextData, data)
        }
    }
    
    func testCancellCalled() {
        sut.request(CategoriesApi.list) { _, _, _ in }
        sut.cancel()
        
        XCTAssertTrue(session.nextDataTask.cancelCalled)
    }
}

class URLSessionMock: URLSessionProtocol {

    var nextDataTask = URLSessionDataTaskSpy()
    var nextData: Data?
    var nextError: Error?
    
    private (set) var lastURL: URL?
    
    func successResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!,
                               statusCode: 200,
                               httpVersion: "HTTP/1.1",
                               headerFields: nil)!
    }
    
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping NetworkRouterCompletion) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        
        completionHandler(nextData, successResponse(request: request), nextError)
        return nextDataTask
    }
}

class URLSessionDataTaskSpy: URLSessionDataTaskProtocol {
    private (set) var resumeCalled = false
    func resume() {
        resumeCalled = true
    }

    private (set) var cancelCalled = false
    func cancel() {
        cancelCalled = true
    }
    
    func resetFlags() {
        resumeCalled = false
        cancelCalled = false
    }
}
