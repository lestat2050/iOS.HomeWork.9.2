//
//  ExhibitionCellConfigurator.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/20/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class ExhibitionCellConfigurator {
    
    let cellIdentifier = ExhibitionCell.identifier
    
    func configure(with cell: ConfigurableCell, model: ExhibitionProtocol) {
        guard let cell = cell as? ExhibitionCell else {
            fatalError("Not right view")
        }
        guard let model = model as? Exhibition else {
            fatalError("Not right model")
        }
        if !model.works.isEmpty, let imageName = model.works[0].imgPicture {
            cell.exhibitionImage.image = UIImage(named: imageName)
        }
        cell.galleryNameLabel.text = model.gallery?.name
        cell.exhibitionNameLabel.text = model.name
        cell.authorNameLabel.text = model.authorName
    }
    
}

extension ExhibitionCellConfigurator: ConfiguratorProtocol { }
