//
//  GraphicsComposer.swift
//  EmojiBuilder
//
//  Created by Александр on 15.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class GraphicsComposer: NSObject {
    public func renderEmoji(inputImages: [UIImage]) -> UIImage {
        let imageSize = CGSize(width: 64.0, height: 64.0)
        UIGraphicsBeginImageContextWithOptions(imageSize, false, UIScreen.main.scale)
        for image in inputImages {
            image.draw(in: CGRect(x: 0.0, y: 0.0, width: imageSize.width, height: imageSize.height))
        }
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return finalImage!
    }
    
    public func exportEmoji(inputImages: [UIImage]) {
        if inputImages.count > 1 {
            let renderedImage = self.renderEmoji(inputImages: inputImages)
            UIImageWriteToSavedPhotosAlbum(renderedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {print(error.localizedDescription)}
    }
}
