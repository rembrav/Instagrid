//
//  HomeViewController.swift
//  Instagrid//
//  Created by REMY on 03/02/2020.
//  Copyright © 2020 RPELG. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {
    
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
    
    // MARK: - Private properties
    private let viewModel = HomeViewModel()
    
    private lazy var pickerController: UIImagePickerController = {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        pickerController.allowsEditing = false
        return pickerController
    }()
    
//    private /*lazy*/ var SwipeleftGestureRecognizer: UISwipeGestureRecognizer = {
//        let swipeLeftGesture = UIGestureRecognizer(target: self, action:#selector(shareAction()))
//        swipeLeftGesture.direction = .left
//        return swipeLeftGesture
//    }()
    
//    private /*lazy*/ var SwipeUpGestureRecognizer: UISwipeGestureRecognizer = {
//    let swipeUpGesture = UIGestureRecognizer(target: self, action:#selector(shareAction()))
//    swipeUpGesture.direction = .up
//    return swipeUpGesture
//    }()
//
    
    
    private var currentGrid: GridType? {
        didSet {
            let viewModel = GridViewModel()
            currentGrid?.configure(with: viewModel, delegate: self)
        }
    }
    private var currentSpot : Spot?

    
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
        
        viewModel.swipeArrowName = { [weak self] name in
            self?.swipeImageView.image = UIImage(named: name)
        }
        
        viewModel.selectedGridConfiguration = { [weak self] configuration in
            guard let self = self else { return }
            self.removeSelectedViews()
            switch configuration {
            case .firstGrid:
                self.configure(gridView: FirstGrid(),
                               on: self.gridContainerView,
                               andSelectButton: self.firstGridButton)
            case .secondGrid:
                self.configure(gridView: SecondGrid(),
                               on: self.gridContainerView,
                               andSelectButton: self.secondGridButton)
            case .thirdGrid:
                self.configure(gridView: ThirdGrid(),
                               on: self.gridContainerView,
                               andSelectButton: self.thirdGridButton)
            }
        }
    }

    private func configure(gridView: GridType,
                           on container: UIView,
                           andSelectButton selectedButton: UIButton) {
        self.currentGrid = gridView
        guard let gridView = gridView as? UIView else { return }
        container.removeAllSubviews()
        container.addSubview(gridView)
        gridView.fillWithSuperView(container)
        HomeViewController.addSelectedView(on: selectedButton)
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
    
//    private func shareAction(_sender: UIPanGestureRecognizer) {
//
//    }
    
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

    // MARK: - Trait Collection

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if traitCollection.horizontalSizeClass == .compact, UIDevice.current.orientation == .portrait {
            viewModel.didChangeToCompact()
        } else {
            viewModel.didChangeToRegular()
        }
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

    func removeAllSubviews() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}

extension HomeViewController: GridDelegate {
    func didSelect(spot: Spot) {
        self.currentSpot = spot
        DispatchQueue.main.async {
            self.show(self.pickerController, sender: nil)
        }
    }
}

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage, let spot = currentSpot {
            self.currentGrid?.set(image: image, for: spot)
        }
        dismiss(animated: true, completion: nil)} // fermer le picker
}
