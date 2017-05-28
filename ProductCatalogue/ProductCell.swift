//
//  ProductCell.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/26/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit

class ProductCell: UITableViewCell{

    var currentIndex : IndexPath?
    
    @IBOutlet weak var productTileLeft: UIButton!
    @IBOutlet weak var productTileRight: UIButton!
    
    func disableRightTile(){
        productTileRight.isEnabled = false
        productTileRight.isHidden = true
    }
}
