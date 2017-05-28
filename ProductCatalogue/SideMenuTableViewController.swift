//
//  SideMenuTableViewController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/27/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
//This view controller is used to display the sideMenu, I have used SideMenu library to achieve this view

class SideMenuTableViewController: UITableViewController{
    @IBOutlet weak var aboutUsButton: UIButton!
    
    @IBOutlet weak var visitUsButton: UIButton!
    
    @IBOutlet weak var contactUsButton: UIButton!
    
    @IBAction func AboutUsAction(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "http://www.gopani.com/index.php/about-us/")! as URL, options: [:], completionHandler: nil)
    }

    
    @IBAction func visitUsAction(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "http://www.gopani.com")! as URL, options: [:], completionHandler: nil)
    }
    
    @IBAction func contactUsAction(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "http://www.gopani.com/index.php/contact-us/")! as URL, options: [:], completionHandler: nil)
    }
    
    
    @IBAction func callUsAction(_ sender: Any) {
        guard let number = URL(string: "telprompt://" + "+13155169163") else { return }
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        //print("SideMenu Appearing!")
        
        let imageView = UIImageView(image: UIImage(named: "stars.png"))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        tableView.backgroundView = imageView
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
    }
    

}
