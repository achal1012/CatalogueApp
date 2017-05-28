//
//  ProductSpecsCell.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/28/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit


class ProductSpecsCell : UITableViewCell {
    

    @IBOutlet weak var specDetailsLabel: UILabel!
    
    @IBOutlet weak var specsStackView: UIStackView!
    
    @IBOutlet weak var specsSubView: UIView!

    
    var detail: String? {
        didSet {
            specDetailsLabel.text = detail
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        specsStackView.arrangedSubviews.last?.isHidden = true
    }
   
}
