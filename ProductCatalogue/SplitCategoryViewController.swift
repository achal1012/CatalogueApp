//
//  SplitCategoryViewController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/24/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
import FSPagerView
import Firebase
import SideMenu

import Kingfisher

//This view controller is for Home view
class SplitCategoryViewController : UIViewController,UITableViewDataSource,UITableViewDelegate,FSPagerViewDataSource,FSPagerViewDelegate {
    
    fileprivate let categoryStore = ["Applications", "Products"]
    fileprivate let imageNames = ["1.jpg","2.jpg","Banner1.png"]
    
    //Signout button
    @IBAction func signOutButton(_ sender: UIButton) {
        print(#function)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: \(signOutError.localizedDescription)")
        }
    }

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.pagerView.delegate = self
        self.pagerView.dataSource = self
        self.tableView.isScrollEnabled = false
        manageSliderView()
    }
    
    //This function sets required properties for the side view
    func manageSliderView(){
         SideMenuManager.menuWidth = view.frame.width/2.5
         let styles:[UIBlurEffectStyle] = [.dark, .light, .extraLight]
         SideMenuManager.menuBlurEffectStyle = styles[2]
    }
    
    //initializing the pagerview
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
            self.pagerView.itemSize = .zero
            self.pagerView.automaticSlidingInterval = 4
        }
    }

    //initializing the pagecontrol
    @IBOutlet weak var pageControl: FSPageControl! {
        didSet {
            self.pageControl.numberOfPages = imageNames.count
            self.pageControl.contentHorizontalAlignment = .right
            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        }
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CategoryCell
        if indexPath.section == 0{
            cell.categoryImage.image = UIImage(named: "Application.png")
        }
        else{
            cell.categoryImage.image = UIImage(named: "Product.png")
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.categoryStore.count
    }
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return imageNames.count
    }
    
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = UIImage(named: self.imageNames[index])
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        //cell.textLabel?.text = ""//index.description+index.description
        return cell
    }
    
    //This function is invoked when user clicks an image
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        self.pageControl.currentPage = index
    }
    
    //pager view scroller helper
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        guard self.pageControl.currentPage != pagerView.currentIndex else {
            return
        }
        self.pageControl.currentPage = pagerView.currentIndex
    }
    
    //This will get us the cells of right size
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = super.view.bounds.height
        return h/3.9
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //Segue perform helper
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        if categoryStore[section] == "Applications"{
            performSegue(withIdentifier: "showApplications", sender: self)
        }
        if categoryStore[section] == "Products"{
            performSegue(withIdentifier: "showProducts", sender: self)
        }
    }

}
