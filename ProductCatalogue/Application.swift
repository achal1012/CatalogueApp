//
//  ApplicationsData.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/18/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit

class Application : NSObject{
    //Application members
    var applicationName : String
    var urlToData: String?
    var urlToimage: String?
    
    //Application initializer
    init(applicationName: String, urltoData: String?,urlToImage:String? ){
        self.applicationName = applicationName
        self.urlToData = urltoData
        self.urlToimage = urlToImage
        super.init()
    }
    
}
