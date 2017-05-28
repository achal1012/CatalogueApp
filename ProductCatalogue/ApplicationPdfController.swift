//
//  applicationPdfViewer.swift
//  ProductCatalogue
//
//  Created by Achal Velani on 4/20/17.
//  Copyright © 2017 Achal Velani. All rights reserved.
//

import UIKit
//This viewController is used to display pdfs hosted on the server on a web view
class ApplicationPdfController : UIViewController{

    @IBOutlet weak var webView: UIWebView!
    
    var pdfURL : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = pdfURL
        if url != "" {
            if let urla = URL(string: url!){
                webView.loadRequest(URLRequest(url: urla))
            }
        }
        else {
            webView.loadRequest(URLRequest(url:URL(string: "")!))
        }
        webView.scalesPageToFit = true
    }
}
