//
//  AlbumListingInteractor.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import SwiftUI

class AlbumListingInteractor: Interacting {
    
    // MARK: - Variables
    
    let router: AlbumsRouter?
    var albumService: AlbumService?
    weak var view: AlbumListingViewController?
    var albums: [Album] = []
    
    // MARK: - Life cycle methods
    
    init(router: AlbumsRouter, albumService: AlbumService) {
        self.router = router
        self.albumService = albumService
    }
    
    func fetchAlbums() {
        
        view?.showProgressHudView()
        albumService?.fetchAlbums(completionHandler: { [weak self] statusCode, isSuccess, data, error in
           
            self?.view?.hideProgressHudView()
            guard isSuccess else {
                self?.albums = []
                self?.view?.reloadTable()
                return
            }
            self?.albums = []
            data?.array?.forEach({ (album) in
                self?.albums.append(Album(album))
            })
            self?.view?.reloadTable()
        })
    }
    
    func navigateToPhotoListingViewController(forAlbumIndex index: IndexPath) {
        router?.navigateToPhotoListingScreen(albumId: albums[index.row].id)
    }
}
