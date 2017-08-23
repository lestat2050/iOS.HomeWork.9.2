//
//  LoadingVC.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class LoadingVC: UIViewController {

    // MARK: - Prorerties
    
    private let loader = DataLoader()
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    // MARK: - Methods
    
    func loadData() -> Void {
        loader.loadExhibitions { (exhibitions: [Exhibition]) in
            self.show(exhibitions)
        }
    }
    
    private func show(_ exhibitions: [Exhibition]) {
        guard let nc = navigationController else {
            fatalError("No Navigation Controller")
        }
        guard let exhibitionVC = storyboard?.instantiateViewController(withIdentifier:
            "ExhibitionVC") as? ExhibitionListVC else {
                fatalError("No such vc identifier exhibition")
        }
        exhibitionVC.exhibitions = exhibitions
        nc.setViewControllers([exhibitionVC], animated: true)
    }

}
