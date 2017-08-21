//
//  DataLoader.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation

class DataLoader {
    
    var exhibitions: [Exhibition] = []
    var galleries: [String: Gallery] = [:]
    var works: [String: Work] = [:]
    
    func loadExhibition() -> [Exhibition] {
        
        let exhibitionsRawArray = loadItems(from: "exhibitions")
        let galleriesRawArray = loadItems(from: "galleries")
        let worksRawArray = loadItems(from: "works")
        
        worksRawArray.forEach {
            let workID = $0["_id"] as! String
            let work = Work(id: workID,
                            size: $0["size"] as? String,
                            title: $0["title"] as? String,
                            imgPicture: $0["imgPicture"] as? String,
                            type: $0["type"] as? String,
                            author: $0["author"] as? String,
                            galleryDescription: $0["schedule"] as? String,
                            year: $0["year"] as? String)
            
            works[workID] = work
        }
        
        galleriesRawArray.forEach {
            let galleryID = $0["_id"] as! String
            let gallery = Gallery(id: galleryID,
                                  name: $0["name"] as! String,
                                  galleryDescription: $0["galleryDescription"] as? String,
                                  email: $0["email"] as? String,
                                  facebook: $0["facebook"] as? String,
                                  city: $0["city"] as? String,
                                  schedule: $0["schedule"] as? [String],
                                  address: $0["address"] as? String,
                                  galleryLogo: $0["galleryLogo"] as? String,
                                  link: $0["link"] as? String,
                                  phone: $0["phone"] as? String,
                                  latitude: $0["latitude"] as? String,
                                  longitude: $0["longitude"] as? String)
            
            galleries[galleryID] = gallery
        }
        
        exhibitions = exhibitionsRawArray.map {
            
            let galleryRawID = $0["_p_gallery"] as! String
            let galleryID = galleryRawID.replacingOccurrences(of: "Gallery$", with: "")
            let worksRawArray = $0["works"] as? [[String: Any]]
            
            var worksInExhibition: [Work] = []
            
            if let worksRawArray = worksRawArray {
                worksRawArray.forEach {
                    let workID = $0["objectId"] as! String
                    if let work = works[workID] {
                        worksInExhibition.append(work)
                    }
                }
            }
            
            return Exhibition(id: $0["_id"] as! String,
                              authorName: $0["authorName"] as? String,
                              gallery: galleries[galleryID],
                              name: $0["name"] as! String,
                              authorDescription: $0["authorDescription"] as? String,
                              dateStart: Date.from(dateString: $0["dateStart"] as? String),
                              about: $0["authorName"] as? String,
                              dataEnd: Date.from(dateString: $0["dataEnd"] as? String),
                              works: worksInExhibition,
                              likesCount: $0["likesCount"] as? Int ?? 0)
        }
        
        return exhibitions
    }
    
    private func loadItems(from fileName: String) -> [[String: Any]] {
        guard let url = Bundle.main.url(forResource: fileName,
                                        withExtension: "json") else {
                                            fatalError("No such file")
        }
        
        guard let RawData = try? Data(contentsOf: url) else {
            fatalError("Can't read data")
        }
        
        guard let RawArray = try! JSONSerialization.jsonObject(with:
            RawData) as? [[String: Any]] else {
                fatalError("Wrong json format")
        }
        
        return RawArray
    }
    
}

extension Date {

    static func from(dateString: String?) -> Date? {
        guard let dateString = dateString else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss'Z'"
        return dateFormatter.date(from: dateString)
    }
    
}
