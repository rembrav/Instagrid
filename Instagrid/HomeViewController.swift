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
    
    private lazy var swipeleftGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(shareAction(_:)))
        swipeLeftGesture.direction = .left
        return swipeLeftGesture
    }()
    
    private lazy var swipeUpGestureRecognizer: UISwipeGestureRecognizer = {
        let swipeUpGesture = UISwipeGestureRecognizer(target: self, action: #selector(shareAction(_:)))
        swipeUpGesture.direction = .up
        return swipeUpGesture
    }()
    
    private var currentGrid: GridType? {
        didSet {
            let viewModel = GridViewModel()
            currentGrid?.configure(with: viewModel, delegate: self)
        }
    }
    private var currentSpot : Spot?
    
    
    // MARK: - View life cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setGestures()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGestures()
        bind(to: viewModel)
        viewModel.viewDidLoad()
    }
    
    private func bind(to viewModel: HomeViewModel) {
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
    
    @objc private func shareAction(_ sender: UISwipeGestureRecognizer) {
        let translation = CGAffineTransform(translationX: 0, y: -730)
        let size = CGAffineTransform(scaleX: 0.4, y: 0.4)
        let transformed = translation.concatenating(size)
        let outLandscapeScreen = CGAffineTransform(translationX: -self.view.bounds.width, y: 1500)
        let rotation = CGAffineTransform(rotationAngle: 260)
        let rotateAndOut = outLandscapeScreen.concatenating(rotation)
        if sender.direction == .up {
            UIView.animate(withDuration: 0.8, animations: {
                self.gridContainerView.transform = transformed
                self.gridContainerView.alpha = 0.5
            }) { _ in
                self.sharePhoto()
            }
        } else {
            UIView.animate(withDuration: 1.5, animations: {
                self.gridContainerView.transform = rotateAndOut
            }) { _ in
                self.sharePhoto()
            }
        }
    }
    
    func sharePhoto() {
        UIGraphicsBeginImageContext(gridContainerView.frame.size)
        gridContainerView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        let aVControl = UIActivityViewController(activityItems: [image!],applicationActivities: nil )
        aVControl.popoverPresentationController?.sourceView = self.view
        aVControl.completionWithItemsHandler = {activity,success,items,error in
            if self.swipeUpGestureRecognizer.direction == .up {
                UIView.animate(withDuration: 0.5, animations: {
                    self.gridContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
                    self.gridContainerView.alpha = 1
                })
        } else  {
            UIView.animate(withDuration: 0.3, animations: {
                self.gridContainerView.transform = CGAffineTransform(translationX: 0, y: 0)
            })
            }
        }
        self.present(aVControl, animated: true, completion: nil)
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
    
    // MARK: - Trait Collection
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            self.setGestures()
        })
    }
    
    
    private func setGestures() {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
            else { return }
        gridContainerView.gestureRecognizers?.removeAll()
        
        if orientation.isPortrait {
            gridContainerView.addGestureRecognizer(swipeUpGestureRecognizer)
            viewModel.didChangeToCompact()
        } else {
            gridContainerView.addGestureRecognizer(swipeleftGestureRecognizer)
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
