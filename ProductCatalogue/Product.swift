//
//  Product.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/26/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import Foundation

class Product{
    //Product members
    var productName: String = ""
    var productDescription: String?
    var productSpecs: String?
    var productPrice: Int?
    var productURL: String?
    var pictureURL: String?
    
    //Product initializer
    init(productName:String, productDescription:String? , productPrice: Int?, productURL:String?, pictureURL: String?, productSpecs: String?) {
        self.productName = productName
        self.productDescription = productDescription
        self.productPrice = productPrice
        self.productURL = productURL
        self.pictureURL = pictureURL
        self.productSpecs = productSpecs
    }
}
