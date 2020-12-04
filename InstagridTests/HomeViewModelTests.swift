//
//  HomeViewModelTests.swift
//  InstagridTests
//
//  Created by REMY on 12/10/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import XCTest

@testable import Instagrid

final class HomeViewModelTests: XCTestCase {
    
    var hViewModel: HomeViewModel!
    
    override func setUp() {
        super.setUp()
        hViewModel = HomeViewModel()
    }
    
    func testGivenAHomeViewModel_WhenViewDidLoad_ThenAppTitleTextReturnsInstagrid() {
        
        // Given
        let expectation = self.expectation(description: "Returned Instagrid")
        
        // Then
        hViewModel.appTitleText = { titleText in
            XCTAssertEqual(titleText,"Instagrid")
            expectation.fulfill()
        }
        
        // When
        hViewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenViewDidLoad_ThenSwipeTitleTextReturnsSwipeUpToShare() {
        
        // Given
        let expectation = self.expectation(description: "Returned Swipe up to share")
        
        // Then
        hViewModel.swipeTitleText = { titleText in
            XCTAssertEqual(titleText,"Swipe up to share")
            expectation.fulfill()
        }
        
        // When
        hViewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenViewDidLoad_ThenSwipeArrowNameReturnsArrowUp() {
        
        // Given
        let expectation = self.expectation(description: "Returned Swipe Arrow Up")
        
        // Then
        hViewModel.swipeArrowName = { name in
            XCTAssertEqual(name,"Arrow Up")
            expectation.fulfill()
        }
        
        // When
        hViewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenViewDidLoad_ThenSelectedGridConfigurationReturnsFirstGrid() {
        
        // Given
        let expectation = self.expectation(description: "Returned FirstGrid")
        
        // Then
        hViewModel.selectedGridConfiguration = { Gridconfiguration in
            XCTAssertEqual(Gridconfiguration,.firstGrid)
            expectation.fulfill()
        }
        
        // When
        hViewModel.viewDidLoad()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidPressFirstGrid_ThenSelectedGridConfigurationReturnsFirstGrid() {
        
        // Given
        let expectation = self.expectation(description: "Returned FirstGrid")
        
        // Then
        var count = 0
        hViewModel.selectedGridConfiguration = { Gridconfiguration in
            if count == 1 {
                XCTAssertEqual(Gridconfiguration,.firstGrid)
                expectation.fulfill()
            }
            count += 1
        }
        // When
        hViewModel.viewDidLoad()
        hViewModel.didPressFirstGrid()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidPressSecondGrid_ThenSelectedGridConfigurationReturnsSecondGrid() {
        
        // Given
        let expectation = self.expectation(description: "Returned SecondGGrid")
        
        // Then
        var count = 0
        hViewModel.selectedGridConfiguration = { Gridconfiguration in
            if count == 1 {
                XCTAssertEqual(Gridconfiguration,.secondGrid)
                expectation.fulfill()
            }
            count += 1
        }
        // When
        hViewModel.viewDidLoad()
        hViewModel.didPressSecondGrid()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidPressThirdGrid_ThenSelectedGridConfigurationReturnsThirdGrid() {
        
        // Given
        let expectation = self.expectation(description: "Returned ThirdGrid")
        
        // Then
        var count = 0
        hViewModel.selectedGridConfiguration = { Gridconfiguration in
            if count == 1 {
                XCTAssertEqual(Gridconfiguration,.thirdGrid)
                expectation.fulfill()
            }
            count += 1
        }
        
        // When
        hViewModel.viewDidLoad()
        hViewModel.didPressThirdGrid()
    
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidChangeToCompact_ThenSwipeArrowNameReturnsArrowUp() {
        
        //Given
        let expectation = self.expectation(description: "Returned Arrow Up")
        
        //Then
        var count = 0
        hViewModel.swipeArrowName = { arrowName in
            if count == 1 {
                XCTAssertEqual(arrowName,"Arrow Up")
                expectation.fulfill()
            }
            count += 1
        }
        //When
        hViewModel.viewDidLoad()
        hViewModel.didChangeToCompact()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidChangeToCompact_ThenSwipeTitleTextReturnsSwipeUptToShare() {
        
        //Given
        let expectation = self.expectation(description: "Returned Swipe up to share")
        
        //Then
        var count = 0
        hViewModel.swipeTitleText = { titleText in
            if count == 1 {
                XCTAssertEqual(titleText, "Swipe up to share")
                expectation.fulfill()
            }
            count += 1
        }
        
        //When
        hViewModel.viewDidLoad()
        hViewModel.didChangeToCompact()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidChangeToRegular_ThenSwipeArrowNameReturnsArrowLeft() {
        
        //Given
        let expectation = self.expectation(description: "Returned Arrow Left")
        
        //Then
        var count = 0
        hViewModel.swipeArrowName = { arrowName in
            if count == 1 {
                XCTAssertEqual(arrowName, "Arrow Left")
                expectation.fulfill()
            }
            count += 1
        }
        //When
        hViewModel.viewDidLoad()
        hViewModel.didChangeToRegular()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
    
    func testGivenAHomeViewModel_WhenDidChangeToRegularThenSwipeTitleTextReturnsSwipeLeftToShare() {
        
        //Given
        let expectation = self.expectation(description: "Returned Swipe Left To Share")
        
        //Then
        var count = 0
        hViewModel.swipeTitleText = { titleText in
            if count == 1 {
                XCTAssertEqual(titleText, "Swipe left to share")
                expectation.fulfill()
            }
            count += 1
        }
        //When
        hViewModel.viewDidLoad()
        hViewModel.didChangeToRegular()
        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
