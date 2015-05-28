//
//  ViewController.swift
//  SearchBrowser
//
//  Created by Matt on 5/27/15.
//  Copyright (c) 2015 Matthew Piccolella. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

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
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.appLabel.hidden = false
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.searchBox.resignFirstResponder()
        
        self.appLabel.hidden = true
        return true
    }

}

