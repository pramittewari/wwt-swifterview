//
//  PhotoListingViewController.swift
//  Swifterviewing
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class PhotoListingViewController: BaseViewController<PhotoListingInteractor> {
    
    @IBOutlet weak var photosTableView: UITableView!
    @IBOutlet weak var noDataWatermark: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactor?.fetchPhotos()
    }
    
    func reloadTable() {
        photosTableView.reloadData()
        noDataWatermark.isHidden = (interactor?.photos.count ?? -1) > 0
    }
}

extension PhotoListingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor?.photos.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.photoCell.identifier, for: indexPath) as? PhotoCell else
        { return UITableViewCell() }
        cell.setValues(photo: interactor?.photos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.photoCell.identifier, for: indexPath) as? PhotoCell else
        { return }
        cell.photoView.image = nil
    }
}

extension PhotoListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
