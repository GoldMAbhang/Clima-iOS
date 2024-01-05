//
//  SignupViewController.swift
//  Clima
//
//  Created by Goldmedal on 29/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//  Completed by Abhang Mane @Goldmedal

import UIKit

protocol SignupViewDelegate{
    func prefilledUsername(prefilledUsername:String)
}

class SignupViewController: UIViewController, UserBrainDelegate {
    func sendUsername(usernameSaved: String) {
        print(usernameSaved)
    }
    
    
    @IBOutlet weak var createusernameTextField: UITextField!
    @IBOutlet weak var createpasswordTextField: UITextField!
    
    var userBrain = UserBrain()
    
    var delegate:SignupViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userBrain.delegate = self
    }
    
    @IBAction func signupButton(_ sender: UIButton) {
        let createUsername=createusernameTextField.text
        let createPassword=createpasswordTextField.text
        if createusernameTextField.text != "" && createpasswordTextField.text != ""{
            if userBrain.addUsers(newUsername: createUsername!,newPassword: createPassword!) == true{
                signupSuccess()
            }
            else if userBrain.addUsers(newUsername: createUsername!,newPassword: createPassword!) == false{
                existsAlert()
            }
            
        }
        else{
            requiredSignupAlert()
        }
        
    }
    
    func signupSuccess(){
        let signupAlert = UIAlertController(title: "Alert", message: "Signup Successful Go Back To Login", preferredStyle: UIAlertController.Style.alert)
        signupAlert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: navigateToLoginController))
        self.present(signupAlert, animated: true)
        }
    
    func requiredSignupAlert(){
        let requiredalert = UIAlertController(title: "Alert", message: "Please enter the required details", preferredStyle: UIAlertController.Style.alert)
        
        requiredalert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(requiredalert, animated: true, completion: nil)
    }
    
    
    func existsAlert(){
        let existsalert = UIAlertController(title: "Alert", message: "Username exists.Please enter unique username.", preferredStyle: UIAlertController.Style.alert)
        
        existsalert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(existsalert, animated: true, completion: nil)
    }
    
    func navigateToLoginController(alert: UIAlertAction!){
        self.delegate?.prefilledUsername(prefilledUsername: createusernameTextField.text!)
        navigationController?.popViewController(animated: true)
    }
}
