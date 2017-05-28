//
//  ApplicationsStore.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/19/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
import Firebase

class ApplicationsStore{
    var allApplications = [Application]()
    
    //retrieve data from database 
    var ref: DatabaseReference!

    init() {
        //This gets us a background thread to read all the data from the server and generates a notification when the data load is finished
        DispatchQueue.global().async {
            self.ref = Database.database().reference()
            //Parsing data from firebase database which is in the format of JSON
            self.ref.child("application").observeSingleEvent(of: .value, with: { snapshot in
                let array = snapshot.value as? NSArray
                for subArray in array!{
                    let dictionary = subArray as! NSDictionary
                    let name = dictionary.value(forKey: "Name")! as! String
                    let url = dictionary.value(forKey: "URL")! as! String
                    let imageURL = dictionary.value(forKey: "imageURL") as! String?
                    let appData = self.createApplicationsData(Name: name, URL: url, imageURL: imageURL)
                    self.allApplications.append(appData)
                }
                //This generates a notification which is read by the viewController and it takes actions accordingly
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: Notif.dataStoreNotif), object: nil)
            })
        }

    }


    //Application generator
    func createApplicationsData(Name name:String, URL:String, imageURL:String?) -> Application{
        let appData = Application(applicationName: name, urltoData: URL, urlToImage: imageURL)
        return appData
    }
    
    //Debug function to see that all the applications are loaded in the store
    func printAllApplicationsAndURL(){
        for app in allApplications{
            print("Name : \(app.applicationName) URL: \(String(describing: app.urlToData))")
        }
    }
    
}
