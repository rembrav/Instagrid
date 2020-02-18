//
//  FirstGrid.swift
//  Instagrid
//
//  Created by REMY on 06/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class FirstGrid: UIView, GridType {
    
    
    // MARK: - Outputs
    
    @IBOutlet private var contentView: UIView!
    @IBOutlet weak var upButton: UIButton!
    @IBOutlet weak var downLeftButton: UIButton!
    @IBOutlet weak var downRightButton: UIButton!
    
    // MARK: - Properties
    
    private var viewModel: GridViewModel! // pouvoir se binder au gridViewModel
    
    private weak var delegate: GridDelegate? //le délégué : pouvoir incorporer la delegation GridDelegate
    
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
        Bundle(for: type(of: self)).loadNibNamed(String(describing: FirstGrid.self),owner: self,options: nil)
        addSubview(contentView)
        contentView.fillWithSuperView(self)
    }
    
    // MARK: - Actions
    
    func set (image: UIImage, for spot: Spot) {
        let imageView = UIImageView(image: image)
        switch spot {
        case .top:
            upButton.removeSubviewsAlreadyLoaded()
            upButton.addSubview(imageView)
            setConstraints(for: imageView, with: upButton)
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
        if index == 0 {
            sender.backgroundColor = #colorLiteral(red: 0.09019608051, green: 0, blue: 0.3019607961, alpha: 1)
        }
        else if index == 4 {
            sender.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        }
        else {
            sender.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
    }
}
