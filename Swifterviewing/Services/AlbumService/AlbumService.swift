//
//  AlbumService.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import SwiftyJSON

class AlbumService {
    
    // MARK: - Variables
    
    private let networkSerivce: NetworkService
    
    // MARK: - Life Cycle Methods
    
    init(networkSerivce: NetworkService) {
        self.networkSerivce = networkSerivce
    }
    
    // MARK: - API Methods
    func fetchAlbums(completionHandler: @escaping BasicCompletion) {
        
        networkSerivce.request(parameters: nil, apiPath: Endpoints.albumsEndpoint, httpMethod: .get, success: { (statusCode, response) in
            
            let jsonResponse = JSON(response)
            let basicResponse = BasicResponse(jsonResponse: jsonResponse, statusCode: statusCode)
            
            if basicResponse.success, let payload = basicResponse.payload {
                completionHandler(statusCode, true, payload, nil)
            } else {
                completionHandler(statusCode, false, nil, basicResponse.message)
            }
        }, failure: { (statusCode, error) in
            completionHandler(statusCode, false, nil, error?.localizedDescription)
        })
        
    }
    
    func fetchPhotos(ofAlbum albumId: Int?, completionHandler: @escaping BasicCompletion) {
        
        guard let albumId = albumId else {
            completionHandler(nil, false, nil, R.string.localizable.invalidAlbumId())
            return
        }
        
        let endpoint = Endpoints.albumsEndpoint + "/\(albumId)" + Endpoints.photosEndpoint
        networkSerivce.request(parameters: nil, apiPath: endpoint, httpMethod: .get, success: { (statusCode, response) in
            
            let jsonResponse = JSON(response)
            let basicResponse = BasicResponse(jsonResponse: jsonResponse, statusCode: statusCode)
            
            if basicResponse.success, let payload = basicResponse.payload {
                completionHandler(statusCode, true, payload, nil)
            } else {
                completionHandler(statusCode, false, nil, basicResponse.message)
            }
        }, failure: { (statusCode, error) in
            completionHandler(statusCode, false, nil, error?.localizedDescription)
        })
        
    }

}
