//
//  ProductViewController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/26/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit

import Kingfisher


class ProductViewController : UITableViewController{
    
    var productStore : ProductStore! = ProductStore()
    fileprivate var sections = 0
    fileprivate var oddNumOfProducts  = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //This catches the notification from the ProductStore and upon reciving the notification it executes doafterproductsready function
        NotificationCenter.default.addObserver(self, selector: #selector(doafterproductsready), name: Notification.Name(rawValue : (Notif.productStoreNotif)), object: nil)
    }
    
    //This is executed when data is ready in the data store
    @objc func doafterproductsready() {
        //print(productStore.products.count)
        tableView.reloadData()
    }
    
    //All the image loads in this function use Kingfisher library to do async downloads and caching
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath)  as! ProductCell
        cell.currentIndex = indexPath
        //This is for the last odd number item which should be placed at the bottom left
        if indexPath.section == sections-1 && self.productStore.products[0].count > self.productStore.products[1].count{
            let leftProduct = productStore.products[0][indexPath.section]
            cell.disableRightTile()
            cell.productTileLeft.setTitle(self.productStore.products[0][indexPath.section].productName, for: .normal)
            //Set backgorund Image
            if leftProduct.pictureURL != nil{
                if let url = URL(string: leftProduct.pictureURL!) {
                        cell.productTileLeft.kf.setBackgroundImage(with: url, for: .normal)
                }
            }
            return cell
        }
        //For left side tiles
        let leftProduct = productStore.products[0][indexPath.section]
        cell.productTileLeft.setTitle(leftProduct.productName, for: .normal)
        cell.productTileRight.setTitleShadowColor(UIColor.black, for: .normal)
        if leftProduct.pictureURL != nil{
            if let url = URL(string: leftProduct.pictureURL!) {
                    cell.productTileLeft.kf.setBackgroundImage(with: url, for: .normal, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
        //For right side tiles
        let rightProduct = productStore.products[1][indexPath.section]
        cell.productTileRight.setTitle(rightProduct.productName, for: .normal)
        if rightProduct.pictureURL != nil{
            if let url = URL(string: rightProduct.pictureURL!) {
                cell.productTileRight.kf.setBackgroundImage(with: url, for: .normal)
            }
        }
        return cell
    }
    
    //This function returns requred number of sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        sections = self.productStore.products[0].count
        return sections
    }
    
    //This function returns 1 as each section has only one row
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //This function will decide which button was clicked and what data to send in the segue call
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let button = sender as! UIButton
        let cell = button.superview?.superview as! ProductCell
        
        if segue.identifier == "leftProductDetailSegue"{
            if let section = cell.currentIndex?.section{
                let product = self.productStore.products[0][section]
                let destinationController = segue.destination as! ProductDetailsViewController
                destinationController.product = product
                destinationController.title = product.productName
            }
        }
        else if segue.identifier == "rightProductDetailSegue"{
            if let section = cell.currentIndex?.section{
                let product = self.productStore.products[1][section]
                let destinationController = segue.destination as! ProductDetailsViewController
                destinationController.product = product
                destinationController.title = product.productName
            }
        }
    }
}
