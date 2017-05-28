//
//  ProductStore.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/26/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import Foundation
import Firebase


class ProductStore{
    //Products are stored in 2D array this is done to get them displayed in two rows in the view
    var products: [[Product]] = [[],[]]
    var ref: DatabaseReference!
    
    init(){
        //This gets us a background thread to read all the data from the server and generates a notification when the data load is finished
        DispatchQueue.global().async {
            self.ref = Database.database().reference()
            self.ref.child("products").observeSingleEvent(of: .value, with: { snapshot in
                let array = snapshot.value as? NSArray
                //This odd var will help us deside where to put the product at 0th index or at 1st index
                var odd = 0
                for subArray in array!{
                    let dictionary = subArray as! NSDictionary
                    let productName = dictionary.value(forKey: "productName")! as! String
                    let productDescription = dictionary.value(forKey: "productDescription")! as! String
                    let productURL = dictionary.value(forKey: "productURL")! as! String
                    let productPrice = Int(dictionary.value(forKey: "productPrice")! as! String)
                    let pictureURL = dictionary.value(forKey: "pictureURL")! as! String
                    
                    let productSpecs = dictionary.value(forKey: "productSpecs")! as! String
                    
                    let product = self.createProduct(ProductName: productName, productDescription: productDescription, productPrice: productPrice, productURL: productURL, pictureURL: pictureURL, productSpecs: productSpecs)
                    self.products[odd].append(product)
                    //Toggeling the odd var at each loop run
                    if odd == 0 {
                        odd = 1
                    }
                    else{
                        odd = 0
                    }
                }
                //This generates notification which is caught by the viewController and processed upon
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notif.productStoreNotif), object: nil)
            })
        }
    }
    
    //Product generator
    func createProduct(ProductName productName:String, productDescription:String? , productPrice: Int?, productURL:String?, pictureURL: String?,productSpecs: String?) -> Product{
        let product = Product(productName: productName, productDescription: productDescription, productPrice: productPrice, productURL: productURL, pictureURL: pictureURL, productSpecs: productSpecs)
        return product
    }
    
}
