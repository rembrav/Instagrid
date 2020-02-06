//
//  ThirdGrid.swift
//  Insta
//
//  Created by REMY on 06/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class ThirdGrid: UIView, GridType {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .blue
    }
}
