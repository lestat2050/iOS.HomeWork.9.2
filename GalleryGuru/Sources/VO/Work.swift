//
//  Work.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import RealmSwift

class Work: Object {

    dynamic var id: String = ""
    dynamic var size: String? = ""
    dynamic var title: String? = ""
    dynamic var imgPicture: String = ""
    dynamic var type: String? = ""
    dynamic var author: String = ""
    dynamic var year: String? = ""
    
}
