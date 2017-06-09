//
//  PhotoCollectionViewCell.swift
//  MLTest
//
//  Created by Jon Vogel on 6/8/17.
//  Copyright © 2017 Conifer Apps. All rights reserved.
//

import UIKit


class PhotoCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(frame: .zero)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prepare()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepare()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.prepare()
    }
    
    
}

extension PhotoCollectionViewCell {
    func prepare() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.contentMode = .scaleAspectFit
        self.addSubview(self.imageView)
        self.constrain()
    }
    
    func constrain() {
        let views = ["image": self.imageView]
        let vertical = NSLayoutConstraint.constraints(withVisualFormat: "V:|[image]|", options: [], metrics: nil, views: views)
        let horizontal = NSLayoutConstraint.constraints(withVisualFormat: "H:|[image]|", options: [], metrics: nil, views: views)
        self.addConstraints(vertical)
        self.addConstraints(horizontal)
    }
}
