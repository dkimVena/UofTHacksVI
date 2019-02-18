//
//  SignUpViewController.swift
//  RecoveryAid
//
//  Created by Jacob Goldfarb on 2019-01-19.
//  Copyright © 2019 Jacob Goldfarb. All rights reserved.
//

import UIKit
import Firebase


class SignUpViewController: UIViewController {
    
    @IBOutlet var textFieldEmail: UITextField!
    @IBOutlet var textFieldPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Did load")
        
        textFieldEmail.layer.addBorder(edge: .bottom, color: .black, thickness: 0.5)
        textFieldPassword.layer.addBorder(edge: .bottom, color: .black, thickness: 0.5)
        
        
        
        // Do any additional setup after loading the view.
    }
    @IBAction func pressedSignUp(_ sender: Any) {
        guard let email = textFieldEmail.text,
            let password = textFieldPassword.text else {
                let alertVC = ErrorAlertViewController(title: "Oops", message: "Invalid username/password", preferredStyle: .alert)
                present(alertVC, animated: true, completion: nil)
                return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) {(authResult, error) in
            guard error == nil else {
                let alertVC = ErrorAlertViewController(title: "Oops", message: error!.localizedDescription, preferredStyle: .alert)
                self.present(alertVC, animated: true)
                return
            }
            FirebaseManager.shared.setNewUser(userName: email.components(separatedBy: "@")[0])
            self.performSegue(withIdentifier: "showTabBarController", sender: self)
//            self.present(TabBarController(), animated: true)
            
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
