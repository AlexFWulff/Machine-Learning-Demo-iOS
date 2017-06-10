//
//  PhotoViewer.swift
//  MLTest
//
//  Created by Jon Vogel on 6/8/17.
//  Copyright © 2017 Conifer Apps. All rights reserved.
//

import UIKit


class PhotoViewer: UIView {
    
    
    var flowLayout = UICollectionViewFlowLayout()
    var collection: UICollectionView?
    
    var onSelection: ((_ image: UIImage) -> Void)?
    
    var images = [UIImage]() {
        didSet{
            self.collection?.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepare()
    }
    
    func getCenterIndexPath() -> IndexPath? {
        guard let collect = self.collection else {
            return nil
        }
        
        guard let point = self.collection?.convert(collect.center, from: self) else{
            return nil
        }
        
        guard let ip = self.collection?.indexPathForItem(at: point) else {
            return nil
        }
        
        return ip
    }
    
}


extension PhotoViewer: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let Cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IMAGECELL", for: indexPath) as? PhotoCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        Cell.imageView.image = self.images[indexPath.row]
        
        return Cell
    }
    
}

extension PhotoViewer: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 14, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard let index = self.getCenterIndexPath() else {
            return
        }
        
//        guard self.images.count < index.row else {
//            return
//        }
        
        self.onSelection?(self.images[index.row])
        
    }
}

extension PhotoViewer {
    func prepare() {
        self.flowLayout.scrollDirection = .horizontal
        self.collection = UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
        self.collection?.translatesAutoresizingMaskIntoConstraints = false
        self.collection?.dataSource = self
        self.collection?.delegate = self
        self.collection?.isPagingEnabled = true
        self.collection?.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "IMAGECELL")
        guard let collection = self.collection else {
            return
        }
        self.addSubview(collection)
        self.constrain()
    }
    
    func constrain() {
        guard let collection = self.collection else {
            return
        }
        let views = ["collection": collection]
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[collection]|", options: [], metrics: nil, views: views)
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[collection]|", options: [], metrics: nil, views: views)
        self.addConstraints(vertical)
        self.addConstraints(horizontal)
    }
    
}
