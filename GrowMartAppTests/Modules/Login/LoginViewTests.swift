//
//  LoginViewTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import GrowMartApp

class LoginViewTests: BaseTests {
    
    private let componentSize = CGSize(width: 414, height: 526)
    private lazy var loginViewSpy = LoginViewSpy()

    override func setUp() {
//        SnapshotTesting.isRecording = true
        loginViewSpy.resetFlags()
    }
    
    func testRenderView() {
        let component = LoginView()
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testTapButtonFacebookShouldCallDelegate() throws {
        XCTAssertFalse(loginViewSpy.didTapFacebookLoginCalled)
        XCTAssertFalse(loginViewSpy.didTapGoogleLoginCalled)

        let component = LoginView()
        component.delegate = loginViewSpy
        
        let loginViewMirrored = Mirror(reflecting: component)
        let button = try XCTUnwrap(loginViewMirrored.firstLazyChild(of: UIButton.self, in: "facebookLoginButton"))
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(loginViewSpy.didTapFacebookLoginCalled)
        XCTAssertFalse(loginViewSpy.didTapGoogleLoginCalled)
    }
    
    func testTapButtonGoogleShouldCallDelegate() throws {
        XCTAssertFalse(loginViewSpy.didTapFacebookLoginCalled)
        XCTAssertFalse(loginViewSpy.didTapGoogleLoginCalled)

        let component = LoginView()
        component.delegate = loginViewSpy
        
        let loginViewMirrored = Mirror(reflecting: component)
        let button = try XCTUnwrap(loginViewMirrored.firstLazyChild(of: UIButton.self, in: "googleLoginButton"))
        button.sendActions(for: .touchUpInside)
        
        XCTAssertFalse(loginViewSpy.didTapFacebookLoginCalled)
        XCTAssertTrue(loginViewSpy.didTapGoogleLoginCalled)
    }
    
    // Exemplo de teste de clousure(bloco)
//    func testX() {
//        let view = LoginView()
//        var didSuccessBlockExecuted = false
//
//        view.successBlock = {
//            didSuccessBlockExecuted = true
//        }
//
//        view.callSuccessBlock()
//
//        XCTAssertTrue(didSuccessBlockExecuted)
//
//    }
}

// MARK: - LoginViewDelegate
class LoginViewSpy: LoginViewDelegate {

    var didTapFacebookLoginCalled = false
    var didTapGoogleLoginCalled = false
    var didTapLoginCalled = false

    func didTapFacebookLogin() {
        didTapFacebookLoginCalled = true
    }
    
    func didTapGoogleLogin() {
        didTapGoogleLoginCalled = true
    }
    
    func didTapLogin(login: String, password: String) {
        didTapLoginCalled = true
    }
    
    func resetFlags() {
        didTapFacebookLoginCalled = false
        didTapGoogleLoginCalled = false
        didTapLoginCalled = false
    }
}
