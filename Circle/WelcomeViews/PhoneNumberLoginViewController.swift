//
//  PhoneNumberLoginViewController.swift
//  Circle
//
//  Created by Kumar Rounak on 02/09/18.
//  Copyright © 2018 Kumar Rounak. All rights reserved.
//

import UIKit
import FirebaseAuth
import ProgressHUD

class PhoneNumberLoginViewController: UIViewController {
    
    @IBOutlet weak var countryCodeTextField: UITextField!
    @IBOutlet weak var mobileNumberTextField: UITextField!
    @IBOutlet weak var codetextField: UITextField!
    @IBOutlet weak var requestButtonOutlet: UIButton!
    
    
    var phoneNumber: String!
    var verificationId: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryCodeTextField.text = CountryCode().currentCode
    }
    
    //MARK: IBActions
    
    @IBAction func requestButtonPressed(_ sender: Any) {
        
        //register
        if verificationId != nil {
            registerUser()
            return
        }
        
        //request code
        if mobileNumberTextField.text != "" && countryCodeTextField.text != "" {
            
            let fullNumber = countryCodeTextField.text! + mobileNumberTextField.text!
            
            PhoneAuthProvider.provider().verifyPhoneNumber(fullNumber, uiDelegate: nil) { (_verificationId, error) in
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                self.verificationId = _verificationId
                self.updateUI()
            }
            
        } else {
            ProgressHUD.showError("Phone number is required!")
        }
    }
    
    //MARK: Helpers
    
    func updateUI() {
        
        requestButtonOutlet.setTitle("Submit", for: .normal)
        phoneNumber = countryCodeTextField.text! + mobileNumberTextField.text!
        
        countryCodeTextField.isEnabled = false
        mobileNumberTextField.isEnabled = false
        mobileNumberTextField.placeholder = mobileNumberTextField.text!
        mobileNumberTextField.text = ""
        
        codetextField.isHidden = false
    }
    
    func registerUser() {
        
        if codetextField.text != "" && verificationId != nil {
            
            FUser.registerUserWith(phoneNumber: phoneNumber, verificationCode: codetextField.text!, verificationId: verificationId) { (error, shouldLogin) in
                
                
                if error != nil {
                    ProgressHUD.showError(error!.localizedDescription)
                    return
                }
                
                if shouldLogin {
                    //go to app
                    self.goToApp()
                } else {
                    self.performSegue(withIdentifier: "welcomeToFinishSeg", sender: self)
                }
            }
        } else {
            ProgressHUD.showError("Please insert the code!")
        }
    }
    
    
    func goToApp() {
        
        ProgressHUD.dismiss()
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: USER_DID_LOGIN_NOTIFICATION), object: nil, userInfo: [kUSERID : FUser.currentId()])
        
        
        let mainView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "mainApplication") as! UITabBarController
        
        self.present(mainView, animated: true, completion: nil)
    }
    
}
