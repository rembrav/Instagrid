//
//  HomeViewModel.swift
//  Instagrid
//
//  Created by REMY on 03/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import Foundation

final class HomeViewModel {

    enum GridConfiguration {
        case firstGrid, secondGrid, thirdGrid
    }
    
//    private var currentGrid: GridConfiguration = .firstGrid {
//        didSet {
//            selectedGridConfiguration?(currentGrid)
//        }
//    }
    
    // MARK: - Outputs
    
    var appTitleText: ((String) -> Void)?
    
    var swipeTitleText: ((String) -> Void)?

    var swipeArrowName: ((String) -> Void)?

    var selectedGridConfiguration: ((GridConfiguration) -> Void)?
    
    
    
    // MARK: - Inputs
    
    func viewDidLoad(){
        appTitleText?("Instagrid")
        swipeTitleText?("Swipe up to share")
        swipeArrowName?("Arrow Up")
        selectedGridConfiguration?(.firstGrid)
    }

    func didPressFirstGrid() {
        selectedGridConfiguration?(.firstGrid)
    }

    func didPressSecondGrid() {
        selectedGridConfiguration?(.secondGrid)
    }

    func didPressThirdGrid() {
        selectedGridConfiguration?(.thirdGrid)
    }
    
    // Ajouter les fonctions pour recuperer le changement d'orientation au nombre de 2
    
    func didChangeToCompact() {
        swipeArrowName?("Arrow Up")
        swipeTitleText?("Swipe up to share")
    }
    
    func didChangeToRegular() {
        swipeArrowName?("Arrow Left")
        swipeTitleText?("Swipe left to share")
    }
//    func didClearGrid() {
//        selectedGridConfiguration?(currentGrid)
//    }
}
