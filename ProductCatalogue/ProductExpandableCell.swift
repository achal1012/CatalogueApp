
//
//  productExpandableCell.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/27/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit

class ProductExpandableCell: UITableViewCell{
    
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productDetailsLabel: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var detailsSubView: UIView!
    
    
    var title: String? {
        didSet {
            productNameLabel.text = title
        }
    }
    
    var detail: String? {
        didSet {
            productDetailsLabel.text = detail
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.arrangedSubviews.last?.isHidden = true
    }


}
