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
                        if let rawGalleryLogo = rawGallery["galleryLogo"] as? [String: Any] {
                            gallery?.galleryLogo = rawGalleryLogo["name"] as? String
                        }
                        let rawSchedule = rawGallery["schedule"] as? [Any]
                        if let rawSchedule = rawSchedule {
                            if let schedule0 = rawSchedule[0] as? String {
                                gallery?.scheduleWeekdays = schedule0
                            }
                            if let schedule1 = rawSchedule[1] as? String {
                                gallery?.scheduleWeekend = schedule1
                            }
                        }
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
                    let rawDateStart = $0["dateStart"] as? [String: Any]
                    if let rawDateStart = rawDateStart {
                        exhibition.dateStart = Date.from(dateString: rawDateStart["iso"] as? String)
                    }
                    let rawDateEnd = $0["dateEnd"] as? [String: Any]
                    if let rawDateEnd = rawDateEnd{
                        exhibition.dateEnd = Date.from(dateString: rawDateEnd["iso"] as? String)
                    }
                    exhibition.about = $0["about"] as! String
                    exhibition.works = works
                    let rawLikesCount = $0["likesCount"] as? Int
                    if let likesCount = rawLikesCount {
                        exhibition.likesCount = RealmOptional(likesCount)
                    }
                    exhibition.links = $0["links"] as? String
                    
                    return exhibition
                }
                
                handler(exhibitions)
            }
            
        }
        
    }

}


