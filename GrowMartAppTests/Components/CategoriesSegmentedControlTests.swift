//
//  CategoriesSegmentedControlTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import GrowMartApp

class CategoriesSegmentedControlTests: BaseTests {
    private let componentSize = CGSize(width: 414, height: 45)
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
  
    func testInitButtonWithCoderInitShouldReturnNil() {
        let component = CategoriesSegmentedControl(coder: .init())
        XCTAssertNil(component)
    }
    
    func testRenderSegmentedWithTwoElements() {
        let component = CategoriesSegmentedControl(items: ["roupas", "acessórios"])
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderSegmentedWithThreeElements() {
        let component = CategoriesSegmentedControl(items: ["roupas", "acessórios", "outros"])
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderSegmentedWithFourElements() {
        let component = CategoriesSegmentedControl(items: ["primeiro", "segundo", "terceiro", "quarto"])
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
}
