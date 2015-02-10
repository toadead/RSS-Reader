//
//  DetailViewController.swift
//  RSS Reader
//
//  Created by Yu Andrew - andryu on 1/6/15.
//  Copyright (c) 2015 Andrew Yu. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var link: String?

    func configureView() {
        if let link = self.link {
            let url = NSURL(string: link)
            let request = NSURLRequest(URL: url!)
            webView.loadRequest(request)
        } else {
            println("link is nil")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func webViewDidStartLoad(webView: UIWebView) {
        activityIndicator.startAnimating()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        activityIndicator.stopAnimating()
    }

}

