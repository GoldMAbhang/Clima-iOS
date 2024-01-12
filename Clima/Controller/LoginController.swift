//
//  LoginController.swift
//  Clima
//
//  Created by Goldmedal on 29/12/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var userBrain = UserBrain()
    var signupViewDelegate = SignupViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signupViewDelegate.delegate = self
        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func loginPressed(_ sender: UIButton) {
        usernameTextField.endEditing(true)
        let usernameEntered = usernameTextField.text
        let passwordEntered = passwordTextField.text
        
        if userBrain.isValid(username: usernameEntered!, password: passwordEntered!){
           
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WeatherViewController") as? WeatherViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        else if usernameTextField.text == "" && passwordTextField.text == ""{
            requiredLoginAlert()
        }
        
        else{
            showAlert()
        }
    }
    
    //if pressed push to next controller
    @IBAction func goToSignupPressed(_ sender: UIButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignupViewController") as? SignupViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
    
    func showAlert(){
        let alert = UIAlertController(title: "Alert", message: "Incorrect username or password", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func requiredLoginAlert(){
        let alert = UIAlertController(title: "Alert", message: "Please enter the required details", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        passwordTextField.endEditing(true)
        print(passwordTextField.text!)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        passwordTextField.text = ""
    }
}

//MARK: - SignupViewDelegate
extension LoginController:SignupViewDelegate{
    func prefilledUsername(prefilledUsername: String) {
        self.usernameTextField.text = prefilledUsername
        print(prefilledUsername)
    }
    
//    func prefilledUsername(prefilledUsername: String) {
//        self.usernameTextField.text = prefilledUsername
//        print(prefilledUsername)
//    }
}
