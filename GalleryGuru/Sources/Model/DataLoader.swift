//
//  DataLoader.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import Alamofire

class DataLoader {
    
    let exhibitionsRef = "https://gallery-guru-prod.herokuapp.com/exhibitions/"
    
    typealias ExibitionsLoadHandler = (_ exhibitions: [Exhibition]) -> Void
    
    func loadExhibitions(handler: @escaping ExibitionsLoadHandler) {
        Alamofire.request(exhibitionsRef).responseJSON { response in
            if let rawExhibitions = response.result.value as? [[String: Any]] {
                
                let exhibitions: [Exhibition] = rawExhibitions.map {
                    
                    let rawGallery = $0["gallery"] as? [String: Any]
                    let rawWorks = $0["works"] as? [[String: Any]]
                    
                    var gallery: Gallery? = nil
                    var works: [Work] = []
                    
                    if let rawWorks = rawWorks {
                        works = rawWorks.map {
                            
                            let rawImgPicture = $0["imgPicture"] as? [String: Any]
                            var imgPicture: String = ""
                            if let rawImgPicture = rawImgPicture {
                                imgPicture = rawImgPicture["name"] as! String
                            }
                            
                            let work = Work(id: $0["objectId"] as! String,
                                            size: $0["size"] as? String,
                                            title: $0["title"] as? String,
                                            imgPicture: imgPicture,
                                            type: $0["type"] as? String,
                                            author: $0["author"] as? String,
                                            galleryDescription: $0["schedule"] as? String,
                                            year: $0["year"] as? String)
                            return work
                        }
                    }
                    
                    if let rawGallery = rawGallery {
                        gallery = Gallery(id: rawGallery["objectId"] as! String,
                                          name: rawGallery["name"] as! String,
                                          galleryDescription: rawGallery["galleryDescription"] as? String,
                                          email: rawGallery["email"] as? String,
                                          facebook: rawGallery["facebook"] as? String,
                                          city: rawGallery["city"] as? String,
                                          schedule: rawGallery["schedule"] as? [String],
                                          address: rawGallery["address"] as? String,
                                          galleryLogo: rawGallery["galleryLogo"] as? String,
                                          link: rawGallery["link"] as? String,
                                          phone: rawGallery["phone"] as? String,
                                          latitude: rawGallery["latitude"] as? String,
                                          longitude: rawGallery["longitude"] as? String)
                    }
                    
                    let exhibition = Exhibition(id:$0["objectId"] as! String,
                                                authorName: $0["authorName"] as? String,
                                                gallery: gallery,
                                                name: $0["name"] as! String,
                                                authorDescription: $0["authorDescription"] as? String,
                                                dateStart: Date.from(dateString: $0["dateStart"] as? String),
                                                about: $0["about"] as? String,
                                                dataEnd: Date.from(dateString: $0["dateEnd"] as? String),
                                                works: works,
                                                likesCount: $0["likesCount"] as? Int ?? 0)
                    return exhibition
                }
                
                handler(exhibitions)
            }
            
        }
        
    }

}


