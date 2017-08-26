//
//  DataLoader.swift
//  GalleryGuru
//
//  Created by Yaroslav Surovtsev on 8/8/17.
//  Copyright © 2017 Yaroslav Surovtsev. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

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
                    let works: List<Work> = List()
                    
                    if let rawWorks = rawWorks {
                        rawWorks.forEach {
                            let rawImgPicture = $0["imgPicture"] as? [String: Any]
                            var imgPicture: String = ""
                            if let rawImgPicture = rawImgPicture {
                                imgPicture = rawImgPicture["name"] as! String
                            }
                            let work = Work()
                            work.id = $0["objectId"] as! String
                            work.size = $0["size"] as? String
                            work.title = $0["title"] as? String
                            work.imgPicture = imgPicture
                            work.type = $0["type"] as? String
                            work.author = $0["author"] as! String
                            work.year = $0["year"] as? String
                            
                            works.append(work)
                        }
                    }
                    
                    if let rawGallery = rawGallery {
                        gallery = Gallery()
                        gallery?.id = rawGallery["objectId"] as! String
                        gallery?.name = rawGallery["name"] as! String
                        gallery?.galleryDescription = rawGallery["galleryDescription"] as? String
                        gallery?.email = rawGallery["email"] as? String
                        gallery?.facebook = rawGallery["facebook"] as? String
                        gallery?.city = rawGallery["city"] as? String
                        gallery?.address = rawGallery["address"] as? String
                        gallery?.galleryLogo = rawGallery["galleryLogo"] as? String
                        gallery?.link = rawGallery["link"] as? String
                        gallery?.phone = rawGallery["phone"] as? String
                        gallery?.latitude = rawGallery["latitude"] as? String
                        gallery?.longitude = rawGallery["longitude"] as? String
                    }
                    
                    let exhibition = Exhibition()
                    exhibition.id = $0["objectId"] as! String
                    exhibition.authorName = $0["authorName"] as! String
                    exhibition.gallery = gallery
                    exhibition.name = $0["name"] as! String
                    exhibition.authorDescription = $0["authorDescription"] as! String
                    exhibition.dateStart = Date.from(dateString: $0["dateStart"] as? String)
                    exhibition.about = $0["about"] as! String
                    exhibition.dataEnd = Date.from(dateString: $0["dateEnd"] as? String)
                    exhibition.works = works
                    let rawLikesCount = $0["likesCount"] as? Int
                    if let likesCount = rawLikesCount {
                        exhibition.likesCount = RealmOptional(likesCount)
                    }
                    
                    return exhibition
                }
                
                handler(exhibitions)
            }
            
        }
        
    }

}


