//
//  PhotoListingViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumListingViewController: BaseViewController<AlbumListingInteractor> {
    
    @IBOutlet weak var albumsTableView: UITableView!
    @IBOutlet weak var noDataWatermark: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchAlbums()
    }
    
    func reloadTable() {
        albumsTableView.reloadData()
        noDataWatermark.isHidden = (interactor?.albums.count ?? -1) > 0
    }
}

extension AlbumListingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.albums.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.albumCell.identifier, for: indexPath) as? AlbumCell else
        { return UITableViewCell() }
        cell.setValues(album: interactor?.albums[indexPath.row])
        return cell
    }
}

extension AlbumListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        interactor?.navigateToPhotoListingViewController(forAlbumIndex: indexPath)
    }
}
