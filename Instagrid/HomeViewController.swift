//
//  HomeViewController.swift
//  Instagrid//
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
    
    private var currentSpot: Spot?
    
    private var currentGrid: GridType? {
        didSet {
            let viewModel = GridViewModel()
            self.currentGrid?.configure(with: viewModel, delegate: self)
        }
    }
    
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

        viewModel.swipeTitleText = { [weak self] title in
            self?.swipeLabel.text = title
        }

        viewModel.selectedGridConfiguration = { [weak self] configuration in
            guard let self = self else { return }
            self.removeSelectedViews()
            switch configuration {
            case .firstGrid:
                HomeViewController.configure(gridView: FirstGrid(),
                                             on: self.gridContainerView,
                                             andSelectButton: self.firstGridButton)
            case .secondGrid:
                HomeViewController.configure(gridView: SecondGrid(),
                                             on: self.gridContainerView,
                                             andSelectButton: self.secondGridButton)
            case .thirdGrid:
                HomeViewController.configure(gridView: ThirdGrid(),
                                             on: self.gridContainerView,
                                             andSelectButton: self.thirdGridButton)
            }
        }
    }

    private static func configure(gridView: UIView,
                                  on container: UIView,
                                  andSelectButton selectedButton: UIButton) {
        container.removeSubviewsAlreadyLoaded()
        container.addSubview(gridView)
        gridView.fillWithSuperView(container)
        addSelectedView(on: selectedButton)

    }

    // MARK: - Helpers

    private static func addSelectedView (on button: UIButton) {
        let imageSelected = UIImage(named: "Selected")
        let imageView = UIImageView(image: imageSelected)
        button.addSubview(imageView)
        imageView.fillWithSuperView(button)
    }
    
    private func removeSelectedViews() {
        if firstGridButton.subviews.count > 1 {
            firstGridButton.subviews.last?.removeFromSuperview()
        }

        if secondGridButton.subviews.count > 1 {
            secondGridButton.subviews.last?.removeFromSuperview()
        }

        if thirdGridButton.subviews.count > 1 {
            thirdGridButton.subviews.last?.removeFromSuperview()
        }
    }
    
    // MARK: - Actions

     @IBAction private func didPressFirstGrid(_ sender: UIButton) {
         viewModel.didPressFirstGrid()
     }

     @IBAction func didPressSecondGrid(_ sender: UIButton) {
         viewModel.didPressSecondGrid()
     }
     
     @IBAction func didPressThirdGrid(_ sender: UIButton) {
         viewModel.didPressThirdGrid()
     }
}

extension UIView {
    func fillWithSuperView(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftAnchor.constraint(equalTo: view.leftAnchor),
            rightAnchor.constraint(equalTo: view.rightAnchor),
            topAnchor.constraint(equalTo: view.topAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)])
    }
}
extension UIView {
    func removeSubviewsAlreadyLoaded() {
           self.subviews.forEach { $0.removeFromSuperview() }
       }
}
extension HomeViewController: GridDelegate {
    func didSelect(spot: Spot) {
        self.currentSpot = spot
    }
}

