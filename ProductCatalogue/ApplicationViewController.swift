//
//  CategoryController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/14/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
import Kingfisher




class ApplicationViewController: UITableViewController{
    
    
    var applicationStore : ApplicationsStore! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Added observer to get notification when data is ready
        NotificationCenter.default.addObserver(self, selector: #selector(doAfterDataReady), name: Notification.Name(rawValue : (Notif.dataStoreNotif)), object: nil)
        
        //Calling application store initializer to instantiate the data store
        applicationStore = ApplicationsStore()
    }
    
    //This is executed when data is ready in the data store
    @objc func doAfterDataReady() {
        print(applicationStore.allApplications.count)
        self.applicationStore.printAllApplicationsAndURL()
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let application = applicationStore.allApplications[indexPath.section]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ApplicationCell", for: indexPath) as! ApplicationCell
        
        cell.applicationName.text = application.applicationName
        cell.currentIndex = (indexPath) as IndexPath
        if application.urlToimage != nil{
            if let url = URL(string: application.urlToimage!) {
                    cell.applicationImage.kf.setImage(with: url)
                    cell.applicationName.isHidden = true
            }
        }
        return cell
    }
    
    //Get number of sections in the table
    override func numberOfSections(in tableView: UITableView) -> Int {
        return applicationStore.allApplications.count
    }
    
    //As each section has only one row i.e each section for one application
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        let button = sender as! UIButton
        let cell = button.superview?.superview as! ApplicationCell
        if segue.identifier == "showAppPdf"{
            if let section = cell.currentIndex?.section{
                let application = applicationStore.allApplications[section]
                let destinationController = segue.destination as! ApplicationPdfController
                destinationController.pdfURL = application.urlToData
                destinationController.title = application.applicationName
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h = Int(view.bounds.size.height)
        return CGFloat(h/applicationStore.allApplications.count)
    }

}
