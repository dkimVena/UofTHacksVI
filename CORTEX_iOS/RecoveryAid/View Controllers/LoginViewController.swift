//
//  LoginViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did load")
        
        textFieldEmail.layer.addBorder(edge: .bottom, color: .black, thickness: 0.5)
        textFieldPassword.layer.addBorder(edge: .bottom, color: .black, thickness: 0.5)
        
        if Auth.auth().currentUser?.uid != nil {
            self.performSegue(withIdentifier: "showTabBarViewController", sender: self)
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func pressedLogin(_ sender: Any) {
        guard let email = self.textFieldEmail.text, let password = self.textFieldPassword.text else {
            present(ErrorAlertViewController(title: "Oops", message: "Username or Password cannot be empty", preferredStyle: .alert), animated: true, completion: nil)
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.present(ErrorAlertViewController(title: "Oops", message: error.localizedDescription, preferredStyle: .alert), animated: true)
                return
            }
            self.performSegue(withIdentifier: "showTabBarViewController", sender: self)
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
