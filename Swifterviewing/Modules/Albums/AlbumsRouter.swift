//
//  AlbumsRouter.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import Foundation
import UIKit

///
class AlbumsRouter {

    // MARK: - Variables

    private let router: MainRouter
    private let albumService: AlbumService
    weak private var navigationController: UINavigationController?

    // MARK: - Life Cycle Method

    init(router: MainRouter, albumService: AlbumService) {
        
        self.router = router
        self.albumService = albumService
    }

    // MARK: - Assemble Methods
    
    func assembleInitialScreen() -> UINavigationController? {

        navigationController = R.storyboard.albums.instantiateInitialViewController()
        guard let nav = navigationController,
              let vc = nav.children.first as? AlbumListingViewController else {
            fatalError("Unable to get AlbumListingViewController.")
        }
        let interactor = AlbumListingInteractor(router: self, albumService: albumService)
        vc.interactor = interactor
        interactor.view = vc
        return navigationController
    }
    
    func assemblePhotosListingScreen(albumId: Int?) -> PhotoListingViewController {
        guard let vc = R.storyboard.albums.photoListingViewController() else {
            fatalError("Unable to get PhotoListingViewController")
        }
        let interactor = PhotoListingInteractor(router: self, albumService: albumService, albumId: albumId)
        vc.interactor = interactor
        interactor.view = vc
        return vc
    }
    
    // MARK: - Navigation Methods

    func navigateToPhotoListingScreen(albumId: Int?) {
        let vc = assemblePhotosListingScreen(albumId: albumId)
        navigationController?.pushViewController(vc, animated: true)
    }
}
