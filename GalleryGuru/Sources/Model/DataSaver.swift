//
//  DataSaver.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/25/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import RealmSwift

class DataSaver {
    
    var exhibitions: Results<Exhibition>
    private var token: NotificationToken?
    
    init() {
        let realm = try! Realm()
        exhibitions = realm.objects(Exhibition.self)
    }
    
    func add(_ exhibition: Exhibition) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(exhibition, update: true)
        }
    }
    
    func subscribeOnChanges() {
        self.token = exhibitions.addNotificationBlock { (_) in
            self.sendNotificationAboutUpdateModel()
        }
    }
    
    private func sendNotificationAboutUpdateModel() {
        NotificationCenter.default.post(name: exhibitionUpdateNotificationName,
                                        object: nil)
    }

}
