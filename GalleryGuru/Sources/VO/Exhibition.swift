//
//  Exhibition.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import RealmSwift

class Exhibition: Object {
 
    dynamic var id: String = ""
    dynamic var authorName: String = ""
    dynamic var gallery: Gallery? = nil
    dynamic var name: String = ""
    dynamic var authorDescription: String = ""
    dynamic var dateStart: Date? = nil
    dynamic var about: String = ""
    dynamic var dataEnd: Date? = nil
    var works: List<Work> = List()
    var likesCount = RealmOptional<Int>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
}

extension Exhibition: ExhibitionProtocol { }

