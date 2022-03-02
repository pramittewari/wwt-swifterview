//
//  PhotoListingInteractor.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import SwiftUI

class PhotoListingInteractor: Interacting {
    
    // MARK: - Variables
    
    let router: AlbumsRouter?
    var albumService: AlbumService?
    weak var view: PhotoListingViewController?
    var albumId: Int?
    var photos: [Photo] = []
    
    // MARK: - Life cycle methods
    
    init(router: AlbumsRouter, albumService: AlbumService, albumId: Int?) {
        self.router = router
        self.albumService = albumService
        self.albumId = albumId
    }
    
    func fetchPhotos() {
        
        view?.showProgressHudView()
        albumService?.fetchPhotos(ofAlbum: albumId, completionHandler: { [weak self] statusCode, isSuccess, data, error in
           
            self?.view?.hideProgressHudView()
            guard isSuccess else {
                self?.photos = []
                self?.view?.reloadTable()
                return
            }
            self?.photos = []
            data?.array?.forEach({ (photo) in
                self?.photos.append(Photo(photo))
            })
            self?.view?.reloadTable()
        })
    }
}
