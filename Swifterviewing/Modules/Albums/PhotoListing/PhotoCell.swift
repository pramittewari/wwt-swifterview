//
//  PhotoCell.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UITableViewCell {

    @IBOutlet weak var actualTitle: UILabel!
    @IBOutlet weak var modifiedTitle: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    func setValues(photo: Photo?) {
        
        guard let photo = photo else { return }
        actualTitle.text = photo.title
        modifiedTitle.text = photo.title?.replacingOccurrences(of: "E", with: "").replacingOccurrences(of: "e", with: "")
        
        photoView.image = nil
        let options: [KingfisherOptionsInfoItem] = [
            .processor(DownsamplingImageProcessor(size: photoView.bounds.size)),
            .scaleFactor(UIScreen.main.scale),
            .cacheOriginalImage
        ]

        if let thumbnail = URL(string: photo.thumbnail ?? "") {
            setThumbnail(withURL: thumbnail, options: options)
        } else {
            // Assign Placeholder
        }
    }
    
    func setThumbnail(withURL url: URL, options: KingfisherOptionsInfo) {
        
        DispatchQueue.global().async {
            KingfisherManager.shared.retrieveImage(with: ImageResource(downloadURL: url), options: options) { [weak self] (result) in
                switch result {
                case .success(let imageResult):
                    DispatchQueue.main.async {
                        self?.photoView.image = imageResult.image//img
                    }
                case .failure(let error):
                    print(error)
                    DispatchQueue.main.async {
                        // Assign Placeholder
                    }
                }
            }
        }
    }
}
