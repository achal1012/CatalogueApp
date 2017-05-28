//
//  SignInViewController.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/20/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
import UIKit
import Firebase
import GoogleSignIn

@objc(SignInViewController)
class SignInViewController: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    var handle: AuthStateDidChangeListenerHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        handle = Auth.auth().addStateDidChangeListener() { (auth, user) in
            if user != nil {
                self.performSegue(withIdentifier: "goToApp", sender: nil)
            }
        }
    }
    deinit {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
}
