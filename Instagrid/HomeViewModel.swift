//
//  HomeViewModel.swift
//  Insta
//
//  Created by REMY on 03/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import Foundation

final class HomeViewModel {

    enum GridConfiguration {
        case firstGrid, secondGrid, thirdGrid
    }
    
    // MARK: - Outputs
    
    var appTitleText: ((String) -> Void)?
    
    var swipeTitleText: ((String) -> Void)?

    var swipeArrowName: ((String) -> Void)?

    var selectedGridConfiguration: ((GridConfiguration) -> Void)?
    
    // MARK: - Inputs
    
    func viewDidLoad(){
        appTitleText?("Instagrid")
        swipeTitleText?("swipe-up")
        swipeArrowName?("up")
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

    // Ajouter les fonction pour recuperer le changement d'orientation
    
}
