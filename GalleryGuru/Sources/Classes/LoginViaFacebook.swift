//
//  LoginViaFacebook.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/16/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

class LoginViaFacebook: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentEdgeInsets = UIEdgeInsets(top: 15, left: 40, bottom: 15, right: 40)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }

}
