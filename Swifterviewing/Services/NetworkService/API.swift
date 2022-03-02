//
//  API.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import Foundation

struct Network {
    static let baseURL = "https://jsonplaceholder.typicode.com"
}

struct Endpoints {
    static let photosEndpoint = "/photos" //returns photos and their album ID
    static let albumsEndpoint = "/albums" //returns an album, but without photos
}
