//
//  ButtonCellTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import GrowMartApp

class ButtonCellTests: BaseTests {
    
    private let componentSize = CGSize(width: 414, height: 85)
    private lazy var buttonCellSpy = ButtonCellSpy()
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
        buttonCellSpy.resetFlags()
    }
    
    func testRenderDefaultStyle() {
        let component = ButtonCell()
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderBlackTitle() {
        let component = ButtonCell()
        component.setTitle("salvar dados", color: .black)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testTapButtonShouldCallDelegate() throws {
        XCTAssertFalse(buttonCellSpy.didTapButtonCalled)

        let component = ButtonCell()
        component.delegate = buttonCellSpy
        
        let buttonCellMirrored = Mirror(reflecting: component)
        let button = try XCTUnwrap(buttonCellMirrored.firstChild(of: UIButton.self))
        button.sendActions(for: .touchUpInside)
        
        XCTAssertTrue(buttonCellSpy.didTapButtonCalled)
    }
}

// MARK: - ButtonCellDelegate
class ButtonCellSpy: ButtonCellDelegate {
    var didTapButtonCalled = false
    
    func didTapButton() {
        didTapButtonCalled = true
    }
    
    func resetFlags() {
        didTapButtonCalled = false
    }
}
