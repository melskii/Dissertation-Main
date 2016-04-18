//
//  UserViewController.swift
//  Dissertation-IOS-SpriteKit
//
//  Created by Mel Schatynski on 21/02/2016.
//  Copyright (c) 2016 Mel Schatynski. All rights reserved.
//

import UIKit
import SpriteKit
import Foundation



protocol KeyboardDelegate {
    
    func numberKeyboard(button: UIButton)
    
}

class UserViewController: UIViewController, KeyboardDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var skview: SKView!
    @IBOutlet var txtParticipant: UITextField!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var lblError: UILabel!
    
    @IBOutlet var keyboardView: NumberView!


    override func loadView() {
        
        super.loadView()
        
        keyboardView.delegate = self

    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lblError.hidden = true
        txtName.text = USER.getUsersName()
        
        txtParticipant.delegate = self
        txtName.delegate = self
    
        
    }
    
    //Is Executing everytime a button in the custom keyboard is pressed and returns the value to txtParticipant
    func numberKeyboard(button: UIButton) {
        
        
        var text = txtParticipant.text
        
        if button.tag >= 0 {
           
        
            
           txtParticipant.text = text! + String(button.tag)
            
            
        }
        
        else {
            
            
            if button.titleLabel?.text == "Del" {
                
                if txtParticipant.text != "" {
                    
                  
                    text?.removeAtIndex((text?.endIndex.predecessor())!)
                    
                    txtParticipant.text = text
                   
                    
                }
            }
            else {
                
                keyboardView.hidden = true
                
            }
        }
        
    }

    //Validates the participant and name field and calls the UserModel
    @IBAction func btnOKTouchDown(sender: AnyObject) {
        
        lblError.text = ""
        lblError.hidden = true
        
        
        let name = txtName.text
        let id = txtParticipant.text == "" ? nil : txtParticipant.text
        
        if Regex(regex: "(([a-z]|[A-Z])+(\\s?))+", text: name).match() {
         
            
            USER.setUsersName(name!)
            
            if Regex(regex: "(\\d+)", text: id).match() {
                
                self.lblError.hidden = false
                self.lblError.text = "Connecting..."
            
                USER.setUserDetails(id!) {
                    (status: UserStatus) in
                    if status == UserStatus.Active
                    {
                        self.returnToPreviousController()
                        USER.syncProgress(0)
                    
                    }
                    
                    else if status != UserStatus.Active {

                    
                        self.lblError.hidden = false
                        self.lblError.text = "Participant Error: \(status.rawValue)"
                        
                    }
                    
                }
            }
            
            else if (id == nil) {
                
                self.returnToPreviousController()
                
            }
            
        }
        
        else {
            
        
            if let tf = self.txtName {
                
                tf.text = ""
            }
            
            
            lblError.text = "Enter a Name or Press Cancel"
            lblError.hidden = false
            
        }
        
    }
    
  
    //Returns to the previous controller without destroying anything
    @IBAction func btCancelTouchDown(sender: AnyObject) {
        
        returnToPreviousController()
    }
    
    //Updates Labels in the previous controller
    func returnToPreviousController() {
        
        
        
        let presenting = self.presentingViewController
        
        if presenting != nil {
            
            if presenting is GameViewController {
                
                let game = presenting as! GameViewController
                game.setUserLabel()
                
            }
            
            if presenting is HomeViewController {
                
                let home = presenting as! HomeViewController
                home.setUserLabel()
                
            }
            
        }
       
        self.dismissViewControllerAnimated(true, completion: {});
        

    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}


//Additional Functionality for the TextBox's and the Keyboard
extension UserViewController {
    
    //Shows the custom Keyboard
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        
        if textField == txtParticipant {
            view.endEditing(true)
            keyboardView.hidden = false
            return false
        }
        
        return true
        
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == txtParticipant {
            keyboardView.hidden = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField == txtName {
            self.view.endEditing(true)
        }
            
        else {
            
            
            textField.resignFirstResponder()
            
            
        }
        
        return true
    }

}

//Additional Class is used to check the Participant and Name TextFields.
class Regex {
    
    let regex: String!
    let text: String!
    
    init(regex: String!, text: String!) {
        
        self.regex = regex
        self.text = text
        
    }
    
    
    func match() -> Bool {
        
        if text == nil {
            
            return false
        }
        
        do {
            
            let regex = try NSRegularExpression(pattern: self.regex, options: [])
            let nsString = self.text as NSString
            
            let results = regex.matchesInString(text,
                options: [], range: NSMakeRange(0, nsString.length))
            
            return results.count == 1 ? true : false
            
        } catch let error as NSError {
            
            print("invalid regex: \(error.localizedDescription)")
            return false
            
        }
    }

    
    
}
