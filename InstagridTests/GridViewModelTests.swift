//
//  GridViewModelTests.swift
//  InstagridTests
//
//  Created by REMY on 05/03/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import XCTest
@testable import Instagrid

final class GridViewModelTests: XCTestCase {
    
    var viewModel = GridViewModel()
    
    override func setUp() {
        super.setUp()
        viewModel = GridViewModel()
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex0_ThenSelectedSpotReturnsTop() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .top)
            expectation.fulfill()
        }
        
        // When
        viewModel.didSelectButton(at: 0)
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex1_ThenSelectedSpotReturnsTopLeft() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .topLeft)
            expectation.fulfill()
        }
        // When
        viewModel.didSelectButton(at: 1)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex2_ThenSelectedSpotReturnsTopRight() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .topRight)
            expectation.fulfill()
        }
        
        // When
        viewModel.didSelectButton(at: 2)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex3_ThenSelectedSpotReturnsBottom() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottom)
            expectation.fulfill()
        }
        
        // When
        viewModel.didSelectButton(at: 3)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex4_ThenSelectedSpotReturnsBottomLeft() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottomLeft)
            expectation.fulfill()
        }
        
        // When
        viewModel.didSelectButton(at: 4)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex5_ThenSelectedSpotReturnsBottomRight() {
        
        // Given
        let expectation = self.expectation(description: "Returned Spot")
        
        // Then
        viewModel.selectedSpot = { spot in
            XCTAssertEqual(spot, .bottomRight)
            expectation.fulfill()
        }
        
        // When
        viewModel.didSelectButton(at: 5)
        waitForExpectations(timeout: 1.0, handler: nil)
        
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndex6_ThenSelectedSpotReturnsNothing() {
        
        // Then
        viewModel.selectedSpot = { _ in
            XCTFail()
        }
        
        // When
        viewModel.didSelectButton(at: 6)
    }
    
    func testGivenAGridViewModel_WhenDidSelectButtonAtIndexNegativeNumber_ThenSelectedSpotReturnsNothing() {
        
        // Then
        viewModel.selectedSpot = { _ in
            XCTFail()
        }
        
        // When
        viewModel.didSelectButton(at: -1)
    }
}
