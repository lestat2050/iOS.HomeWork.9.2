//
//  Gallery.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import RealmSwift

class Gallery: Object {
    
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var galleryDescription: String? = ""
    dynamic var email: String? = ""
    dynamic var facebook: String? = ""
    dynamic var city: String? = ""
    dynamic var address: String? = ""
    dynamic var galleryLogo: String? = ""
    dynamic var link: String? = ""
    dynamic var phone: String? = ""
    dynamic var latitude: String? = ""
    dynamic var longitude: String? = ""
    
}
