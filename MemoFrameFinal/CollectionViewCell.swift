//
//  CollectionViewCell.swift
//  MemoFrameFinal
//
//  Created by Muddasar Hussain on 07.05.2017.
//  Copyright © 2017 Christopher Reyes. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var celleBilde: UIImageView!
    
    func setGalleryItem(_ item:UIImageView) {
        celleBilde = item
    }

}
