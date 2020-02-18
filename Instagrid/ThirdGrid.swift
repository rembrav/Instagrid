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
            topLeftButton.removeSubviewsAlreadyLoaded()
            topLeftButton.addSubview(imageView)
            setConstraints(for: imageView, with: topLeftButton)
        case .topRight:
            topRightButton.removeSubviewsAlreadyLoaded()
            topRightButton.addSubview(imageView)
            setConstraints(for: imageView, with: topRightButton)
        case .bottomLeft:
            downLeftButton.removeSubviewsAlreadyLoaded()
            downLeftButton.addSubview(imageView)
            setConstraints(for: imageView, with: downLeftButton)
        case .bottomRight:
            downRightButton.removeSubviewsAlreadyLoaded()
            downRightButton.addSubview(imageView)
            setConstraints(for: imageView, with: downRightButton)
        default: break
        }
    }
    
    private func setConstraints(for image: UIImageView, with button: UIButton) {
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: button.leftAnchor),
            image.rightAnchor.constraint(equalTo: button.rightAnchor),
            image.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            image.topAnchor.constraint(equalTo: button.topAnchor)
        ])
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
        if index == 1 {
            sender.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        }
        else if index == 2 {
            sender.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
            }
        else if index == 4 {
            sender.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        }
}

}
