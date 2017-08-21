//
//  ExhibitionDetailVC.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class ExhibitionDetailVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private(set) weak var exhibitionNameLabel: UILabel!
    
    // MARK: - Properties
    
    weak var selectedExhibition: Exhibition?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.setNavigationBarHidden(false, animated: true)
        loadSelectedExhibition()
    }
    
    // MARK: - Methods
    
    private func loadSelectedExhibition() {
        if let selectedExhibition = selectedExhibition {
            exhibitionNameLabel.text = selectedExhibition.name
        }
    }

}

