//
//  WebViewController.swift
//  Reader
//
//  Created by kensuke tanaka on 11/23/15.
//  Copyright © 2015 kentana20. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate    {

    @IBOutlet var webview :UIWebView! = UIWebView()
    var newsUrl = "http://google.com/"
    var indicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webview.delegate = self
        indicator.center = self.view.center
        indicator.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.White
        indicator.backgroundColor = UIColor.blackColor()
        indicator.alpha = 0.75
        webview.addSubview(indicator)
        
        let url = NSURL(string :newsUrl)!
        let urlRequest = NSURLRequest(URL: url)
        
        webview.loadRequest(urlRequest)
        
    }
    
    func webviewDidStartLoad(webview: UIWebView) {
        indicator.startAnimating()
    }
    
    func webviewDidFinishLoad(webview: UIWebView) {
        indicator.stopAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
