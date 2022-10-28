//
//  ParameterEncodingTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 28/10/22.
//

import XCTest
@testable import GrowMartApp

class ParameterEncodingTests: BaseTests {
    
    let testURL = URL(string: "http://pudim.com.br")!
    
    func testUrlEncodingWithParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.urlEncoding
        var request = URLRequest(url: testURL)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: nil,
                        urlParameters: ["test": "test"])
        
        XCTAssertEqual(request.url, URL(string: "http://pudim.com.br?test=test"))
    }
    
    func testUrlEncodingWithoutParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.urlEncoding
        var request = URLRequest(url: testURL)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: nil,
                        urlParameters: nil)
        
        XCTAssertEqual(request.url, testURL)
    }
    
    func testJsonEncodingWithBodyParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.jsonEncoding
        var request = URLRequest(url: URL(string: "http://pudim.com.br")!)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: ["test": "test"],
                        urlParameters: nil)
        
        
        let jsonAsData = try JSONSerialization.data(withJSONObject: ["test": "test"],
                                                    options: .prettyPrinted)
        XCTAssertEqual(request.httpBody, jsonAsData)
    }
    
    func testJsonEncodingWithoutBodyParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.jsonEncoding
        var request = URLRequest(url: testURL)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: nil,
                        urlParameters: nil)
        
        XCTAssertNil(request.httpBody)
    }
    
    func testURLAndJsonEncodingWithParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.urlAndJsonEncoding
        var request = URLRequest(url: testURL)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: ["test": "test"],
                        urlParameters: ["test": "test"])
        
        
        let jsonAsData = try JSONSerialization.data(withJSONObject: ["test": "test"],
                                                    options: .prettyPrinted)
        
        XCTAssertEqual(request.url, URL(string: "http://pudim.com.br?test=test"))
        XCTAssertEqual(request.httpBody, jsonAsData)
    }
    
    func testURLAndJsonEncodingWithoutParametersShouldConfigureURLRequest() throws {
        let sut = ParameterEncoding.urlAndJsonEncoding
        var request = URLRequest(url: testURL)
        
        try? sut.encode(urlRequest: &request,
                        bodyParameters: nil,
                        urlParameters: nil)
        
        XCTAssertEqual(request.url, testURL)
        XCTAssertNil(request.httpBody)
    }
    
}
