//
//  LayerCollectionViewCell.swift
//  EmojiBuilder
//
//  Created by Александр on 15.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class LayerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var layerImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 8.0
        
        self.containerView.layer.masksToBounds = true
        self.containerView.layer.cornerRadius = 5.0
    }
    
    public func setSelected(selected: Bool) {
        if selected {
            self.backgroundColor = UIColor.init(red: 0/255.0, green: 111/255.0, blue: 255/255.0, alpha: 1.0)
        }
        else {
            self.backgroundColor = UIColor.white
        }
    }

}
