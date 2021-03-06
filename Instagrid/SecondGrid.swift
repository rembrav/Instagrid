//
//  SecondGrid.swift
//  Instagrid
//
//  Created by REMY on 06/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class SecondGrid: UIView, GridType {
    
    // MARK: - Outlets

    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var topLeftButton: UIButton!
    @IBOutlet private weak var topRightButton: UIButton!
    @IBOutlet private weak var downButton: UIButton!
    
    // MARK: - Properties
    
    private var viewModel: GridViewModel!
    
    private weak var delegate: GridDelegate?
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    private func initialize() {
        Bundle(for: type(of: self)).loadNibNamed(String(describing: SecondGrid.self),owner: self,options: nil)
        addSubview(contentView)
        contentView.fillWithSuperView(self)
    }
    
    // MARK: - Actions
    
    func set (image: UIImage, for spot: Spot) {
        let imageView = UIImageView(image:image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        switch spot {
        case .topLeft:
            topLeftButton.removeAllSubviews()
            topLeftButton.addSubview(imageView)
            imageView.fillWithSuperView(topLeftButton)
        case .topRight:
            topRightButton.removeAllSubviews()
            topRightButton.addSubview(imageView)
            imageView.fillWithSuperView(topRightButton)
        case .bottom:
            downButton.removeAllSubviews()
            downButton.addSubview(imageView)
            imageView.fillWithSuperView(downButton)
        default: break
        }
    }
    
    func configure(with viewModelType: GridViewModel, delegate: GridDelegate) {
        self.viewModel = viewModelType
        self.delegate = delegate
        bind(to: self.viewModel)
    }
    
    private func bind(to viewModel: GridViewModel) {
        viewModel.selectedSpot = { [weak self] spot in
            self?.delegate?.didSelect(spot: spot)
        }
    }
    
    @IBAction private func didSelectButton(_ sender: UIButton) {
        let index = sender.tag
        viewModel?.didSelectButton(at: index)
    }
}
