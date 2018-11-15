//
//  AssetCollectionViewCell.swift
//  EmojiBuilder
//
//  Created by Александр on 15.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class AssetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 4.0
    }
}
