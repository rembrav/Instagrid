//
//  HomeViewController.swift
//  Insta
//
//  Created by REMY on 03/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet private weak var appNameLabel: UILabel! {
        didSet {
            appNameLabel.font = UIFont(name: "ThirstySoftRegular",size: 30.0)
            appNameLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }
    @IBOutlet private weak var swipeImageView: UIImageView!
    @IBOutlet private weak var swipeLabel: UILabel! {
        didSet {
            swipeLabel.font = UIFont(name: "Delm-Medium", size: 26.0)
            swipeLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
    }

    @IBOutlet private weak var gridContainerView: UIView!
    
    @IBOutlet private weak var firstGridButton: UIButton!
    @IBOutlet private weak var secondGridButton: UIButton!
    @IBOutlet private weak var thirdGridButton: UIButton!

    private let viewModel = HomeViewModel()
    
// MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    
    private func bind (to viewModel: HomeViewModel) {
        viewModel.appTitleText = { [weak self] title in
            self?.appNameLabel.text = title
        }

        viewModel.selectedGridConfiguration = { [weak self] configuration in
            guard let self = self else { return }
            switch configuration {
            case .firstGrid:
                let gridOne = FirstGrid()
                self.gridContainerView.layoutIfNeeded()
                gridOne.frame = self.gridContainerView.bounds
                self.gridContainerView.addSubview(gridOne)
            case .secondGrid:
                let gridTwo = SecondGrid()
                self.gridContainerView.layoutIfNeeded()
                gridTwo.frame = self.gridContainerView.bounds
                self.gridContainerView.addSubview(gridTwo)
            case .thirdGrid:
                let gridThree = ThirdGrid()
                self.gridContainerView.layoutIfNeeded()
                gridThree.frame = self.gridContainerView.bounds
                self.gridContainerView.addSubview(gridThree)
            }
        }
    }
    
    
    // MARK: - Actions

    @IBAction private func didPressFirstGrid(_ sender: UIButton) {
        viewModel.didPressFirstGrid()
        firstGridButton.UIImage =
    }

    @IBAction func didPressSecondGrid(_ sender: UIButton) {
        viewModel.didPressSecondGrid()
    }
    
    @IBAction func didPressThirdGrid(_ sender: UIButton) {
        viewModel.didPressThirdGrid()
    }
}
