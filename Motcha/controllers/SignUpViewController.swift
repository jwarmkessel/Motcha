//
//  SignUpViewController.swift
//  Motcha
//
//  Created by Justin Warmkessel on 2/10/23.
//

import UIKit

class SignUpViewController: UIViewController {
    
    private let TAG = "SignUpViewController"
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    
    @IBAction func signUpAction(_ sender: UIButton, forEvent event: UIEvent) {
        guard let email = emailTextField.text,
              let password = passwordTextField.text,
              let fullName = fullNameTextField.text
        else {
            
            return
        }
        
        if email.isEmpty && password.isEmpty && fullName.isEmpty {
            return
        }
        
        AuthService.signUp(username: email, password: password, options: fullName) {
            success in
            if success {
                DispatchQueue.main.async {
                    self.didSignInSucceed(username: email)
                }
            } else {
                print("\(self.TAG) sign in failed")
            }
        }
    }
    
    private func didSignInSucceed(username: String) {
        Utils.setUserDefaultsString(value: username, forKey: K.usernameKey)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let tabBarController = storyboard.instantiateViewController(identifier: K.tabBarControllerId) as UITabBarController
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(tabBarController)
    }
}
