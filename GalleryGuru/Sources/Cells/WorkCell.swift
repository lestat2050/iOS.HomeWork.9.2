//
//  WorkCell.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 9/5/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class WorkCell: UICollectionViewCell {
 
    @IBOutlet private(set) weak var workImageView: UIImageView!
    
    static let identifier: String = String(describing: WorkCell.self)
    
}
