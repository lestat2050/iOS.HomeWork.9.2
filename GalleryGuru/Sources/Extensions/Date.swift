//
//  Date.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/24/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation

extension Date {
    
    static func from(dateString: String?) -> Date? {
        guard let dateString = dateString else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'.000Z'"
        return dateFormatter.date(from: dateString)
    }
    
}
