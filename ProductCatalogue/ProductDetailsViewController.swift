//
//  ProductDetailsViewController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/27/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
let estimatedHeight: CGFloat = 150
let topInset: CGFloat = 20
class ProductDetailsViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
    
    @IBOutlet weak var productDetailImageView: UIImageView!
    
    //This will be passed from calling view controller using segue
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.contentInset.top = topInset
        tableView.estimatedRowHeight = estimatedHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        self.getImage()
    }
    
    //This uses kingfisher library to download and cache the data
    func getImage() {
        if product?.pictureURL != nil{
            if let url = URL(string: (product?.pictureURL!)!) {
                productDetailImageView.kf.setImage(with: url)
            }
        }
    
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
 
    //Table view data source
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        if indexPath.row == 0{
            let priceCell = tableView.dequeueReusableCell(withIdentifier: "pPrice", for: indexPath) as! ProductPriceCell
            if let price = product?.productPrice{
                let p = String(price)
                priceCell.productPriceLable.text = p.appending("$")
            }
            else{
                priceCell.productPriceLable.text = "Contact us for price!"
            }
            return priceCell
        }
        else if indexPath.row == 1{
        
        let detailCell = tableView.dequeueReusableCell(withIdentifier: "pDetails", for: indexPath) as! ProductExpandableCell
        detailCell.productNameLabel.text = product?.productName
        detailCell.productDetailsLabel.text = product?.productDescription
        return detailCell
        }
        
        let specCell = tableView.dequeueReusableCell(withIdentifier: "pSpecs", for: indexPath) as! ProductSpecsCell
        //Spec Cell
        specCell.specDetailsLabel.text = product?.productSpecs
        return specCell
    }
  
    
   //This will help in hiding of the subview of the cell
   func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
    if indexPath.row == 1{
        if let selectedIndex = tableView.indexPathForSelectedRow, selectedIndex == indexPath {
            
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! ProductExpandableCell
            cell.detailsSubView.isHidden = true
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.endUpdates()
            return nil
            }
        }
    else if indexPath.row == 2{
        if let selectedIndex = tableView.indexPathForSelectedRow, selectedIndex == indexPath {
            
            tableView.beginUpdates()
            let cell = tableView.cellForRow(at: indexPath) as! ProductSpecsCell
            cell.specsSubView.isHidden = true
            tableView.deselectRow(at: indexPath, animated: true)
            tableView.endUpdates()
            
            return nil
            }
        }
        return indexPath
    }
    
    
    //This function will help in unhiding the details of the selected section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 1{
            let cell = tableView.cellForRow(at: indexPath) as! ProductExpandableCell
            cell.detailsSubView.isHidden = false
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        else if indexPath.row == 2{
            let cell = tableView.cellForRow(at: indexPath) as! ProductSpecsCell
            cell.specsSubView.isHidden = false
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    //This tap will take the user to the product buying page
    @IBAction func didTapBuyButton(sender: AnyObject) {
        UIApplication.shared.open(NSURL(string: (product?.productURL)!)! as URL, options: [:], completionHandler: nil)
    }
    
}


