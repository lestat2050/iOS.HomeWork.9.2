//
//  LoadingVC.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit
import RealmSwift

class LoadingVC: UIViewController {

    // MARK: - Prorerties
    
    private let loader = DataLoader()
    private let saver = DataSaver()
    private var isLoadingFromDatabase: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDataFromDatabase()
        loadDataFromSite()
    }
    
    // MARK: - Methods
    
    private func loadDataFromDatabase() -> Void {
        let exhibitionsFromDatabase = saver.exhibitions
        let exhibitions: [Exhibition]
        if !exhibitionsFromDatabase.isEmpty {
            isLoadingFromDatabase = true
            exhibitions = Array(exhibitionsFromDatabase)
            show(exhibitions)
        }
    }
    
    private func loadDataFromSite() -> Void {
        loader.loadExhibitions { (exhibitions: [Exhibition]) in
            if !self.isLoadingFromDatabase {
                self.show(exhibitions)
            }
            exhibitions.forEach {
                self.saver.add($0)
            }
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
