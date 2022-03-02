//
//  MainRouter.swift
//  Brenius
//
//  Created by Pramit Tewari on 20/01/22.
//

import Foundation
import UIKit

/// Implementation of MainRouting
final class MainRouter {
    
    // MARK: - Variables
    
    private let window: UIWindow
    
    /// Root view controller of the app
    private var rootVC: UIViewController? {
        return window.rootViewController
    }
    
    // MARK: Services
    
    private lazy var notificationService: NotificationService = NotificationService()
    private lazy var networkService: NetworkService = NetworkService(notificationService: notificationService)
    private lazy var albumService: AlbumService = AlbumService(networkSerivce: networkService)
    
    // MARK: - Life Cycle Methods
    
    /**
     Initialize the router with required dependencies
     
     - parameter window: The root window of the application
     */
    init(window: UIWindow) {
        
        self.window = window
        
    }
    
    // MARK: - Navigaiton methods
    
    /// Set rootVC
    func setInititalViewController() {
        
        guard let vc = AlbumsRouter(router: self, albumService: albumService).assembleInitialScreen() else { return }
        window.rootViewController = vc
    }
}
