//
//  CategoryButtonTests.swift
//  GrowMartAppTests
//
//  Created by Kaue de Assis Jacyntho on 05/10/22.
//

import XCTest
import SnapshotTesting
@testable import GrowMartApp

class CategoryButtonTests: BaseTests {
    
    private let componentSize = CGSize(width: 414, height: 100)
    
    override func setUp() {
//        SnapshotTesting.isRecording = true
    }
    
    func testRenderButtonWithImageAtLeftSide() {
        let component = CategoryButton()
        component.setData(categoryId: "1",
                          title: "roupas",
                          imageSide: .left,
                          imageUrl: nil)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
    
    func testRenderButtonWithImageAtRightSide() {
        let component = CategoryButton()
        component.setData(categoryId: "1",
                          title: "roupas",
                          imageSide: .right,
                          imageUrl: nil)
        assertSnapshot(matching: component, as: .image(size: componentSize))
    }
}
