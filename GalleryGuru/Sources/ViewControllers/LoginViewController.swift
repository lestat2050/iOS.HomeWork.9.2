//
//  LoginViewController.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private(set) weak var loginViaFacebook: UIButton! {
        didSet {
            loginViaFacebook.layer.cornerRadius = loginViaFacebook.frame.height / 2
        }
    }
    @IBOutlet private(set) weak var loginLaterButton: UIButton! {
        didSet {
            if let text = loginLaterButton.titleLabel!.text {
                loginLaterButton.underlineLabel(text: text)
            }
        }
    }
    @IBOutlet private(set) weak var previewImagesPageController: UIPageControl!
    @IBOutlet private(set) weak var previewScreenCollectionView: UICollectionView! {
        didSet {
            previewScreenCollectionView.dataSource = self
            previewScreenCollectionView.delegate = self
        }
    }
    
    // MARK: - Properties
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension LoginViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width,
                      height: collectionView.frame.height)
    }
    
}

extension LoginViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didEndDisplaying cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        let indexPage = collectionView.contentOffset.x / collectionView.frame.width
        self.previewImagesPageController.currentPage = Int(indexPage)
    }

}

extension LoginViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return previewScreenImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
            PreviewScreenCell.identifier, for: indexPath) as! PreviewScreenCell
        
        cell.previewImage.image = UIImage(named: previewScreenImages[indexPath.row])
        
        return cell
    }
    
}
