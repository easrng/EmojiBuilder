//
//  ComposeViewController.swift
//  EmojiBuilder
//
//  Created by Александр on 15.11.2018.
//  Copyright © 2018 Александр. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AssetsViewControllerDelegate {
    
    private let menuBarHeight: CGFloat = 190.0
    private let foregroundColor: UIColor = UIColor.init(red: 220/255.0, green: 220/255.0, blue: 220/255.0, alpha: 1.0)
    
    private var barContainerView: UIView!
    private var barView: UIView!
    
    private var imageContainerView: UIView!
    private var emojiImageView: UIImageView!
    
    private var addButton: UIButton!
    private var mirrorButton: UIButton!
    private var removeButton: UIButton!
    
    private var leftButtonContainer: UIView!
    private var middleButtonContainer: UIView!
    private var rightButtonContainer: UIView!
    
    private var collectionView: UICollectionView!
    private var selectedItemIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    private var layersArray: [UIImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = self.foregroundColor
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.title = "Emoji Builder"
        
        self.layersArray = []
        
        var bottomSafeAreaInset: CGFloat?
        if #available(iOS 11.0, *) {
            bottomSafeAreaInset = UIApplication.shared.keyWindow?.safeAreaInsets.bottom
        } else {bottomSafeAreaInset = 0.0}
        
        self.barContainerView = UIView()
        self.barContainerView.backgroundColor = self.foregroundColor
        self.barContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.barContainerView)
        
        self.barContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.barContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.barContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0.0).isActive = true
        self.barContainerView.heightAnchor.constraint(equalToConstant: menuBarHeight + bottomSafeAreaInset!).isActive = true
        
        self.barView = UIView()
        self.barView.backgroundColor = UIColor.clear
        self.barView.translatesAutoresizingMaskIntoConstraints = false
        self.barContainerView.addSubview(self.barView)
        
        self.barView.topAnchor.constraint(equalTo: self.barContainerView.topAnchor, constant: 0.0).isActive = true
        self.barView.leftAnchor.constraint(equalTo: self.barContainerView.leftAnchor, constant: 0.0).isActive = true
        self.barView.rightAnchor.constraint(equalTo: self.barContainerView.rightAnchor, constant: 0.0).isActive = true
        self.barView.heightAnchor.constraint(equalToConstant: self.menuBarHeight).isActive = true
        
        self.imageContainerView = UIView()
        self.imageContainerView.backgroundColor = UIColor.clear
        self.imageContainerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.imageContainerView)
        
        self.imageContainerView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0.0).isActive = true
        self.imageContainerView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0.0).isActive = true
        self.imageContainerView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0.0).isActive = true
        self.imageContainerView.bottomAnchor.constraint(equalTo: self.barContainerView.topAnchor, constant: 0.0).isActive = true
        
        self.emojiImageView = UIImageView()
        self.emojiImageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageContainerView.addSubview(self.emojiImageView)
        
        self.emojiImageView.heightAnchor.constraint(equalToConstant: 64.0).isActive = true
        self.emojiImageView.widthAnchor.constraint(equalToConstant: 64.0).isActive = true
        self.emojiImageView.centerXAnchor.constraint(equalTo: self.imageContainerView.centerXAnchor, constant: 0.0).isActive = true
        self.emojiImageView.centerYAnchor.constraint(equalTo: self.imageContainerView.centerYAnchor, constant: 0.0).isActive = true
        
        self.layersArray = [UIImage(named: "face5.png")!, UIImage(named: "eyes8.png")!, UIImage(named: "mouth16.png")!]
        let renderedImage = GraphicsComposer().renderEmoji(inputImages: self.layersArray)
        self.emojiImageView.image = renderedImage
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10.0
        layout.minimumInteritemSpacing = 10.0
        
        self.collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: "LayerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "layer")
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 10.0, bottom: 0, right: 10.0)
        self.collectionView.isScrollEnabled = true
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.barView.addSubview(self.collectionView)
        
        self.collectionView.topAnchor.constraint(equalTo: self.barView.topAnchor).isActive = true
        self.collectionView.leftAnchor.constraint(equalTo: self.barView.leftAnchor).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.barView.rightAnchor).isActive = true
        self.collectionView.heightAnchor.constraint(equalToConstant: 75.0).isActive = true
        
        self.leftButtonContainer = UIView()
        self.leftButtonContainer.backgroundColor = UIColor.clear
        self.leftButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.barView.addSubview(self.leftButtonContainer)
        
        self.leftButtonContainer.leftAnchor.constraint(equalTo: self.barView.leftAnchor).isActive = true
        self.leftButtonContainer.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        self.leftButtonContainer.bottomAnchor.constraint(equalTo: self.barView.bottomAnchor).isActive = true
        self.leftButtonContainer.widthAnchor.constraint(equalTo: self.barView.widthAnchor, multiplier: 1/3).isActive = true
        
        self.addButton = UIButton()
        self.addButton.setImage(UIImage(named: "Add"), for: .normal)
        self.addButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        self.addButton.translatesAutoresizingMaskIntoConstraints = false
        self.leftButtonContainer.addSubview(self.addButton)
        
        self.addButton.centerXAnchor.constraint(equalTo: self.leftButtonContainer.centerXAnchor).isActive = true
        self.addButton.centerYAnchor.constraint(equalTo: self.leftButtonContainer.centerYAnchor).isActive = true
        self.addButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        self.addButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        self.rightButtonContainer = UIView()
        self.rightButtonContainer.backgroundColor = UIColor.clear
        self.rightButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.barView.addSubview(self.rightButtonContainer)
        
        self.rightButtonContainer.rightAnchor.constraint(equalTo: self.barView.rightAnchor).isActive = true
        self.rightButtonContainer.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        self.rightButtonContainer.bottomAnchor.constraint(equalTo: self.barView.bottomAnchor).isActive = true
        self.rightButtonContainer.widthAnchor.constraint(equalTo: self.barView.widthAnchor, multiplier: 1/3).isActive = true
        
        self.removeButton = UIButton()
        self.removeButton.setImage(UIImage(named: "Remove"), for: .normal)
        self.removeButton.addTarget(self, action: #selector(removeButtonPressed(_:)), for: .touchUpInside)
        self.removeButton.translatesAutoresizingMaskIntoConstraints = false
        self.rightButtonContainer.addSubview(self.removeButton)
        
        self.removeButton.centerXAnchor.constraint(equalTo: self.rightButtonContainer.centerXAnchor).isActive = true
        self.removeButton.centerYAnchor.constraint(equalTo: self.rightButtonContainer.centerYAnchor).isActive = true
        self.removeButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        self.removeButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        self.middleButtonContainer = UIView()
        self.middleButtonContainer.backgroundColor = UIColor.clear
        self.middleButtonContainer.translatesAutoresizingMaskIntoConstraints = false
        self.barView.addSubview(self.middleButtonContainer)
        
        self.middleButtonContainer.topAnchor.constraint(equalTo: self.collectionView.bottomAnchor).isActive = true
        self.middleButtonContainer.leftAnchor.constraint(equalTo: self.leftButtonContainer.rightAnchor).isActive = true
        self.middleButtonContainer.bottomAnchor.constraint(equalTo: self.barView.bottomAnchor).isActive = true
        self.middleButtonContainer.rightAnchor.constraint(equalTo: self.rightButtonContainer.leftAnchor).isActive = true
        
        self.mirrorButton = UIButton()
        self.mirrorButton.setImage(UIImage(named: "Mirror"), for: .normal)
        self.mirrorButton.addTarget(self, action: #selector(mirrorButtonPressed(_:)), for: .touchUpInside)
        self.mirrorButton.translatesAutoresizingMaskIntoConstraints = false
        self.middleButtonContainer.addSubview(self.mirrorButton)
        
        self.mirrorButton.centerXAnchor.constraint(equalTo: self.middleButtonContainer.centerXAnchor).isActive = true
        self.mirrorButton.centerYAnchor.constraint(equalTo: self.middleButtonContainer.centerYAnchor).isActive = true
        self.mirrorButton.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
        self.mirrorButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        
        let saveButton = UIBarButtonItem.init(title: "Save", style: .plain, target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = saveButton
        
    }
    
    //Actions
    
    @objc func saveButtonPressed(_ sender: Any) {
        GraphicsComposer().exportEmoji(inputImages: self.layersArray)
    }
    
    @objc func addButtonPressed(_ sender: Any) {
        let controller = AssetsViewController()
        controller.delegate = self
        self.present(controller, animated: true, completion: nil)
    }
    
    @objc func mirrorButtonPressed(_ sender: Any) {
        if self.layersArray.count > 0 {
            let imageToFlip = self.layersArray[self.selectedItemIndex.row]
            let flippedImage = self.flipImage(image: imageToFlip)
            self.layersArray.remove(at: self.selectedItemIndex.row)
            self.layersArray.insert(flippedImage, at: selectedItemIndex.row)
            
            self.collectionView.reloadData()
            self.emojiImageView.image = GraphicsComposer().renderEmoji(inputImages: self.layersArray)
        }
    }
    
    @objc func removeButtonPressed(_ sender: Any) {
        if self.layersArray.count > 0 {
            self.layersArray.remove(at: self.selectedItemIndex.row)
            if self.layersArray.count > 1 {
                self.selectedItemIndex = IndexPath(row: self.layersArray.count - 1, section: 0)
            }
            else {
                self.selectedItemIndex = IndexPath(row: 0, section: 0)
            }
            self.collectionView.reloadData()
            self.emojiImageView.image = GraphicsComposer().renderEmoji(inputImages: self.layersArray)
        }
    }
    
    func didPickImage(image: UIImage) {
        self.layersArray.append(image)
        self.collectionView.reloadData()
        self.emojiImageView.image = GraphicsComposer().renderEmoji(inputImages: self.layersArray)
        
        self.selectedItemIndex = IndexPath(row: self.layersArray.count - 1, section: 0)
        self.collectionView.reloadData()
    }
    
    //UICollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.layersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "layer", for: indexPath) as! LayerCollectionViewCell
        
        cell.layerImageView.image = self.layersArray[indexPath.row]
        
        if indexPath == self.selectedItemIndex {
            cell.setSelected(selected: true)
        }
        else {cell.setSelected(selected: false)}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset: CGFloat = 10.0
        let cellHight = collectionView.bounds.size.height - 2*inset
        return CGSize(width: cellHight, height: cellHight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let previousCell = collectionView.cellForItem(at: self.selectedItemIndex) as! LayerCollectionViewCell
        previousCell.setSelected(selected: false)
        
        let currentCell = collectionView.cellForItem(at: indexPath) as! LayerCollectionViewCell
        currentCell.setSelected(selected: true)
        self.selectedItemIndex = indexPath
    }
    
    //Helpers
    
    private func flipImage(image: UIImage) -> UIImage {
        var flippedImage: UIImage = UIImage()
        if image.imageOrientation.rawValue == 0 {
            let originalImage = image.cgImage
            flippedImage = UIImage.init(cgImage: originalImage!, scale: UIScreen.main.scale, orientation: UIImage.Orientation.upMirrored)
        }
        if image.imageOrientation.rawValue == 4 {
            let originalImage = image.cgImage
            flippedImage = UIImage.init(cgImage: originalImage!, scale: UIScreen.main.scale, orientation: UIImage.Orientation.up)
        }
        return flippedImage
    }

}
