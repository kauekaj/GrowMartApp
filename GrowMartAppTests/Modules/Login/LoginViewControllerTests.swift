//
//  LoginViewControllerTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import GrowMartApp

class LoginViewControllerTests: BaseTests {
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func testRenderViewControllerOniPhoneX() {
        let component = LoginViewController()
        assertSnapshot(matching: component, as: .image(on: .iPhoneX))
    }
    
    func testRenderViewControllerOniPhoneSe() {
        let component = LoginViewController()
        assertSnapshot(matching: component, as: .image(on: .iPhoneSe))
    }
}
