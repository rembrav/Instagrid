//
//  ThirdGrid.swift
//  Instagrid
//
//  Created by REMY on 06/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class ThirdGrid: UIView, GridType  {
    
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    @IBOutlet weak var downLeftButton: UIButton!
    @IBOutlet weak var downRightButton: UIButton!
    
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
        Bundle(for: type(of:self)).loadNibNamed(String(describing:ThirdGrid.self),owner: self,options: nil)
        addSubview(contentView)
        contentView.fillWithSuperView(self)
    }
    // MARK: - Actions
    
    func set (image: UIImage, for spot: Spot) {
        let imageView = UIImageView(image:image)
        switch spot {
        case .topLeft:
            topLeftButton.removeAllSubviews()
            topLeftButton.addSubview(imageView)
            imageView.fillWithSuperView(topLeftButton)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        case .topRight:
            topRightButton.removeAllSubviews()
            topRightButton.addSubview(imageView)
            imageView.fillWithSuperView(topRightButton)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        case .bottomLeft:
            downLeftButton.removeAllSubviews()
            downLeftButton.addSubview(imageView)
            imageView.fillWithSuperView(downLeftButton)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        case .bottomRight:
            downRightButton.removeAllSubviews()
            downRightButton.addSubview(imageView)
            imageView.fillWithSuperView(downRightButton)
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        default: break
        }
    }
  
    // la grille se connecte au viewModel
    func configure(with viewModelType: GridViewModel, delegate: GridDelegate) {
        self.viewModel = viewModelType
        self.delegate = delegate
        bind(to: self.viewModel)
    }
    // Au moment du bind avec la var reactive: tu vas renvoyer la methode du delegate.
    private func bind(to viewModel: GridViewModel) {
        viewModel.selectedSpot = { [weak self] spot in
            self?.delegate?.didSelect(spot: spot)
        }
    }
    
    @IBAction func didSelectButton(_ sender: UIButton) {
        let index = sender.tag
        viewModel?.didSelectButton(at: index)
    
    }
}
