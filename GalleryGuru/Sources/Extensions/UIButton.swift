//
//  UIButton.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/24/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import UIKit

extension UIButton {
    func underlineLabel(text: String) {
        let titleString = NSMutableAttributedString(string: text)
        titleString.addAttribute(NSUnderlineStyleAttributeName,
                                 value: NSUnderlineStyle.styleSingle.rawValue,
                                 range: NSMakeRange(0, text.characters.count))
        self.setAttributedTitle(titleString, for: .normal)
    }
}
