//
//  ConnectionController.swift
//  4makers
//
//  Created by baptiste Fehrenbach on 19/01/2016.
//  Copyright © 2016 AwH. All rights reserved.
//

import UIKit

class ConnectionController: UIViewController {
    
    @IBOutlet weak var connectButton: UIButton!
    
    @IBOutlet weak var loginTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectButton.layer.cornerRadius = 3
    }
    
    @IBAction func connectButtonPressed(sender: AnyObject) {
        if passwordTextField.text != "" && loginTextField.text != "" {
            let user = loginTextField.text!
            let password = passwordTextField.text!
            if user.isEmail() == true || user.isPhone() == true {
                print(Api.connectURLString+user+"/"+password)
                let json = self.getJSON(Api.connectURLString+user+"/"+password)
                print(try! NSJSONSerialization.JSONObjectWithData(json, options: .AllowFragments))
                if try! NSJSONSerialization.JSONObjectWithData(json, options: .AllowFragments) as! Int != 0 {
                    loader.hidden = false
                    NSUserDefaults.standardUserDefaults().setValue(user, forKey: "user")
                    performSegueWithIdentifier("backToAppSegue", sender: self)
                } else {
                    errorLabel.text = "Erreur lors de l'authentification"
                }
            } else {
                errorLabel.text = "Please enter a correct mail or phone"
            }
        } else {
            errorLabel.text = "Please fill all the fields"
        }
    }
    
    func getJSON(urlToRequest: String) -> NSData{
        return NSData(contentsOfURL: NSURL(string: urlToRequest)!)!
    }
    
    func parseJSON(inputData: NSData) -> NSDictionary{
        let boardsDictionary: NSDictionary = try! NSJSONSerialization.JSONObjectWithData(inputData, options: .AllowFragments) as! NSDictionary
        
        return boardsDictionary
    }
}

extension String {
    func isEmail() -> Bool {
        let regex = try! NSRegularExpression(pattern: "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,4}$",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
    
    func isPhone() -> Bool {
        let regex = try! NSRegularExpression(pattern: "#^0[0-9]([ .-]?[0-9]{2}){4}$#",
            options: [.CaseInsensitive])
        
        return regex.firstMatchInString(self, options:[],
            range: NSMakeRange(0, utf16.count)) != nil
    }
}