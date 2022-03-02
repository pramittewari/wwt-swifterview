//
//  Album.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import SwiftyJSON

class Album {
    
    var userId: Int?
    var id: Int?
    var title: String?
    
    init(_ json: JSON?) {
        guard let json = json else { return }
        userId = json["userId"].int
        id = json["id"].int
        title = json["title"].string
    }
}

class Photo {
    
    var id: Int?
    var albumId: Int?
    var title: String?
    var thumbnail: String?
    var url: String?
    
    init(_ json: JSON?) {
        guard let json = json else { return }
        id = json["id"].int
        albumId = json["albumId"].int
        title = json["title"].string
        url = json["url"].string
        thumbnail = json["thumbnailUrl"].string
    }

}
