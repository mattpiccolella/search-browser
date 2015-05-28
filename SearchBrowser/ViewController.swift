//
//  ViewController.swift
//  SearchBrowser
//
//  Created by Matt on 5/27/15.
//  Copyright (c) 2015 Matthew Piccolella. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {
    
    var searchMode: Bool = false
    @IBOutlet var verticalSearchCenter: NSLayoutConstraint!
    @IBOutlet var searchBox: UITextField!
    @IBOutlet var appLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.appLabel.hidden = true
    
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.searchMode = true
            let offset: CGFloat = self.searchMode ? 250.0 : 0.0
            self.verticalSearchCenter.constant = offset
        }, completion: { (value:Bool) -> Void in
            println("Finished")
        })
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.appLabel.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.searchBox.resignFirstResponder()
        self.searchMode = true
        self.appLabel.hidden = true
        let searchString = "http://www.google.com/search?q=" + self.searchBox.text
        let encodedString = searchString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let searchURL:NSURL? = NSURL(string:encodedString!)
        let webView:UIWebView = UIWebView(frame: CGRectMake(0, 100, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height-100))
        webView.loadRequest(NSURLRequest(URL: searchURL!))
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.verticalSearchCenter.constant = 250
            println(searchURL)
            self.view.addSubview(webView)
            }, completion: { (value:Bool) -> Void in
                println("\(self.searchBox.center.y)")
        })
        return true
    }

}

