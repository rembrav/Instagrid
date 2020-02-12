//
//  SecondGrid.swift
//  Instagrid
//
//  Created by REMY on 06/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class SecondGrid: UIView, GridType {
    
    @IBOutlet weak var secondGridView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        backgroundColor = .yellow
        
    }
    
    @IBAction func upLeftPhotoButton(_ sender: UIButton) {
    }
    @IBAction func upLeftButton(_ sender: UIButton) {
    }
    
    @IBAction func upRightPhotoButton(_ sender: UIButton) {
    }
    @IBAction func upRightButton(_ sender: UIButton) {
    }
    @IBAction func downPhotoButton(_ sender: UIButton) {
    }
    @IBAction func downButton(_ sender: UIButton) {
    }
}
