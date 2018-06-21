//
//  ComicCollectionViewCell.swift
//  Marvel Comic Library
//
//  Created by João  Pedro on 18/06/18.
//  Copyright © 2018 João  Pedro. All rights reserved.
//

import UIKit
import SDWebImage

class ComicCollectionViewCell:UICollectionViewCell {
    
    @IBOutlet weak var comicImage: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicAuthor: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
