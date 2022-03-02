//
//  AlbumCell.swift
//  Swifterviewing
//
//  Created by Pramit Tewari on 02/03/22.
//  Copyright © 2022 World Wide Technology Application Services. All rights reserved.
//

import UIKit

class AlbumCell: UITableViewCell {

    @IBOutlet weak var actualTitle: UILabel!
    @IBOutlet weak var modifiedTitle: UILabel!
    
    func setValues(album: Album?) {
        
        guard let album = album else { return }
        actualTitle.text = album.title
        modifiedTitle.text = album.title?.replacingOccurrences(of: "E", with: "").replacingOccurrences(of: "e", with: "")
    }
}
