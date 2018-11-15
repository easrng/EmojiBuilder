//
//  AssetsViewController.swift
//  EmojiBuilder
//
//  Created by Александр on 15.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import Foundation
import UIKit

protocol AssetsViewControllerDelegate: AnyObject {
    func didPickImage(image: UIImage)
}

class AssetsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: AssetsViewControllerDelegate?
    
    private var facesArray: [String]!
    private var eyesArray: [String]!
    private var mouthsArray: [String]!
    private var accessoriesArray: [String]!
    
    private var headerTitles: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10.0
        layout.minimumLineSpacing = 10.0
        
        self.facesArray = []
        self.eyesArray = []
        self.mouthsArray = []
        self.accessoriesArray = []
        
        self.headerTitles = ["Face", "Eyes", "Mouth", "Accessories"]
        
        for i in 0..<10 {
            let imageName = "face\(i).png"
            self.facesArray.append(imageName)
        }
        
        for i in 0..<37 {
            let imageName = "eyes\(i).png"
            self.eyesArray.append(imageName)
        }
        
        for i in 0..<33 {
            let imageName = "mouth\(i).png"
            self.mouthsArray.append(imageName)
        }
        
        for i in 0..<29 {
            let imageName = "accessory\(i).png"
            self.accessoriesArray.append(imageName)
        }
        
        self.collectionView.setCollectionViewLayout(layout, animated: false)
        self.collectionView.contentInset = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 10.0)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "AssetCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "asset")
        self.collectionView.register(UINib(nibName: "AssetCollectionViewHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! AssetCollectionViewHeader
            view.titleLabel.text = self.headerTitles[indexPath.section]
            return view
        }
        else {
            fatalError("Unexpected UICollectionViewElementKind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 50.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return self.facesArray.count
        case 1:
            return self.eyesArray.count
        case 2:
            return self.mouthsArray.count
        case 3:
            return self.accessoriesArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "asset", for: indexPath) as! AssetCollectionViewCell
        
        if indexPath.section == 0 {
            cell.imageView.loadImage(imageName: self.facesArray[indexPath.row])
        }
        else if indexPath.section == 1 {
            cell.imageView.loadImage(imageName: self.eyesArray[indexPath.row])
        }
        else if indexPath.section == 2 {
            cell.imageView.loadImage(imageName: self.mouthsArray[indexPath.row])
        }
        else if indexPath.section == 3 {
            cell.imageView.loadImage(imageName: self.accessoriesArray[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let array = [self.facesArray, self.eyesArray, self.mouthsArray, self.accessoriesArray]
        let imageName = array[indexPath.section]![indexPath.row]
        if let delegate = self.delegate {
            delegate.didPickImage(image: UIImage(named: imageName)!)
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension UIImageView {
    
    
}

class AsyncImageView: UIImageView {
    
    var currentImageName: String?
    
    func loadImage(imageName: String) {
        
        self.image = nil
        self.currentImageName = imageName
        
        DispatchQueue.global(qos: .background).async {
            let image = UIImage(named: imageName)
            DispatchQueue.main.async {
                if self.currentImageName == imageName {
                    self.image = image
                }
            }
        }
    }
}
