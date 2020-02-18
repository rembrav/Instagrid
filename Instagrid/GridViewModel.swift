//
//  GridViewModel.swift
//  Instagrid
//
//  Created by REMY on 13/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import Foundation

protocol GridDelegate: class {
    func didSelect(spot: Spot)
}

enum Spot: Int {
    case top = 0
    case topLeft = 1
    case topRight = 2
    case bottom = 3
    case bottomLeft = 4
    case bottomRight = 5
}

final class GridViewModel {

    // MARK: - Outputs

    var selectedSpot: ((Spot) -> Void)?

    // MARK: - Inputs

    func didSelectButton(at index: Int) {
        guard let spot = Spot(rawValue: index) else { return }
        selectedSpot?(spot)
    }
}
