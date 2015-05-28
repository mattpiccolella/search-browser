//
//  ViewController.swift
//  SearchBrowser
//
//  Created by Matt on 5/27/15.
//  Copyright (c) 2015 Matthew Piccolella. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate {
    
    var searchMode: Bool = false
    let topOffset: CGFloat = 260
    let webViewOffset: CGFloat = 100
    let transitionDelay: NSTimeInterval = 0.2
    var webView: UIWebView!

    @IBOutlet var verticalCenterConstraint: NSLayoutConstraint!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var appLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchBar.showsCancelButton = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        self.appLabel.hidden = true
            
        println("HERE")
        self.webView?.removeFromSuperview()
        
        UIView.animateWithDuration(self.transitionDelay, animations: { () -> Void in
            self.searchMode = true
            self.transitionSearchBar()
            }, completion: { (value:Bool) -> Void in
                println("Finished")
        })
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.searchMode = true
        self.appLabel.hidden = true
        let searchString = "http://www.google.com/search?q=" + self.searchBar.text
        let encodedString = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let searchURL:NSURL? = NSURL(string:encodedString!)
        let webView:UIWebView = UIWebView(frame: CGRectMake(0, self.webViewOffset, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-self.webViewOffset))
        webView.loadRequest(NSURLRequest(URL: searchURL!))
        UIView.animateWithDuration(self.transitionDelay, animations: { () -> Void in
            self.transitionSearchBar()
            self.view.addSubview(webView)
            self.webView = webView
            }, completion: { (value:Bool) -> Void in

        })
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchMode = false
        UIView.animateWithDuration(self.transitionDelay, animations: { () -> Void in
            self.searchBar.text = ""
            self.appLabel.hidden = false
            self.transitionSearchBar()
        }, completion: { (value: Bool) -> Void in
            
        })
    }
    
    func transitionSearchBar() {
        let offset: CGFloat = self.searchMode ? self.topOffset : 0.0
        self.verticalCenterConstraint.constant = offset
    }

}

