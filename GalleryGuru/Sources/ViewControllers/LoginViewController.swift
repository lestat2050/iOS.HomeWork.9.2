//
//  LoginViewController.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Outlets
    
    @IBOutlet private(set) weak var loginLaterButton: UIButton! {
        didSet {
            if let text = loginLaterButton.titleLabel!.text {
                loginLaterButton.underlineButton(text: text)
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
    
    //MARK: - Properties
    
    let loader = DataLoader()
    let previewScreenImages = [
        "previewScreen1",
        "previewScreen2",
        "previewScreen3"
    ]
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    //MARK: - Actions
    
    @IBAction func onTouchLoginLater(_ sender: UIButton) {
        let exhibitions = loader.loadExhibition()
        print(exhibitions)
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
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        self.previewImagesPageController.currentPage = indexPath.row
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

extension UIButton {
    func underlineButton(text: String) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName,
                                 value: NSUnderlineStyle.styleSingle.rawValue,
                                 range: NSMakeRange(0, text.characters.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
}
