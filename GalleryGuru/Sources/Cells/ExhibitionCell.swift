//
//  ExhibitionCell.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class ExhibitionCell: UITableViewCell {

    @IBOutlet private(set) weak var exhibitionImage: UIImageView!
    @IBOutlet private(set) weak var galleryNameLabel: UILabel!
    @IBOutlet private(set) weak var exhibitionNameLabel: UILabel!
    @IBOutlet private(set) weak var authorNameLabel: UILabel!
    
    static let identifier: String = String(describing: ExhibitionCell.self)
    
}

extension ExhibitionCell: ConfigurableCell { }
